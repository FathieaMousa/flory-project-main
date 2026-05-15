import 'package:flory/utils/constants/sizes.dart';
import 'package:flory/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/controllers/address_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Newdeliveryaddress extends StatefulWidget {
  const Newdeliveryaddress({super.key});


  @override
  State<Newdeliveryaddress> createState() => _NewdeliveryaddressState();
}
class _NewdeliveryaddressState extends State<Newdeliveryaddress> {

  String? selectedCountry;
  final controller = AddressController.instance;

  @override
  void initState() {
    super.initState();
    selectedCountry = controller.selectedCountry.value;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark
          ? TAppbarTheme.darkAppBarTheme(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Iconsax.arrow_left_2),
            iconSize: 40.r,
            onPressed: () => Get.back(),
          ),
        ),
        actions: [
          SizedBox(width: 150.w),
          CircleAvatar(
            backgroundColor: TColors.primary40,
            radius: 40.r,
            child: Icon(Iconsax.location, size: 40.sp, color: Colors.white),
          ),
          SizedBox(width: 30.w),
        ],
      )
          : TAppbarTheme.lightAppBarTheme(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Iconsax.arrow_left_2),
            iconSize: 40.r,
            onPressed: () => Get.back(),
          ),
        ),
        actions: [
          SizedBox(width: 150.w),
          CircleAvatar(
            backgroundColor: TColors.primary40,
            radius: 40.r,
            child: Icon(Iconsax.location, size: 40.sp, color: Colors.white),
          ),
          SizedBox(width: 30.w),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 20.h),
        child: Form(
          key: controller.addressFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                    "New Delivery Address",
                    style: TextStyle(
                        fontFamily: "LibreBaskerville",
                        fontSize: 24.sp,
                        color: dark ? TColors.white : Colors.black)
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields.h),
              Text(
                "We’ll ship it to your address below:",
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 18.h),
              // Name
              Text("Name",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              TextFormField(
                style: TextStyle(fontSize: 20.sp),
                controller: controller.name,
                validator: (value) => TValidator.validateEmptyText('Name', value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                  prefixIcon: Icon(Iconsax.user, color: TColors.primary, size: 26),
                  hintText: "Full Name",
                  hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.sp,
                      color: TColors.primary40),
                  filled: true,
                  fillColor: dark ? Colors.white.withOpacity(0.2) : Colors.white,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields.h),

              // Phone Number
              Text("Phone Number",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              TextFormField(
                style: TextStyle(fontSize: 20.sp),
                keyboardType: TextInputType.phone,
                controller: controller.phoneNumber,
                validator: TValidator.validatePhoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                  prefixIcon: Icon(Iconsax.call, color: TColors.primary, size: 26),
                  hintText: "Enter your phone number",
                  hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.sp,
                      color: TColors.primary40),
                  filled: true,
                  fillColor: dark ? Colors.white.withOpacity(0.2) : Colors.white,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields.h),

              // Country
              Text("Country",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              Obx(()=>DropdownButtonFormField<String>(
                value: controller.selectedCountry.value.isEmpty
                    ? null
                    : controller.selectedCountry.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:dark ? TColors.dark :TColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Select Country',
                  prefixIcon: Icon(CupertinoIcons.person, color: TColors.primary),
                ),
                hint: Text('Select Country'), // أضف hint هنا
                items: ["Bahrain", "Kuwait","Oman","Qatar","Saudi Arabia","UAE"].map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: TextStyle(
                        fontFamily: "LibreBaskerville",
                        fontSize: 14.sp,
                        color: TColors.primary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedCountry.value = value ?? "";
                },
              ),),
              SizedBox(height: TSizes.spaceBtwInputFields.h),
              // City
              Text("City",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              TextFormField(
                style: TextStyle(fontSize: 20.sp),
                controller: controller.city,
                validator: (value) =>TValidator.validateEmptyText('City', value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                  prefixIcon:
                  Icon(Iconsax.buildings, color: TColors.primary, size: 26),
                  hintText: "City",
                  hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.sp,
                      color: TColors.primary40),
                  filled: true,
                  fillColor: dark ? Colors.white.withOpacity(0.2) : Colors.white,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields.h),
              Text("Use My Current Location",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              TextFormField(
                style: TextStyle(fontSize: 20.sp),
                controller: controller.street,
                validator: (value) =>TValidator.validateEmptyText('Current Location', value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                  prefixIcon: Icon(Iconsax.buildings, color: TColors.primary, size: 26),
                  hintText: "e.g New cairo , Rehap",
                  hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.sp,
                      color: TColors.primary40),
                  filled: true,
                  fillColor: dark ? Colors.white.withOpacity(0.2) : Colors.white,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields.h),
              // Postal Code
              Text("Postal Code",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              TextFormField(
                style: TextStyle(fontSize: 20.sp),
                controller: controller.postalCode,
                validator: (value) => TValidator.validateEmptyText('Postal Code', value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                  prefixIcon: Icon(Iconsax.code, color: TColors.primary, size: 26),
                  hintText: "Postal Code (e.g. 12345)",
                  hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.sp,
                      color: TColors.primary40),
                  filled: true,
                  fillColor: dark ? Colors.white.withOpacity(0.2) : Colors.white,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields.h),
              // State
              Text("State",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Inter",
                      color: dark ? TColors.white : Colors.black)),
              SizedBox(height: 5.h),
              TextFormField(
                style: TextStyle(fontSize: 20.sp),
                controller: controller.state,
                validator: (value) => TValidator.validateEmptyText('State', value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                  prefixIcon:
                  Icon(Iconsax.activity, color: TColors.primary, size: 26),
                  hintText: "State / Governorate",
                  hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15.sp,
                      color: TColors.primary40),
                  filled: true,
                  fillColor: dark ? Colors.white.withOpacity(0.2) : Colors.white,
                ),
              ),
              SizedBox(height: 50.h),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r)),
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 120.w, vertical: 9.h),
                  ),
                  onPressed: () => controller.addNewAddresses(),
                  child: Text("Save Address",
                      style: TextStyle(fontSize: 16.sp, fontFamily: "Inter")),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
