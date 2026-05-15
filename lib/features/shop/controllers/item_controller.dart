
import 'package:flory/data/repositories/categories/item_repository.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:get/get.dart';

import '../../../utils/loader/loaders.dart';


class ItemController extends GetxController{
  static ItemController get instance =>Get.find();

  final isLoading = false.obs;
  final itemRepository = Get.put(ItemRepository());
  RxList<ItemModel> categoryItems  = <ItemModel>[].obs;


  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ItemModel>> fetchCategoryItems({required String categoryId}) async {
    try {
      isLoading.value = true;
      final items = await itemRepository.getItemsForCategory(categoryId: categoryId);
      categoryItems.assignAll(items);   // updates the observable
      return items;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }finally{
      isLoading.value = false;
    }
  }



}