import 'package:flory/data/repositories/popular_items/popular_items_repository.dart';
import 'package:get/get.dart';

import '../../../utils/loader/loaders.dart';
import '../models/item_model.dart';

class PopularItemsController extends GetxController{
static PopularItemsController get instance => Get.find();

final isLoading = false.obs;
final itemRepository = Get.put(PopularItemsRepository());

RxList<ItemModel> popularItems = <ItemModel>[].obs;


@override
  void onInit() {
    fetchPopularItems();
  }


Future<List<ItemModel>> fetchPopularItems() async {
  try {
    isLoading.value = true;
    final items = await itemRepository.getPopularItems();
    popularItems.assignAll(items);// <-- This updates the observable
    return items;
  } catch (e) {
    Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    return [];
  }finally{
    isLoading.value = false;
  }
}
}