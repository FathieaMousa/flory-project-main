import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/services/shimmer_effect.dart';
import '../../../features/authentication/controllers/login_controller/user_controller.dart';
import '../../../features/authentication/controllers/profile/edit_profile_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../utils/validators/validation.dart';
import '../../../widgets/circular_image.dart';



class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  String? selectedGender;
  final controller = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    selectedGender = controller.selectedGender.value;
  }
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark ? TAppbarTheme.darkAppBarTheme(leading: Padding(
        padding: EdgeInsets.only(left: 20.0.w),
        child: IconButton(icon:Icon(Iconsax.arrow_left_2), iconSize: 40.r,
          onPressed: () {
            Get.back();
          }, ),
      ),
          actions: []) :TAppbarTheme.lightAppBarTheme(leading: Padding(
        padding: EdgeInsets.only(left: 20.0.w),
        child: IconButton(icon:Icon(Iconsax.arrow_left_2), iconSize: 40.r,
          onPressed: () {
            Get.back();
          }, ),
      ),
          actions: []) ,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31.w,vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Edit Profile",
                style: TextStyle(fontFamily: "LibreBaskerville",
                    fontSize: 24.sp,
                    color:dark?TColors.white :TColors.dark),)),
              SizedBox(height: 60.h,),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final networkImage = UserController.instance.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : TImages.women;
                      return UserController.instance.imageUploading.value
                          ? TShimmerEffect(
                        width: 55.w,
                        height: 55.h,
                        radius: 55.r,
                      )
                          : CircularImage(
                        image: image,
                        width: 80.w,
                        height: 80.h,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    SizedBox(width: 20.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(controller.fullNameController.text,style: TextStyle(fontSize: 20.sp,color:dark?TColors.white :TColors.dark),),
                        Text(controller.emailController.text,style: TextStyle(fontSize: 15.sp,color: TColors.primary),),
                        SizedBox(height: 14.h,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r)
                              ),
                              backgroundColor: TColors.primary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 27.w,vertical: 8.h),

                            ),
                            onLongPress: (){},
                            onPressed: () => UserController.instance.uploadUserProfilePicture(),
                            child: Text("Upload Photo",style: TextStyle(fontSize: 16.sp),)),

                      ],
                    ),

                  ]
              ),
              SizedBox(height: TSizes.spaceBtwSections.h,),
              Text("Name",style: TextStyle(fontSize: 16.sp,fontFamily: "Inter",color:dark? TColors.white:Colors.black),),
              SizedBox(height: 5.h,),
              Form(
                key: controller.EditFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value)=>TValidator.validateEmptyText('Name', value),
                      controller: controller.fullNameController,
                      style: TextStyle(fontSize: 20.sp),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: controller.fullNameController.text,
                          hintStyle: TextStyle(fontFamily: "Inter",fontSize: 15.sp,color: TColors.primary40),
                          filled: true,
                          fillColor: dark ? TColors.white.withOpacity(0.2): Colors.white

                      ),),
                    SizedBox(height:  TSizes.spaceBtwInputFields.h),
                    Text("Phone Number",textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16.sp,fontFamily: "Inter",color:dark? TColors.white:Colors.black),),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      validator:(value)=>TValidator.validatePhoneNumber(value),
                      controller: controller.phoneNumController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 20.sp),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 15.w),
                          hintText:controller.phoneNumController.text,
                          hintStyle: TextStyle(fontFamily: "Inter",fontSize: 15.sp,color: TColors.primary40),
                          filled: true,
                          fillColor: dark ? TColors.white.withOpacity(0.2): Colors.white

                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height:  TSizes.spaceBtwInputFields.h),
              SizedBox(height: 5.h),
              Text("Gender",style: TextStyle(fontSize: 16.sp,fontFamily: "Inter",color:dark? TColors.white:Colors.black),),
              SizedBox(height: 5.h,),

              Obx(()=>DropdownButtonFormField<String>(
                value: controller.selectedGender.value.isEmpty ? null : controller.selectedGender.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:dark ? TColors.dark :TColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.r),
                      borderSide: BorderSide.none,
                    ),
                  hintText: 'Select Gender',
                  prefixIcon: Icon(CupertinoIcons.person, color: TColors.primary),
                ),
                items: ["Male", "Female"].map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(
                      gender,
                      style: TextStyle(
                        fontFamily: "LibreBaskerville",
                        fontSize: 14.sp,
                        color: TColors.primary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedGender.value = value ?? "";
                },
                validator: (value)=>TValidator.validateGender(value),
              ),),
              SizedBox(height: TSizes.spaceBtwSections.h),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)
                      ),
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 140.w,vertical:5.h),

                    ),
                    onPressed: (){
                      controller.editUserData();
                    },
                    child: Text("Save",style: TextStyle(fontSize: 18.sp,fontFamily: "Inter"),)),
              ),
              SizedBox(height: TSizes.spaceBtwItems.h),
              Center(
                child: Container(
                  width: 320.w,
                  height: 40.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r)
                        ),
                        backgroundColor: TColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: ()=>UserController.instance.deleteAccountWarningPopup(),
                      child: Text("Close Account",style: TextStyle(fontSize: 18.sp,fontFamily: "Inter"),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}