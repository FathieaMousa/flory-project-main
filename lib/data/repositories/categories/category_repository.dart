import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flory/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

Future<List<CategoryModel>> getAllCategories() async{
  try{
  final snapshot = await _db.collection('categories').get();
  print("Fetched docs count: ${snapshot.docs.length}");

  final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
  return list;
  }catch(e){
    throw "Something went error";
  }
}

}