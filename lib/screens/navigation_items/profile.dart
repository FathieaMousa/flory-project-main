import 'package:flory/screens/navigation_items/profile_items/changepassword.dart';
import 'package:flory/screens/navigation_items/profile_items/editprofile.dart';
import 'package:flory/screens/navigation_items/profile_items/shippingaddress.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../data/services/shimmer_effect.dart';
import '../../features/authentication/controllers/login_controller/user_controller.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../widgets/circular_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = UserController.instance;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "My Profile",
                  style: TextStyle(
                    fontFamily: "LibreBaskerville",
                    fontSize: 24.sp,
                    color: dark ? TColors.white : TColors.blackF,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty
                        ? networkImage
                        : TImages.women;
                    return controller.imageUploading.value
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
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => Text(
                          controller.user.value.fullName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: dark ? TColors.white : TColors.blackF,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.user.value.email,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: TColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: TColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 27.w,
                            vertical: 8.h,
                          ),
                        ),
                        onLongPress: () {},
                        onPressed: () => Get.to(Editprofile()),
                        child: Text(
                          "Change Photo",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 70.h),
              Container(
                width: double.infinity.w,
                height: 230.h,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 3.h),
                      width: 349.w,
                      height: 45.h,
                      color: dark ? TColors.blackF : TColors.primaryBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            height: 40.h,
                            color: dark
                                ? TColors.blackF
                                : TColors.primaryBackground,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Editprofile(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: dark
                                    ? TColors.blackF
                                    : TColors.primaryBackground,
                                foregroundColor: dark
                                    ? TColors.white
                                    : TColors.blackF,
                                padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                              ),
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Editprofile(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.white),
                    Container(
                      width: 370.w,
                      height: 45.h,
                      color: dark ? TColors.blackF : TColors.primaryBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            height: 63.h,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Shippingaddress(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: dark
                                    ? TColors.blackF
                                    : TColors.primaryBackground,
                                foregroundColor: dark
                                    ? TColors.white
                                    : TColors.blackF,
                                padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                              ),
                              child: Text(
                                "Shipping Address",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 10.w,),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Shippingaddress(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
                      margin: EdgeInsets.only(bottom: 0.h),
                      width: 349.w,
                      height: 45.h,
                      color: dark ? TColors.blackF : TColors.primaryBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            height: 63.h,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Changepassword(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: dark
                                    ? TColors.blackF
                                    : TColors.primaryBackground,
                                foregroundColor: dark
                                    ? TColors.white
                                    : TColors.blackF,
                                padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                              ),
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Changepassword(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
