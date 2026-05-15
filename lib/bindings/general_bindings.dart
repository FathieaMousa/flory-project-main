import 'package:flory/features/shop/controllers/favourites_controller.dart';
import 'package:flory/utils/network/network_manager.dart';
import 'package:get/get.dart';

import '../data/repositories/categories/item_repository.dart';
import '../features/shop/controllers/address_controller.dart';
import '../features/shop/controllers/cart_controller.dart';
import '../features/shop/controllers/category_controller.dart';
import '../features/shop/controllers/popular_items_controller.dart';
import '../features/shop/controllers/search_controller.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CartController());
    Get.put(FavouritesController());
    Get.put(SearchCtr());
    Get.put(ItemRepository());


  }


}