import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../features/shop/models/order_model.dart';
import '../../../utils/constants/enums.dart';

class Ordertracking extends StatelessWidget {
  const Ordertracking({super.key, required this.order});
  final OrderModel order;

  static const double _stepHeight = 190;

  @override
  Widget build(BuildContext context){
    final dark = THelperFunctions.isDarkMode(context);

    final steps = [
      {
        'title': 'ORDER PLACED',
        'desc': 'Your order is placed successfully',
        'icon': Image.asset('assets/images/track_icons/ordertrack1.png'),
      },
      {
        'title': 'ON THE WAY',
        'desc': 'Your Order is placed successfully',
        'icon': Image.asset('assets/images/track_icons/ordertrack2.png'),
      },
      {
        'title': 'PRODUCT DELIVERED',
        'desc': 'Your Order is placed successfully',
        'icon': Image.asset('assets/images/track_icons/ordertrack3.png'),
      },
    ];

    return Scaffold(
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

          ]) ,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 31.w,vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Order Tracking",style: TextStyle(fontFamily: "LibreBaskerville",fontSize: 24.sp,),)),
            Center(child: Text("${order.id}",style: TextStyle(fontFamily: "ScheherazadeNew",fontSize: 24.sp,color: TColors.primary),)),
            for (var i = 0; i < steps.length; i++)
              buildStep(
                isActive: _isStepActive(i, order.status),
                isCompleted: _isStepCompleted(i, order.status),
                title: steps[i]['title'] as String,
                description: steps[i]['desc'] as String,
                iconWidget: steps[i]['icon'] as Widget,
                showTop: i > 0,
                showBottom: i < steps.length - 1,
                stepIndex: i,
              ),
          ],
        ),
      ),
    );
  }

  bool _isStepActive(int stepIndex, OrderStatus status) {
    switch (stepIndex) {
      case 0: return true;
      case 1: return status == OrderStatus.shipped || status == OrderStatus.delivered;
      case 2: return status == OrderStatus.delivered;
      default: return false;
    }
  }

  bool _isStepCompleted(int stepIndex, OrderStatus status) {
    switch (stepIndex) {
      case 0: return true;
      case 1: return status == OrderStatus.shipped || status == OrderStatus.delivered;
      case 2: return status == OrderStatus.delivered;
      default: return false;
    }
  }

  Widget buildStep({
    required bool isActive,
    required bool isCompleted,
    required String title,
    required String description,
    required Widget iconWidget,
    required bool showTop,
    required bool showBottom,
    required int stepIndex,
  }) {
    return SizedBox(
      height: _stepHeight.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50.w,
            child: Column(
              children: [
                // top dotted segment
                if (showTop)
                  Expanded(
                    child: Center(
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashLength: 4,
                        dashGapLength: 3,
                        dashColor: isCompleted ? TColors.primary40 : TColors.primary40.withOpacity(0.3),
                        lineLength: double.infinity,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 70.h),

                // the circle icon
                Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: isActive ? TColors.primary40 : TColors.primary40.withOpacity(0.3),width: 1.w),
                    shape: BoxShape.circle,
                    color: isCompleted ? TColors.primary : Colors.white,
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 20.r)
                      : Text(
                    stepIndex == 1 ? "2" : "3",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: isActive ? TColors.primary40 : TColors.primary40.withOpacity(0.3),
                    ),
                  ),
                ),

                if (showBottom)
                  Expanded(
                    child: Center(
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashLength: 4,
                        dashGapLength: 2,
                        dashColor: isCompleted ? TColors.primary40 : TColors.primary40.withOpacity(0.3),
                        lineLength: double.infinity,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 55.h),
              ],
            ),
          ),

          SizedBox(width: 9.w),
          SizedBox(width: 100.w, height: 100.h, child: iconWidget),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontFamily: "Inter", fontSize: 16.sp, color: isActive ? Colors.black : Colors.grey)),
                Text(description, style: TextStyle(color: isActive ? const Color(0xFFB2ADAD) : Colors.grey[400], fontSize: 15.sp, fontFamily: "Inter")),
              ],
            ),
          ),
        ],
      ),
    );

  }
}