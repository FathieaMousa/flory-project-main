import 'package:animate_do/animate_do.dart';
import 'package:flory/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../features/authentication/controllers/onboarding/onboarding_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context){

    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
          children: [
            PageView(
              controller:  controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const  [
                onBoadrdingPage(
                  image: TImages.onBoardingImage1,
                  tittle: TTexts.onBoardingTitle1,
                  subTittle: TTexts.onBoardingSubTitle1,
                ),
                onBoadrdingPage(
                  image: TImages.onBoardingImage2,
                  tittle: TTexts.onBoardingTitle2,
                  subTittle: TTexts.onBoardingSubTitle2,
                ),
                onBoadrdingPage(
                  image: TImages.onBoardingImage3,
                  tittle: TTexts.onBoardingTitle3,
                  subTittle: TTexts.onBoardingSubTitle3,
                ),

              ],
            ),
            // skip Button
            const onBoardingSkip(),

            // PageIndicator
            onBoardingIndicator(),

            // Circular button
            onBoardingButton(),


          ]
      ),
    );
  } }

class onBoadrdingPage extends StatelessWidget {
  const onBoadrdingPage({
    super.key,
    required this.image,
    required this.tittle,
    required this.subTittle,
  });

  final String image, tittle, subTittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          FadeInLeft(
            duration: Duration(seconds: 2),
            child: Image.asset(
              image,
              width: THelperFunctions.screenWidth() * 0.8.w,
              height: THelperFunctions.screenHeight() * 0.6.h,
            ),
          ),

          Text(
            tittle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subTittle,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
class onBoardingIndicator extends StatelessWidget {
  const onBoardingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight()+25.h,
        left: TSizes.defaultSpace,
        child: SmoothPageIndicator(controller: controller.pageController,
            onDotClicked: controller.dotClick,
            count: 3 ,
            effect: ExpandingDotsEffect(activeDotColor: dark ? TColors.light : TColors.dark,dotHeight: 6 ,
            )) );
  }
}
class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        top: TDeviceUtils.getAppBarHeight().h,
        right: TSizes.defaultSpace,
        child: TextButton(onPressed: ()=>OnBoardingController.instance.skipPage(),
            child: Text("Skip" ,style: TextStyle(color:  dark ? TColors.light : TColors.dark),)));
  }
}
class onBoardingButton extends StatelessWidget {
  const onBoardingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight()+25.h,
        right: TSizes.defaultSpace,
        child: ElevatedButton(onPressed: ()=> OnBoardingController.instance.nextPage(),
            style:ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r)
                ),
                backgroundColor:TColors.primary) ,
            child: const Icon(Iconsax.arrow_right_3 , color: TColors.light,
            ))
    );
  }
}