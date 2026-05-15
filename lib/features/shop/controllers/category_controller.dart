import 'package:flory/data/repositories/categories/category_repository.dart';
import 'package:flory/features/shop/models/category_model.dart';
import 'package:get/get.dart';

import '../../../utils/loader/loaders.dart';

class CategoryController extends GetxController{

  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }



  Future<void> fetchCategories() async{
    try{
    isLoading.value = true;

    final categories = await _categoryRepository.getAllCategories();

    print("Fetched Categories: ${categories.map((c) => '${c.name}, parentId: ${c.parentId}, isFeatured: ${c.isFeatured}').toList()}");

    allCategories.assignAll(categories);
    featuredCategories.assignAll(
        allCategories.where((category) => category.isFeatured).take(4).toList()
    );
    }catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }


}

