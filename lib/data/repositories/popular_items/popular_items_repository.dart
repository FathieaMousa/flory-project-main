import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/item_model.dart';

class PopularItemsRepository extends GetxController{
  static PopularItemsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Function to get popular items
  Future<List<ItemModel>> getPopularItems() async {
    try {
      final itemQuery = await _db
          .collection('Items')
          .where('isPopular' , isEqualTo: true)
          .get();
      List<ItemModel> items =
      itemQuery.docs.map((doc) => ItemModel.fromSnapshot(doc)).toList();
      return items;
    } catch (e) {
      print("Error fetching items: $e");
      return [];
    }
  }


}