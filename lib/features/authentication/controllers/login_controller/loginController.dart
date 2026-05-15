import 'package:flory/features/authentication/controllers/login_controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/loader/loaders.dart';
import '../../../../utils/network/network_manager.dart';

class SignInController extends GetxController{
  static SignInController get instance => Get.find();

  // variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;

  @override
  void onInit() {
   emailController.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
   passwordController.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }
  // Email and password sign in
  Future<void>emailAndPasswordSignIn () async {
    try {
      //start Loader
      THelperFunctions.openLoadDialog('Logging you in......', TImages.loaderAsset);

      //check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        THelperFunctions.stopLoading();
        return;
      }
      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        THelperFunctions.stopLoading();
        return;
      }

      //save data if Remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', passwordController.text.trim());
      }


      //SignIn user using Email & Password Auth
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());
      //  Remove Loader
      THelperFunctions.stopLoading();
      // Redirect
      AuthenticationRepository.instance.screenRedirect();
      clearFields();
    }catch(e) {
      //Remove Loader
      THelperFunctions.stopLoading();
      //Show some Generic Error to the user
      Loaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

// Google sign in authentication
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
  // Future<void> facebookSignIn() async {
  //   try {
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       Loaders.errorSnackBar(
  //           title: 'No Internet Connection',
  //           message: 'Please check your connection and try again later.');
  //       return;
  //     }
  //
  //     THelperFunctions.openLoadDialog('Logging you in with Facebook...', TImages.loaderAsset);
  //
  //     final userCredentials = await AuthenticationRepository.instance.signInWithFacebook();
  //
  //     // save user records
  //     await userController.saveUserRecord(userCredentials);
  //
  //     // remove loader
  //     THelperFunctions.stopLoading();
  //
  //     // redirect
  //     AuthenticationRepository.instance.screenRedirect();
  //   } catch (e) {
  //     THelperFunctions.stopLoading();
  //     Loaders.errorSnackBar(title: 'Facebook Sign-In Failed', message: e.toString());
  //   }
  // }

  void clearFields() {
    loginFormKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
    FocusScope.of(Get.context!).unfocus();
  }

}