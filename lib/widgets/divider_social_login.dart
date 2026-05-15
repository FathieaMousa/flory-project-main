import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';


class DividerSocialLogin extends StatelessWidget {
  const DividerSocialLogin({super.key , required this.dividerText, this.controller, required this.onGooglePressed});
  final String dividerText ;
  final dynamic controller;
  final VoidCallback onGooglePressed;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Divider(color: dark? TColors.darkGrey :TColors.grey,thickness: 0.5,indent: 60,endIndent: 5,)),
            Text(dividerText , style: Theme.of(context).textTheme.labelMedium,),
            Flexible(child: Divider(color: dark? TColors.darkGrey :TColors.grey,thickness: 0.5,indent: 5,endIndent: 60,))

          ],
        ),
        SizedBox(height: TSizes.spaceBtwSections,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                  onPressed: onGooglePressed,
                  icon: const Image(
                    width: TSizes.iconMd,
                    height:TSizes.iconMd,
                    image: AssetImage('assets/images/google_icon.png'),
                  )
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems,),
          ],
        )
      ],
    );
  }
}