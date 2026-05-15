import 'package:flory/screens/navigation_items/profile_items/newdeliveryaddress.dart';
import 'package:flory/screens/navigation_items/shopping_items/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/controllers/address_controller.dart';
import '../../../features/shop/controllers/cart_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/helpers/pricing_calculator.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _formKey = GlobalKey<FormState>();

  final addressController = AddressController.instance;
  final cartController = CartController.instance;

  // Text controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// Initialize text fields with the selected address
    final selected = addressController.selectedAddress.value;
    nameController.text = selected.name;
    phoneController.text = selected.phoneNumber;
    locationController.text = selected.street;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final totalPrice = cartController.totalCartPrice.value;

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
                child: Icon(
                  Iconsax.shopping_cart,
                  size: 40.sp,
                  color: Colors.white,
                )),
            SizedBox(width: 30.w),
          ])
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
                child: Icon(
                  Iconsax.shopping_cart,
                  size: 40.sp,
                  color: Colors.white,
                )),
            SizedBox(width: 30.w),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text("Checkout",
                        style: TextStyle(
                            fontFamily: "LibreBaskerville",
                            fontSize: 24.sp,
                            color: dark ? TColors.white : TColors.black))),
                SizedBox(height: 15.h),
                Text(
                  "Check out now & keep the beauty.",
                  style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),

                /// Location
                Text("Location",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Inter",
                        color: dark ? TColors.white : Colors.black)),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () async {
                    await addressController.selectNewAddressPopup(context);
                    // Update UI after selecting address
                    final selected = addressController.selectedAddress.value;
                    setState(() {
                      nameController.text = selected.name;
                      phoneController.text = selected.phoneNumber;
                      locationController.text = selected.street;
                    });
                  },
                  child: AbsorbPointer(
                    child: Obx(() =>
                        TextFormField(
                          controller: TextEditingController(
                            text: addressController.selectedAddress.value.street,
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Select a location"
                              : null,
                          style: TextStyle(fontSize: 20.sp, color: TColors.primary40),
                          decoration: InputDecoration(
                            suffixIcon:
                            Icon(Icons.arrow_drop_down_outlined, size: 28.r),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: dark
                                ? TColors.white.withOpacity(0.2)
                                : Colors.white,
                          ),
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                /// Name
                Text("Name",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Inter",
                        color: dark ? TColors.white : Colors.black)),
                SizedBox(height: 5.h),
                Obx(() =>
                    TextFormField(
                      controller: TextEditingController(
                        text: addressController.selectedAddress.value.name,
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Enter your name" : null,
                      style: TextStyle(fontSize: 20.sp),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(left: 15.w),
                        filled: true,
                        fillColor:
                        dark ? TColors.white.withOpacity(0.2) : Colors.white,
                      ),
                    ),
                ),



                SizedBox(height: 30.h),

                /// Phone number
                Text("Phone Number",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Inter",
                        color: dark ? TColors.white : Colors.black)),
                SizedBox(height: 5.h),
                Obx(() =>
                    TextFormField(
                      controller: TextEditingController(
                        text: addressController.selectedAddress.value.phoneNumber,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter phone number"
                          : null,
                      style: TextStyle(fontSize: 20.sp),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(left: 15.w),
                        filled: true,
                        fillColor:
                        dark ? TColors.white.withOpacity(0.2) : Colors.white,
                      ),
                    ),
                ),

                SizedBox(height: 20.h),
                Divider(thickness: 2, color: Colors.white),
                SizedBox(height: 20.h),

                /// Bag total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bag Total",
                        style:
                        TextStyle(fontSize: 16.sp, fontFamily: "Inter")),
                    Text(
                      "\$${TPricingCalculator.calculateTotalPrice(totalPrice, 'US')}",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Inter",
                          color: dark ? TColors.white : Colors.black),
                    ),
                  ],
                ),

                SizedBox(height: 50.h),

                Center(
                  child: Text(
                    "Your floral keepsake will be delivered \non July 22, 2025.",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "LibreBaskerville",
                        color: TColors.primary),
                  ),
                ),
                SizedBox(height: 30.h),
                Divider(thickness: 2, color: Colors.white),
                SizedBox(height: 60.h),

                /// Checkout Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)),
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 130.w, vertical: 10.h),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Paymentmethod()));
                      }
                    },
                    child: Text("Checkout",
                        style: TextStyle(
                            fontSize: 16.sp, fontFamily: "Inter")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
