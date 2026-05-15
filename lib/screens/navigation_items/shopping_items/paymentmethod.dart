import 'package:flory/features/shop/controllers/order_controller.dart';
import 'package:flory/screens/navigation_items/shopping_items/addcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/cart_controller.dart';
import '../../../features/shop/controllers/checkout_controller.dart';
import '../../../features/shop/models/PaymentMethodModel.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/helpers/pricing_calculator.dart';
import '../../../utils/loader/loaders.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Paymentmethod extends StatefulWidget {
  const Paymentmethod({super.key});

  @override
  State<Paymentmethod> createState() => _PaymentmethodState();
}

class _PaymentmethodState extends State<Paymentmethod> {
  String selectedMethod = "cod";
  late final PaymentMethodModel paymentMethod;
   final orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subtotal = cartController.totalCartPrice.value;
    final checkoutController = Get.put(CheckoutController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subtotal, 'US');
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
                  child: Icon(Iconsax.wallet, size: 40.sp, color: Colors.white),
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
                  child: Icon(Iconsax.wallet, size: 40.sp, color: Colors.white),
                ),
                SizedBox(width: 30.w),
              ],
            ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Payment Method",
                  style: TextStyle(
                    fontFamily: "LibreBaskerville",
                    fontSize: 24.sp,
                    color: dark ? TColors.white : TColors.black,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "We'll ship it to your address below",
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30.h),
              _buildCustomRadioTile(
                value: "cod",
                groupValue: selectedMethod,
                title: "Cash On Delivery",
                leadingIcon: Iconsax.money,
              ),
              SizedBox(height: 14.h),

              _buildCustomRadioTile(
                value: "card",
                groupValue: selectedMethod,
                title: "Credit / Depit Card",
                leadingIcon: Iconsax.card,
                expandChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 19.h),
                    Row(
                      children: [
                        SizedBox(width: 17.h),
                        Text(
                          "Payment Method",
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 83.h),
                        Container(
                          width: 80.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            // color: Color(0xffD9D9D9),
                          ),
                          child: TextButton(
                            onPressed: () =>
                                checkoutController.selectPaymentMethod(context),
                            child: Text(
                              "Change",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 15.sp,
                                color: TColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    Obx(
                      () => Row(
                        children: [
                          SizedBox(width: 17.w),
                          Image(
                            image: AssetImage(
                              checkoutController
                                  .selectedPaymentMethod
                                  .value
                                  .image,
                            ),
                            fit: BoxFit.contain,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            checkoutController.selectedPaymentMethod.value.name,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 30.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Addcard()),
                          );
                        },
                        child: Container(
                          width: 300.w,
                          height: 47.h,
                          decoration: BoxDecoration(
                            color: TColors.primary40,
                            border: Border.all(color: TColors.primary40),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 17.w),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: Colors.white,
                                ),
                                width: 31.w,
                                height: 31.h,
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: TColors.primary,
                                  size: 25.r,
                                ),
                              ),
                              SizedBox(width: 25),
                              Text(
                                "Add Card",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 14.h),
              _buildCustomRadioTile(
                value: "net",
                groupValue: selectedMethod,
                title: "Net Banking",
                leadingIcon: Iconsax.bank,
              ),
              SizedBox(height: 360.h),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 130.w,
                      vertical: 10.h,
                    ),
                  ),
                  onPressed:  subtotal > 0 ? () => orderController.processOrder(totalAmount)
                      : () => Loaders.warningSnackBar(title: 'Empty Cart' , message: 'Add items in the cart in order to proceed'),
                    child: Text("Checkout",style: TextStyle(fontSize: 16.sp,fontFamily: "Inter"),))

                ),
            ],)
          ),
        ),
    );
  }

  Widget _buildCustomRadioTile({
    required String value,
    required String groupValue,
    required String title,
    IconData? leadingIcon,

    Widget? expandChild,
  }) {
    bool isSelected = value == groupValue;
    final dark = THelperFunctions.isDarkMode(context);
    return Card(
      elevation: 4,
      shadowColor: dark ? TColors.primary40 : TColors.primary,
      child: Container(
        width: 342.w,
        // margin: const EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: dark ? TColors.primary40 : Colors.white,
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedMethod = value;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    children: [
                      // Custom radio circle
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? TColors.primary
                                : Color(0xFFB2ADAD),
                            width: 1,
                          ),
                          color: isSelected
                              ? TColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      if (leadingIcon != null)
                        Icon(leadingIcon, color: TColors.primary, size: 32.r),

                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Inter",
                            color: dark ? TColors.white : Colors.black,
                          ),
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 23.r,
                        color: TColors.primary40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Expansion if selected
            if (isSelected && expandChild != null) expandChild,
          ],
        ),
      ),
    );
  }
}
