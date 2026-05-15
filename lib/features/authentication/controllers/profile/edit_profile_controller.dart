
import 'package:flory/utils/loader/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../screens/navigation_items/profile.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../widgets/navigation_menu.dart';
import '../login_controller/user_controller.dart';

class EditProfileController extends GetxController{
  static EditProfileController get instance =>Get.find();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();
  final selectedGender = "".obs;
  final GlobalKey<FormState> EditFormKey = GlobalKey<FormState>();
  final userController = UserController.instance ;
  final userRepository = Get.put(UserRepository());


  //init user data
  @override
  void onInit() {
    initializeData();
    super.onInit();
  }
  //Fetch user record
  Future<void> initializeData ()async{
    fullNameController.text = userController.user.value.fullName ;
    emailController.text = userController.user.value.email ;
    phoneNumController.text= userController.user.value.phoneNumber ;
    selectedGender.value = userController.user.value.gender ;
  }

  // Function to edit user's profile
  Future<void> editUserData()async{

      try {
        //Form Validation
        if (!EditFormKey.currentState!.validate()) return;

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

      //update user's data in the Firebase Firestore.
      Map<String , dynamic>userData = {
        'FullName':fullNameController.text.trim() ,
        'PhoneNumber':phoneNumController.text.trim() ,
        'Gender':selectedGender.value
      };
        await userRepository.updateSingleField(userData);

      //update RX user value
      userController.user.value.fullName = fullNameController.text.trim();
      userController.user.value.phoneNumber= phoneNumController.text.trim() ;
      userController.user.value.gender = selectedGender.value;


      //Remove Loader
      THelperFunctions.stopLoading();

      //show success message
      Loaders.successSnackBar(title: "Congratulations" ,message: "Your Data has been updated." );

      //Move to pre screen
      Get.find<NavigationController>().changePage(3);
      Navigator.pop(Get.context!);
      //Get.off(()=>const Profile());

    }catch (e){
      THelperFunctions.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }


}