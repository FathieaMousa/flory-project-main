import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../screens/RegisterScreens/verify_email.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/loader/loaders.dart';
import '../../../../utils/network/network_manager.dart';
import '../../models/user_model.dart';
import '../login_controller/user_controller.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumController = TextEditingController();
  final selectedGender = "".obs;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;

  // User registration function
  void register() async {
    try {
      //Form Validation
      if (!registerFormKey.currentState!.validate()) return;

      // check the internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        Loaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your connection and try again.',
        );
        return;
      }
      // Loading
      THelperFunctions.openLoadDialog(
        'We are processing your information...',
        TImages.loaderAsset,
      );

      // Register user in firebase authentication and save user data in firebase.
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());

      //save authentication user data in firebase firestore.
      final newUser = UserModel(
        id: userCredential.user!.uid,
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneNumController.text.trim(),
        profilePicture: '',
        gender: selectedGender.value,
      );
      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);
      THelperFunctions.stopLoading();
      clearFields();
      // success message
      Loaders.successSnackBar(title: 'Congratulation', message: 'Your account has been created! verify email to continue.');

      //verify email screen
      Get.to(()=> VerifyEmail(email:emailController.text.trim(),));

    } catch (e) {
      //show generic error to the user
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      THelperFunctions.stopLoading();
    } finally {
      //THelperFunctions.stopLoading();
    }
  }

  // Google sign in
  Future<void> googleSignIn() async {
    try{
      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        Loaders.errorSnackBar(title: 'No Internet Connection' , message: 'Please check your connection and try again later.');
        return;
      }
      THelperFunctions.openLoadDialog('Logging you in...', TImages.loaderAsset);
      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // save user records
      await userController.saveUserRecord(userCredentials);
      // remove loader
      THelperFunctions.stopLoading();
      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e){
      THelperFunctions.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void clearFields() {
    registerFormKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
    phoneNumController.clear();
    FocusScope.of(Get.context!).unfocus();
  }

}

