import 'package:flory/screens/loginScreens/password_configuration/forget_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/authentication/controllers/login_controller/loginController.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/validators/validation.dart';
import '../../widgets/divider_social_login.dart';
import '../../widgets/login_text_fields.dart';
import '../RegisterScreens/registerScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {
  final controller = Get.put(SignInController());
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

          //title , subtitle
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(30.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 290.h),
                  Text(
                    TTexts.title2,
                    style: TextStyle(
                      fontSize: 30.0.sp,
                      fontWeight: FontWeight.w300,
                      color: dark ? TColors.white : TColors.black,
                      fontFamily: "LibreBaskerville",
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    TTexts.subTitle2,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w500,
                      color: TColors.primary,
                      fontFamily: "LibreBaskerville",
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections.h),
                  //Form
                  Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        LoginTextFields(
                          controller: controller.emailController,
                          hintText: 'Email',
                          icon: CupertinoIcons.mail,
                          validator: TValidator.validateEmail,

                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields.h),
                        Obx(()=> LoginTextFields(
                            validator: (value)=>TValidator.validateEmptyText('password', value),
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
                     //   SizedBox(height: TSizes.spaceBtwInputFields.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(()=>Checkbox(value: controller.rememberMe.value,
                                onChanged:(value)=>controller.rememberMe.value =!controller.rememberMe.value )),
                            //onChanged:(value)=> controller.rememberMe.value = value!,)),

                            Text(
                              TTexts.remeberme,
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color: TColors.primary,
                                fontFamily: "LibreBaskerville",
                              ),
                            ),
                            SizedBox(width: TSizes.spaceBtwSections * 2.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                TTexts.forgetyourpassword,
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: TColors.primary,
                                  fontFamily: "LibreBaskerville",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 70.h,
                          width: 349.w,
                          child: ElevatedButton(
                            onPressed:()=> controller.emailAndPasswordSignIn(),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.buttonPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: TColors.primaryBackground,
                              ),
                            ),
                          ),
                        ),
                       SizedBox(height: TSizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              TTexts.confirm_msg2,
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color: TColors.primary,
                                fontFamily: "LibreBaskerville",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
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
                  ]),
                ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  DividerSocialLogin(
                    dividerText: 'Or Sign in With',
                    controller: controller,
                    onGooglePressed:controller.googleSignIn,

                  ),

           ]
              ),
          ),

          ),
   ] )
    );
  }
}