import 'package:flutter/material.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/services/shimmer_effect.dart';
import '../../../features/authentication/controllers/login_controller/user_controller.dart';
import '../../../widgets/circular_image.dart';
import '../../constants/image_strings.dart';

class TAppbarTheme {
  TAppbarTheme._();

  static AppBar lightAppBarTheme({Widget? leading , List<Widget>? actions}) => AppBar(
    backgroundColor: TColors.primaryBackground,
    scrolledUnderElevation: 0,
    leading: Builder(
        builder: (context) {
          return leading ?? Padding(
            padding: EdgeInsets.only(left: 20.0.w),
            child: IconButton(icon:Icon(Iconsax.menu_1), iconSize: 40.r,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }, ),
          );
        }
    ),
    actions: actions?? [
      SizedBox(width: 150.w),
      CircleAvatar(
        radius: 30.r,
        child: Obx(() {
          final networkImage = UserController.instance.user.value.profilePicture;
          final image = networkImage.isNotEmpty
              ? networkImage
              : TImages.women;
          return UserController.instance.imageUploading.value
              ? TShimmerEffect(
            width: 55.w,
            height: 55.h,
            radius: 55.r,
          )
              : CircularImage(
            image: image,
            width: 80.w,
            height: 80.h,
            isNetworkImage: networkImage.isNotEmpty,
          );
        }),
      ),
      SizedBox(width: 30.w),
    ],


  );

  static AppBar darkAppBarTheme({Widget? leading,List<Widget>? actions}) => AppBar(
    backgroundColor: TColors.blackF,
    scrolledUnderElevation: 0,
    leading:  Builder(
        builder: (context) {
          return leading ?? Padding(
            padding: EdgeInsets.only(left: 20.0.w),
            child: IconButton(icon:Icon(Iconsax.menu_1), iconSize: 40.r,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }, ),
          );
        }
    ),

    actions: actions?? [
      SizedBox(width: 150.w),
      CircleAvatar(
        radius: 30.r,
        child: Obx(() {
          final networkImage = UserController.instance.user.value.profilePicture;
          final image = networkImage.isNotEmpty
              ? networkImage
              : TImages.women;
          return UserController.instance.imageUploading.value
              ? TShimmerEffect(
            width: 55.w,
            height: 55.h,
            radius: 55.r,
          )
              : CircularImage(
            image: image,
            width: 80.w,
            height: 80.h,
            isNetworkImage: networkImage.isNotEmpty,
          );
        }),
      ),
      SizedBox(width: 30.w),
    ],


  );











}