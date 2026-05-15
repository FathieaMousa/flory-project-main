
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flory/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/services/shimmer_effect.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = TSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit?fit;
  final String image;
  final bool isNetworkImage;
  final Color?overlayColor;
  final Color?backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
// If image background color is null then switch it to light and dark mode color design.
        color: backgroundColor ?? (THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      // BoxDecoration
    //       child:isNetworkImage(
    //
    // ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: isNetworkImage?CachedNetworkImage(
          fit: fit,
          color: overlayColor,
          imageUrl: image,
      progressIndicatorBuilder: (context, url , downloadProgress)=>const TShimmerEffect(width: 55, height: 55,radius: 55,) ,
        errorWidget: (context , url , error)=>const Icon(Icons.error)
           )
      :Image(
        fit: fit,
        image: isNetworkImage ? NetworkImage(image) : AssetImage(
            image) as ImageProvider,
        color: overlayColor,
      ),

    ),);
  }
}


