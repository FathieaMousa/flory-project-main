import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../screens/loginScreens/SignInScreen.dart';
import '../../../../screens/navigation_items/profile_items/re_authenticate_user_login_form.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/loader/loaders.dart';
import '../../../../utils/network/network_manager.dart';
import '../../models/user_model.dart';
import '../register/register_controller.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  //
  final GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final imageUploading = false.obs;

  //
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final hidePassword = false.obs;

  //
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  //
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // save userRecord from any registration provider.
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final fullName = userCredentials.user!.displayName ?? '';
        final registerController = Get.find<RegisterController>();

        // Map data
        final user = UserModel(
          id: userCredentials.user!.uid,
          fullName: fullName,
          gender: registerController.selectedGender.value,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );
        // save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      Loaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your info. you can resave your data in your profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ), // ElevatedButton
    );
    // OutlinedButton
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      THelperFunctions.openLoadDialog('Processing', TImages.loaderAsset);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          THelperFunctions.stopLoading();
          Get.offAll(() => const SignInScreen());
        } else if (provider == 'password') {
          THelperFunctions.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      THelperFunctions.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      THelperFunctions.openLoadDialog('Processing', TImages.loaderAsset);

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        THelperFunctions.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        THelperFunctions.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await AuthenticationRepository.instance.deleteAccount();
      THelperFunctions.stopLoading();
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      THelperFunctions.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Change password method
  Future<void> changePassword() async {
    try {
      if (newPassword.text.trim() != confirmPassword.text.trim()) {
        Loaders.warningSnackBar(
          title: "Error",
          message: "New password and confirmation do not match",
        );
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Loaders.warningSnackBar(
          title: "Error",
          message: "No user is logged in.",
        );
        return;
      }
      // reauthenticate with the current password
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword.text.trim(),
      );

      await user.reauthenticateWithCredential(cred);

      // update the password
      await user.updatePassword(newPassword.text.trim());

      Loaders.successSnackBar(
        title: "Success",
        message: "Password changed successfully!",
      );

      // clear fields
      currentPassword.clear();
      newPassword.clear();
      confirmPassword.clear();
    } catch (e) {
      Loaders.warningSnackBar(title: "Error", message: e.toString());
    }
  }

  ///Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512.h,
        maxWidth: 512.w,
      );
      if (image != null) {
        imageUploading.value = true;
        //Upload Image
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile',
          image,
        );

        //Update User Image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);
        user.value.profilePicture = imageUrl;
        user.refresh();
        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been Updated!',
        );
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'OhSnap',
        message: 'Something went Wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
