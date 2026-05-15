import 'package:flory/features/shop/controllers/address_controller.dart';
import 'package:flory/features/shop/models/cart_item_model.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flory/utils/loader/loaders.dart';
import 'package:flory/utils/local_storage/storage_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/constants/colors.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  //variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt itemQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxMap<String, int> itemQuantities = <String, int>{}.obs;
  RxList<String> addressesList = <String>[].obs;
  RxString selectedAddress = ''.obs;
  final addressController = AddressController.instance;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  // function to get addresses
  void loadAddresses() async {
    try {
      final addresses = await addressController.getAllUserAddresses();

      // convert each address to string
      addressesList.assignAll(
        addresses
            .map(
              (address) =>
                  '${address.street}, ${address.city}, ${address.state}',
            )
            .toList(),
      );

      if (addressesList.isNotEmpty && selectedAddress.isEmpty) {
        selectedAddress.value = addressesList.first;
      }
    } catch (e) {
      print('Error loading addresses: $e');
    }
  }

  // Function to add items to the cart
  void addToCart(ItemModel item, {String variantKey = ""}) {
    final qty = itemQuantities[item.id] ?? 0;
    if (qty < 1) {
      Loaders.customToast(message: 'Select Quantity');
      return;
    }
    // create a CartItemModel with the selected quantity
    final selectedCartItem = convertToCartItem(item, qty);

    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.itemId ==
          selectedCartItem
              .itemId ,
    );
    if (index >= 0) {
      // increase existing cart item quantity
      cartItems[index].quantity += selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    // reset selected quantity for that product (optional UX)
    itemQuantities[item.id] = 0;
    updateCart();
    Loaders.customToast(message: '${item.name} added to cart');
  }

  void increaseQuantity(ItemModel item) {
    itemQuantities[item.id] = (itemQuantities[item.id] ?? 0) + 1;
  }

  void decreaseQuantity(ItemModel item) {
    final cur = (itemQuantities[item.id] ?? 0);
    if (cur > 0) itemQuantities[item.id] = cur - 1;
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) => cartItem.itemId == item.itemId,
    );
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) => cartItem.itemId == item.itemId,
    );
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: "Remove Item",
      titleStyle: TextStyle(
          fontSize: 20 ,
          color: TColors.primary
      ),
      titlePadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
      contentPadding: EdgeInsets.all(20),
      backgroundColor: THelperFunctions.isDarkMode(Get.context!) ? TColors.black : TColors.primaryBackground,
      buttonColor: TColors.primary,
      middleText: "Are you sure you want to remove this item?",
      middleTextStyle: TextStyle(
          fontSize: 16.sp
      ),
      cancelTextColor: THelperFunctions.isDarkMode(Get.context!) ?TColors.primaryBackground :TColors.primary ,
      confirmTextColor: TColors.white,
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        Loaders.customToast(message: 'Item removed from the Cart');
        Get.back();
      },
      onCancel: () =>
          () => Get.back(),
    );
  }

  CartItemModel convertToCartItem(ItemModel item, int quantity) {
    final isCustomization = item.categoryId == "1" || item.categoryId == "4";
    final variantKey = isCustomization ? "customization" : "simple";
    return CartItemModel(
      itemId: item.id,
      name: item.name,
      price: item.price,
      quantity: quantity,
      image: item.image,
      description: item.description,
      includes: item.includes,
      categoryId: item.categoryId,
      variantKey: variantKey.isNotEmpty ? variantKey : item.categoryId,
    );
  }

  void updateAlreadyAddedProductCount(ItemModel item) {
    // set the selection counter to how many of this item are already in the cart
    itemQuantities[item.id] = getItemQuantityInCart(item.id);
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedTotalPrice += item.totalPrice;
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemsStrings = cartItems.map((item) => item.toJson()).toList();
    print("Saving cart items: $cartItemsStrings");

    TLocalStorage.instance().saveData('cartItems', cartItemsStrings);
  }

  void loadCartItems() {
    try {
      final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>(
        'cartItems',
      );
      print("Loaded cart items: $cartItemStrings");

      print("Loaded cart items from storage: $cartItemStrings");
      if (cartItemStrings != null) {
        cartItems.assignAll(
          cartItemStrings.map(
            (item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)),
          ),
        );

        updateCartTotals();
      }
    } catch (e) {
      print("Cart load failed: $e");
    }
  }

  int getItemQuantityInCart(String itemId) {
    final foundItem = cartItems
        .where((item) => item.itemId == itemId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getQuantityInCart(String itemId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  void updateItemCustomization({required String itemId, required String name, required String date, required String message, String? deliveryAddress,
    String? flowerOption,
  }) {
    final index = cartItems.indexWhere((item) => item.itemId == itemId);

    if (index != -1) {
      final currentItem = cartItems[index];
      final updatedItem = CartItemModel(
        itemId: currentItem.itemId,
        name: currentItem.name,
        price: currentItem.price,
        quantity: currentItem.quantity,
        image: currentItem.image,
        description: currentItem.description,
        includes: currentItem.includes,
        categoryId: currentItem.categoryId,
        variantKey: currentItem.variantKey,
        customizationData: {
          'name': name,
          'date': date,
          'message': message,
          'deliveryAddress': deliveryAddress,
          'flowerOption': flowerOption,
          'timestamp': DateTime.now().toString(),
        },
      );

      cartItems[index] = updatedItem;

      updateCart();
      Loaders.customToast(message: 'customization details saved!');
    }
  }

  Map<String, dynamic>? getCustomizationData(String itemId) {
    final item = cartItems.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => CartItemModel.empty(),
    );
    return item.customizationData;
  }

  bool hasCustomization(String itemId) {
    final item = cartItems.firstWhere(
      (item) => item.itemId == itemId,
      orElse: () => CartItemModel.empty(),
    );
    return item.customizationData != null;
  }

  void clearCart() {
    itemQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
