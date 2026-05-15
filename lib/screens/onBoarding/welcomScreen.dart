import 'package:flory/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/text_theme.dart';
import '../RegisterScreens/registerScreen.dart';
import '../loginScreens/SignInScreen.dart';


class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: TColors.primary,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(8.r),
                width: 394.w,
                height: 489.h,
                decoration: BoxDecoration(
                  color: dark ? TColors.dark : TColors.white,
                  borderRadius: BorderRadius.circular(34.0.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 32.0.h),
                    Text(
                      TTexts.appName,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      TTexts.tittle1,
                      style: TTextTheme.lightTextTheme.titleLarge,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 80.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Text(
                      TTexts.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'LibreBaskerville',
                        fontWeight: FontWeight.w400,
                        color: TColors.primaryBackground,
                      ),
                    ),
                    Text(
                      TTexts.description0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'LibreBaskerville',
                        fontWeight: FontWeight.w400,
                        color: Color(0x0faf7f38),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Container(
                  height: 72.h,
                  width: 347.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFB1B7A2),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      // Register button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB1B7A2),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                bottomLeft: Radius.circular(16.r),
                              ),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'LibreBaskerville',
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      // Sign In btton
                      SizedBox(
                        height: 72.h,
                        width: 185.w,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignInScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark
                                ? TColors.dark
                                : TColors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'LibreBaskerville',
                              color: dark ? TColors.white : TColors.dark,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Centered Pic
          Positioned(
            bottom: 320.h,
            child: Image.asset(
              TImages.welcomeScreen,
              height: 598.h,
              width: 398.w,
            ),
          ),
        ],
      ),
    );
  }
}