import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

// widget to display animated loading indicator
class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key,
    required this.text,
    required this.animation,
    this.showAction=false,
    this.actionText,
    this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String?actionText;
  final VoidCallback? onActionPressed;


  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation, width: MediaQuery.of(context).size.width*0.7),
        //  const SizedBox(height: TSizes.defaultSpace,),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TSizes.defaultSpace,),
        showAction ? SizedBox(
          width: 250,
          child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light),
              )
          ),
        ) : const SizedBox()
      ],
    );
  }
}