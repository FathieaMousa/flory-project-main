import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {

    const FavouriteIcon({
       super.key,
       required this.icon,
       required this.height,
       required this.width,
       this.size = 16,
       this.onPressed,
       this.color,
       this.backgroundColor
});

   final double? width,height,size;
   final IconData icon;
   final Color? color;
   final Color? backgroundColor;
   final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
           color: THelperFunctions.isDarkMode(context)? TColors.dark :TColors.white,
                borderRadius: BorderRadius.circular(40)
      ),
      child: Center(child: Container(child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size,)))),
    );
  }
}
    //
    // Positioned(
    //   top: 16.h,
    //   right: 16.w,
    //   child: Container(
    //     alignment: Alignment.center,
    //     width: 28.w,
    //     height: 28.h,
    //     decoration: BoxDecoration(
    //       color: TColors.primary,
    //       borderRadius: BorderRadius.circular(5.r),
    //     ),
    //     child: Icon(
    //       Icons.favorite,
    //       color: Colors.white,
    //       size: 16.sp,
    //     ),
    //   ),
    // ),
