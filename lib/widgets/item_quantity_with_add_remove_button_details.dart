import 'package:flory/features/shop/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../features/shop/models/cart_item_model.dart';
import '../features/shop/models/item_model.dart';

class ItemQuantityWithAddRemoveButtonDetails extends StatelessWidget {
  const ItemQuantityWithAddRemoveButtonDetails({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    //controller.updateAlreadyAddedProductCount(item);
    return  Obx(() {
      final qty = controller.itemQuantities[item.id] ?? 0;
      return Row(
        children: [
          IconButton(
            onPressed: qty > 0 ? () => controller.decreaseQuantity(item) : null,
            icon: Icon(Icons.remove, color: Colors.white),
          ),
          Text(
            qty.toString(),
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: () => controller.increaseQuantity(item),
            icon: Icon(Icons.add, color: Colors.white),
          ),
          // IconButton(
          //   onPressed: () {
          //     final cartItem = controller.cartItems.firstWhereOrNull(
          //           (c) => c.itemId == item.id,
          //     );
          //     if (cartItem != null) {
          //       controller.removeOneFromCart(cartItem);
          //     }
          //   },
          //   icon: Icon(Icons.remove, color: Colors.white),
          // ),
          //
          // Text(
          //   controller.getQuantityInCart(item.id).toString(),
          //   style: TextStyle(color: Colors.white),
          // ),
          //
          // IconButton(
          //   onPressed: () {
          //     final cartItem = CartItemModel(
          //       itemId: item.id,
          //       name: item.name,
          //       price: item.price,
          //       quantity: 1,
          //       image: item.image,
          //       description: item.description,
          //       includes: item.includes,
          //       categoryId: item.categoryId,
          //       variantKey: item.categoryId,
          //     );
          //     controller.addOneToCart(cartItem);
          //   },
          //   icon: Icon(Icons.add, color: Colors.white),
          // ),
        ],

      );
    }
    );
  }
}
// IconButton(
//   onPressed: () =>
//   // controller.itemQuantityInCart.value < 1 ? null : controller
//   //     .itemQuantityInCart.value -= 1,
//   qty < 1 ? null : () => controller.decreaseQuantity(item),
//   icon: Icon(
//     Icons.remove,
//     color: Colors.white,
//     size: 16.sp,
//   ),
// ),
// Text(qty.toString(),
//  // controller.itemQuantityInCart.value.toString(),
//   style: TextStyle(color: Colors.white),
// ),
// IconButton(
//   onPressed: () =>controller.increaseQuantity(item),
//   //controller.itemQuantityInCart.value += 1,
//   icon: Icon(
//     Icons.add,
//     color: Colors.white,
//     size: 16.sp,
//   ),
// ),