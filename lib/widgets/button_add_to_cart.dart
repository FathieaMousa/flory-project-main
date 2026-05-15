import 'package:flory/features/shop/controllers/cart_controller.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';
import '../utils/loader/loaders.dart';

class ButtonAddToCart extends StatelessWidget {
  const ButtonAddToCart({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
  // controller.updateAlreadyAddedProductCount(item);
    return  Obx(() {
      final qty = controller.itemQuantities[item.id] ?? 0;
      return   ElevatedButton(
        onPressed: qty < 1
            ? null
            : () {
          controller.addToCart(item); // add selected quantity
          controller.itemQuantities[item.id] = 0; // reset counter
        },
        //onPressed: qty < 1 ? null : () => controller.addToCart(item),
        //controller.itemQuantityInCart.value < 1 ? null : () => controller.addToCart(item),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 5.h),
          child:  Text(
            'Add To Cart',
            style: TextStyle(fontSize: 20.sp,
                color: TColors.white,
                fontWeight: FontWeight.w400
            ),
          ),

        ),
      );
    }
    );

  }
}
