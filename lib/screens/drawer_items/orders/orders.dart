import 'package:flory/screens/drawer_items/orders/orders_list.dart';
import 'package:flory/utils/constants/sizes.dart';
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Scaffold(
      appBar: dark ? TAppbarTheme.darkAppBarTheme(leading: Padding(
        padding: EdgeInsets.only(left: 20.0.w),
        child: IconButton(icon:Icon(Iconsax.arrow_left_2), iconSize: 40.r,
          onPressed: () {
            Get.back();
          }, ),
      ),
          actions: [
            SizedBox(width: 150.w),
            CircleAvatar(
                backgroundColor: TColors.primary40,
                radius: 40.r,
                child:Icon(Icons.track_changes,size: 40.sp,color: Colors.white,)
            ),
            SizedBox(width: 30.w),

          ])  :TAppbarTheme.lightAppBarTheme(leading: Padding(
        padding: EdgeInsets.only(left: 20.0.w),
        child: IconButton(icon:Icon(Iconsax.arrow_left_2), iconSize: 40.r,
          onPressed: () {
            Get.back();
          }, ),
      ),
          actions: [
            SizedBox(width: 150.w),
            CircleAvatar(
                backgroundColor: TColors.primary40,
                radius: 40.r,
                child:Icon(Icons.track_changes,size: 40.sp,color: Colors.white,)
            ),
            SizedBox(width: 30.w),

          ]),
      body: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
          children:[
        Text(
        "Your Orders List",
        style: TextStyle(
          fontFamily: "LibreBaskerville",
          fontSize: 24.sp,
          color: dark ? TColors.white : TColors.black,
        ),
      ),
            SizedBox(height: TSizes.spaceBtwSections,),
            Expanded(child: TOrdersList())
          ] ),
      ),
    );

  }
}
