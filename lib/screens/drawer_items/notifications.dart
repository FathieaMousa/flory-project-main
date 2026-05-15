import 'package:flory/notifications/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/appbar_theme.dart';



class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  // store notification
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark ?TAppbarTheme.darkAppBarTheme(leading: Padding(
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
                child:Icon(Iconsax.notification,size: 40.sp,color: Colors.white,)
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
                child:Icon(Iconsax.notification,size: 40.sp,color: Colors.white,)
            ),
            SizedBox(width: 30.w),
          ]) ,
      body:Stack(
        children :[
          Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(child: Text("Notifications",style: TextStyle(fontFamily: "LibreBaskerville",fontSize: 24.sp,color: Colors.black),)),
            ),
            Expanded(
              child:ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: NotificationService.notificationsNotifier,
                builder: (context, notifications, _) {
                  if (notifications.isEmpty) {
                    return const Center(child: Text("No notifications yet"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final n = notifications[index];
                      return buildNotificationTile(
                        context,
                        title: n["title"]?? "",
                        subtitle: n["subtitle"]?? "",
                        trailingTime: n["time"]?? "",
                        leadingImagePath: n["image"]?? "assets/images/appLogo.png",
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 80.h), ]),
      
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)
                      ),
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 140.w,vertical: 10.h),
            
                    ),
                    onLongPress: (){},
                    onPressed:NotificationService().clearAll,
                    child: Text("Clear",style: TextStyle(fontSize: 18.sp,fontFamily: "Inter"),))
            ),
          ),
          SizedBox(height: TSizes.spaceBtwSections,)
        ],
      ));
        }

  Widget buildNotificationTile( BuildContext context ,{
    required String title,
    required String subtitle,
    required String trailingTime,
    required String leadingImagePath,
    VoidCallback? onTap,
    VoidCallback? onLongPress,

  }) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      color: dark ?TColors.blackF: TColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 3.h),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 16.sp,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: "Inter",
                color: const Color(0xFFB2ADAD),
              ),
            ),
            trailing: Text(
              trailingTime,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 16.sp,
                color: const Color(0xFFB2ADAD),
              ),
            ),
            leading: Image.asset(
              leadingImagePath,
              width: 32.w,
              height: 32.h,
            ),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
          Divider(
            color: TColors.white,
            thickness: 2,
          )
        ],
      ),
    );

  }
}