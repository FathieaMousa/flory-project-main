
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.tittle,
    required this.subTittle,
    required this.onPressed,
  });

  final String? image;
  final String tittle, subTittle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // AppBar
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: dark ? TColors.blackF : TColors.primaryBackground,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace * 1.5),
        child: Column(
          children: [
            SizedBox(height: TSizes.defaultSpace),
            // image
            Center(
              child: Image(
                image: AssetImage(image!),
                width: THelperFunctions.screenWidth() * 0.3,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // page tittle
            Text(
              tittle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: dark ? TColors.white : TColors.blackF,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            // page Sub tittle
            Text(
              subTittle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            // Done Button
            SizedBox(
              width: double.infinity.w,
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: TColors.primary,
                  foregroundColor: TColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: onPressed,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}