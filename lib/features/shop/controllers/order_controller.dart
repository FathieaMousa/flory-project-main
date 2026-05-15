import 'package:flory/data/repositories/authentication/authentication_repository.dart';
import 'package:flory/features/shop/controllers/address_controller.dart';
import 'package:flory/features/shop/controllers/cart_controller.dart';
import 'package:flory/screens/RegisterScreens/success_screen.dart';
import 'package:flory/utils/constants/enums.dart';
import 'package:flory/utils/constants/image_strings.dart';
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flory/utils/loader/loaders.dart';
import 'package:flory/widgets/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/order/order_repository.dart';
import '../models/order_model.dart';

class OrderController extends GetxController{
  static OrderController get instance =>Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  // final checkoutController =
 final orderRepository = Get.put(OrderRepository());

// fetch user's order history
Future<List<OrderModel>> fetchUserOrders() async{
  try{
    final userOrders = await orderRepository.fetchUserOrders();
    return userOrders;
  } catch(e){
    Loaders.warningSnackBar(title: 'Oh Snap!' , message: e.toString());
    return [];
  }
}

//  methods for order Processing
void processOrder(double totalAmount) async {
  try{
    // Start Loader
    THelperFunctions.openLoadDialog('Processing your order', TImages.loaderAsset);

    // Get user authentication id
    final userId = AuthenticationRepository.instance.authUser!.uid;
    if(userId.isEmpty) return;

    final Map<String, dynamic> customizationData = {};
    for (final item in cartController.cartItems) {
      if (item.customizationData != null && item.customizationData!.isNotEmpty) {
        customizationData[item.itemId] = item.customizationData!;
      }
    }
    // add details
    final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.shipped,
        items: cartController.cartItems.toList(),
        deliveryDate: DateTime.now(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        address: addressController.selectedAddress.value,
        customizationData: customizationData.isNotEmpty? customizationData: null
     //  paymentMethod: checkoutController.selectedPaymentMethod.value.name,
    );
    await orderRepository.saveOrder(order, userId);

    // update the cart status
    cartController.clearCart();
    // show success screen
    Get.off(()=> SuccessScreen(
        image: TImages.orderCompleted,
        tittle: 'Payment success!',
        subTittle: 'your item will be shipped soon!',
        onPressed: ()=> Get.offAll(()=> NavigationMenu())
    ));
  } catch(e) {
    Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    THelperFunctions.stopLoading();
  }
}

}