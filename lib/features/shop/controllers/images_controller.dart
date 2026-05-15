import 'package:flory/features/shop/models/item_model.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController{
  static ImagesController get instance =>Get.find();

  RxString selectedItemsImages = ''.obs;


  List<String> getAllItemsImages(ItemModel item){
    Set<String> images = {};
    
    images.add(item.image);

    selectedItemsImages.value = item.image;
    return images.toList();
  }
}