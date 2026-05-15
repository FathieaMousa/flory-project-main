import 'package:flory/features/shop/controllers/cart_controller.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';
import '../utils/loader/loaders.dart';

class ItemCardAddToCartButton extends StatelessWidget {
  const ItemCardAddToCartButton({super.key, required this.item});

  final ItemModel item;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
       final cartItem = cartController.convertToCartItem(item, 1);
       cartController.addOneToCart(cartItem);
       Loaders.customToast(message: '${item.name} added to cart');

      },
      child: Obx(() {
        final itemQuantityInCart = cartController.getItemQuantityInCart(item.id);
        return Container(
          alignment: Alignment.center,
          width: 50.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius:
            BorderRadius.circular(5.r),
          ),
          child: SizedBox(
            width: 19.w,
            height: 19.h,
            child: Center(
              child:  Icon(Icons.add,
                  color: Colors.white, size: 20.sp),
            ),
          ),

        );
      }

      ),
    );
  }
}
