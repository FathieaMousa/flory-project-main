import 'package:flory/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/cart_controller.dart';
import '../../../features/shop/controllers/order_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/helpers/pricing_calculator.dart';
import '../../../utils/loader/loaders.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Addcard extends StatefulWidget {
  const Addcard({super.key});

  @override
  State<Addcard> createState() => _AddcardState();
}

class _AddcardState extends State<Addcard> {
  bool save = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subtotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount =
    TPricingCalculator.calculateTotalPrice(subtotal, 'US');
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: dark
          ? TAppbarTheme.darkAppBarTheme(
          leading: Padding(
            padding: EdgeInsets.only(left: 20.0.w),
            child: IconButton(
              icon: Icon(Iconsax.arrow_left_2),
              iconSize: 40.r,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          actions: [
            SizedBox(width: 150.w),
            CircleAvatar(
                backgroundColor: TColors.primary40,
                radius: 40.r,
                child: Icon(
                  Iconsax.cards,
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
              onPressed: () {
                Get.back();
              },
            ),
          ),
          actions: [
            SizedBox(width: 150.w),
            CircleAvatar(
                backgroundColor: TColors.primary40,
                radius: 40.r,
                child: Icon(
                  Iconsax.cards,
                  size: 40.sp,
                  color: Colors.white,
                )),
            SizedBox(width: 30.w),
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding:
          EdgeInsets.symmetric(horizontal: 31.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text("Add Card",
                      style: TextStyle(
                          fontFamily: "LibreBaskerville",
                          fontSize: 24.sp,
                          color: dark
                              ? TColors.white
                              : TColors.black))),
              SizedBox(height: 15.h),
              Text(
                "We'll ship it to your address below",
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 35.h),
              Card(
                elevation: 4,
                shadowColor: TColors.primary,
                child: Container(
                  width: 350.w,
                  height: 460.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: dark
                        ? TColors.primary40
                        : Colors.white,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15.w),
                            Icon(Iconsax.card,
                                size: 32.r,
                                color: TColors.primary),
                            SizedBox(width: 12.w),
                            Text("Credit / Depit Card",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "Inter",
                                    color: dark
                                        ? TColors.white
                                        : Colors.black))
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                            width: 300.w,
                            height: 1.h,
                            color: TColors.primary40),
                        SizedBox(height: 30.h),

                        SizedBox(
                          width: 295.w,
                          height: 340.h,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text("Cardholder Name",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14.sp,
                                      color: dark
                                          ? TColors.white
                                          : Colors.black)),
                              SizedBox(height: 26.h),
                              SizedBox(
                                width: 295.w,
                                height: 32.h,
                                child: TextFormField(
                                  controller: _nameController,
                                  validator: (value) =>
                                  value == null ||
                                      value.isEmpty
                                      ? 'Please enter cardholder name'
                                      : null,
                                  style: TextStyle(fontSize: 20.sp),
                                  decoration: InputDecoration(
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          6.r),
                                      borderSide: BorderSide(
                                          color:
                                          TColors.primary40,
                                          width: 1.5.w),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          6.r),
                                      borderSide: BorderSide(
                                          color:
                                          TColors.primary,
                                          width: 2.w),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 15.w, top: 14.h, bottom: 14.h),
                                    hintText: "Enter your name",
                                    hintStyle: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 14.sp,
                                        color: dark
                                            ? TColors.primary
                                            : TColors
                                            .primary40),
                                    filled: true,
                                    fillColor: dark
                                        ? TColors.white
                                        .withOpacity(0.2)
                                        : Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(height: 23.h),

                              Text("Card Number",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14.sp,
                                      color: dark
                                          ? TColors.white
                                          : Colors.black)),
                              SizedBox(height: 26.h),
                              SizedBox(
                                width: 295.w,
                                height: 32.h,
                                child: TextFormField(
                                  controller:
                                  _numberController,
                                  keyboardType:
                                  TextInputType.number,
                                  validator: (value) =>
                                  value == null ||
                                      value.length < 16
                                      ? 'Enter a valid card number'
                                      : null,
                                  style: TextStyle(fontSize: 20.sp),
                                  decoration: InputDecoration(
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          6.r),
                                      borderSide: BorderSide(
                                          color:
                                          TColors.primary40,
                                          width: 1.5.w),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          6.r),
                                      borderSide: BorderSide(
                                          color:
                                          TColors.primary,
                                          width: 2.w),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 15.w, top: 14.h, bottom: 14.h),
                                    hintText:
                                    "1234 5678 9101 22592",
                                    hintStyle: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 14.sp,
                                        color: dark
                                            ? TColors.primary
                                            : TColors
                                            .primary40),
                                    filled: true,
                                    fillColor: dark
                                        ? TColors.white
                                        .withOpacity(0.2)
                                        : Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(height: 23.h),

                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Expiration Date",
                                          style: TextStyle(
                                              fontFamily:
                                              "Inter",
                                              fontSize:
                                              14.sp,
                                              color: dark
                                                  ? TColors
                                                  .white
                                                  : Colors
                                                  .black)),
                                      SizedBox(
                                          height: 24.h),
                                      SizedBox(
                                        width: 129,
                                        height: 32,
                                        child:
                                        TextFormField(
                                          controller:
                                          _expiryController,
                                          keyboardType:
                                          TextInputType
                                              .number,
                                          validator: (value) => TValidator.validateExpiryDate(value),
                                          style: TextStyle(
                                              fontSize:
                                              20.sp),
                                          decoration:
                                          InputDecoration(
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  6.r),
                                              borderSide:
                                              BorderSide(
                                                  color: TColors
                                                      .primary40,
                                                  width:
                                                  1.5.w),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  6.r),
                                              borderSide:
                                              BorderSide(
                                                  color:
                                                  TColors.primary,
                                                  width:
                                                  2.w),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 15.w,
                                                top: 14.h,
                                                bottom: 14.h),
                                            hintText:
                                            "02/2028",
                                            hintStyle: TextStyle(
                                                fontFamily:
                                                "Inter",
                                                fontSize:
                                                14.sp,
                                                color: dark
                                                    ? TColors
                                                    .primary
                                                    : TColors
                                                    .primary40),
                                            filled: true,
                                            fillColor: dark
                                                ? TColors
                                                .white
                                                .withOpacity(
                                                0.2)
                                                : Colors
                                                .white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10.w),

                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("CVV",
                                          style: TextStyle(
                                              fontFamily:
                                              "Inter",
                                              fontSize:
                                              14.sp,
                                              color: dark
                                                  ? TColors
                                                  .white
                                                  : Colors
                                                  .black)),
                                      SizedBox(
                                          height: 20.h),
                                      SizedBox(
                                        width: 129.w,
                                        height: 37.w,
                                        child:
                                        TextFormField(
                                          
                                          controller:
                                          _cvvController,
                                          keyboardType:
                                          TextInputType
                                              .number,
                                          validator: (value) =>TValidator.validateCvv(value),
                                          style: TextStyle(
                                              fontSize:
                                              20.sp),
                                          decoration:
                                          InputDecoration(
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  6.r),
                                              borderSide:
                                              BorderSide(
                                                  color: TColors
                                                      .primary40,
                                                  width:
                                                  1.5.w),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  6.r),
                                              borderSide:
                                              BorderSide(
                                                  color:
                                                  TColors.primary,
                                                  width:
                                                  2.w),
                                            ),
                                            contentPadding: EdgeInsets
                                                .symmetric(vertical: 12.h,
                                                horizontal: 15.w),
                                            hintText:
                                            "...",
                                            hintStyle: TextStyle(
                                                fontFamily:
                                                "Inter",
                                                fontSize:
                                                14.sp,
                                                color: dark
                                                    ? TColors
                                                    .primary
                                                    : TColors
                                                    .primary40),
                                            filled: true,
                                            fillColor: dark
                                                ? TColors
                                                .white
                                                .withOpacity(
                                                0.2)
                                                : Colors
                                                .white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 0,)
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(height: 15.h),

                              Row(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [
                                  Transform.scale(
                                    scale: 0.9,
                                    child: Checkbox(
                                        materialTapTargetSize:
                                        MaterialTapTargetSize
                                            .shrinkWrap,
                                        visualDensity:
                                        VisualDensity(
                                            horizontal:
                                            -4.w,
                                            vertical:
                                            -4.h),
                                        checkColor:
                                        Colors.white,
                                        activeColor:
                                        TColors.primary,
                                        side: BorderSide(
                                          color: TColors
                                              .primary40,
                                          width: 1.5.w,
                                        ),
                                        value: save,
                                        onChanged: (value) {
                                          setState(() {
                                            save =
                                            value!;
                                          });
                                        }),
                                  ),
                                  const SizedBox(width: 0),
                                  Text(
                                      "Save this card for faster payment",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily:
                                          "Inter",
                                          color: Color(
                                              0xFFB2ADAD))),
                                ],
                              ) ,
                             /// SizedBox(height: 50.h,)

                            ],
                          ),
                        ) ,
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 150.h),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25.r)),
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 130.w,
                        vertical: 10.h),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!
                        .validate()) {
                      if (!save) {
                        Loaders.warningSnackBar(
                            title:
                            'Checkbox Required',
                            message:
                            'Please agree to save the card to proceed');
                        return;
                      }

                      if (subtotal > 0) {
                        orderController
                            .processOrder(
                            totalAmount);
                      } else {
                        Loaders.warningSnackBar(
                            title:
                            'Empty Cart',
                            message:
                            'Add items in the cart in order to proceed');
                      }
                    } else {
                      Loaders.warningSnackBar(
                          title:
                          'Validation Error',
                          message:
                          'Please fill all fields properly');
                    }
                  },
                  child: Text("Pay Now",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily:
                          "Inter")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}