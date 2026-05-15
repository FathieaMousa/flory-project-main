import 'package:flory/features/authentication/controllers/register/register_controller.dart';
import 'package:flory/utils/constants/sizes.dart';
import 'package:flory/widgets/divider_social_login.dart';
import 'package:flory/widgets/login_text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/validators/validation.dart';
import '../loginScreens/SignInScreen.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.blackF : TColors.primaryBackground,
      body: Stack(
        children: [
          //Image
          Positioned(
            top: 0.h,
            left: 0.w,
            child: Image.asset(TImages.flower, width: 267.w, height: 337.h),
          ),
          // title , subtitle
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 290.h),

                  Text(
                    TTexts.title1,
                    style: TextStyle(
                      fontSize: 30.0.sp,
                      fontWeight: FontWeight.w300,
                      color: dark ? TColors.white : TColors.black,
                      fontFamily: "LibreBaskerville",
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    TTexts.subTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: TColors.primary,
                      fontFamily: "LibreBaskerville",
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections.h),
                  //Register Form
                  Form(
                    key: controller.registerFormKey,
                    child: Column(
                      children: [
                        // FullName Field
                        LoginTextFields(
                          validator:(value)=> TValidator.validateFullName(value),
                          controller: controller.fullNameController,
                          hintText: 'Full Name',
                          icon: Iconsax.personalcard,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields.h),
                        // Email Field
                        LoginTextFields(
                          validator: (value)=>TValidator.validateEmail(value),
                          controller: controller.emailController,
                          hintText: 'Email',
                          icon: CupertinoIcons.mail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields.h),
                        // Phone Field
                        LoginTextFields(
                          validator:(value)=> TValidator.validatePhoneNumber(value),
                          controller: controller.phoneNumController,
                          hintText: 'Phone number',
                          icon: CupertinoIcons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields.h),
                        // Gender Field
                        Obx(()=>DropdownButtonFormField<String>(
                          value: controller.selectedGender.value.isEmpty ? null : controller.selectedGender.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:dark ? TColors.dark :TColors.textFieldsColor,
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
                        SizedBox(height: TSizes.spaceBtwInputFields.h),
                        // Password Field
                        Obx(
                              ()=> LoginTextFields(
                            validator: (value)=>TValidator.validatePassword(value),
                            controller: controller.passwordController,
                            hintText: 'Password',
                            icon: CupertinoIcons.lock,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: controller.hidePassword.value,
                            suffixIcon: IconButton(
                              icon: Icon( controller.hidePassword.value ?Iconsax.eye_slash : Iconsax.eye),
                              onPressed: ()=> controller.hidePassword.value= !controller.hidePassword.value,
                            ),
                          ),
                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields.h),
                        //have an account row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              TTexts.haveAccount_msg,
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color: TColors.primary,
                                fontFamily: "LibreBaskerville",
                              ),
                            ),
                            SizedBox(width: 16.w),
                            // Sign in if have account
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: dark ? TColors.white : TColors.black,
                                  fontFamily: "LibreBaskerville",
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Register button and validation
                        SizedBox(height: TSizes.spaceBtwItems.h),
                        SizedBox(
                          height: 70.h,
                          width: 349.w,
                          child: ElevatedButton(
                            onPressed: () => controller.register(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.buttonPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: TColors.primaryBackground,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  // Social accounts register
                  DividerSocialLogin(dividerText: 'Or Sign up With',
                    controller: controller,
                    onGooglePressed:controller.googleSignIn,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}