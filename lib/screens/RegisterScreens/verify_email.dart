
import 'package:flory/screens/RegisterScreens/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/repositories/authentication/authentication_repository.dart';
import '../../features/authentication/controllers/register/verify_email.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, this.email});
  final String? email ;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // AppBar
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: dark?TColors.blackF : TColors.primaryBackground,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> AuthenticationRepository.instance.logout(), icon:Icon(CupertinoIcons.clear))
          , SizedBox(width: TSizes.defaultSpace,)
        ],
      ),

      body:  SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace*1.5),
          child: Column(
            children: [
              SizedBox(height: TSizes.defaultSpace,),
              //  Verify Image
              Center(child: Image(image: AssetImage(TImages.verifyEmail) , width:THelperFunctions.screenWidth()*0.3,)),
              const SizedBox(height: TSizes.spaceBtwItems,),
              // Page Tittle
              Text(TTexts.cofirmEmail, style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: dark ?TColors.white : TColors.blackF ,
                  fontWeight: FontWeight.w500
              ),textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems,),
              // User email
              Text(email ??'', style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems,),
              // Page Sub Tittle
              Text(TTexts.cofirmEmailSubTit, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center),
              SizedBox(height: TSizes.spaceBtwSections,),
              // Continue Button
              SizedBox(
                width: double.infinity.w,
                height: 55.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: TColors.primary ,
                      foregroundColor: TColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      )
                  ),
                  onPressed: ()=> Get.to( ()=>
                      SuccessScreen(
                        image: TImages.verifyDone,
                        tittle: TTexts.createdSuccessfully,
                        subTittle: TTexts.createdSuccessfullySubTittle,
                        onPressed: () => controller.checkEmailVerificationStatus(),
                      ),
                  ),
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Resend Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(TColors.primary ),

                  ),
                  onPressed: () =>controller.sendEmailVerification(),
                  child: const Text('Resend Email' , style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}