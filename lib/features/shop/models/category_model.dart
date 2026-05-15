
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String id;
  String name;
  String parentId;
  bool isFeatured;


  CategoryModel({
    required this.id,
    required this.name,
    required this.isFeatured,
     this.parentId = '',
});


  static CategoryModel empty() => CategoryModel(id: '', name: '', isFeatured: false);
  Map<String,dynamic>toJson(){
    return{
      'name':name,
      'isFeatured':isFeatured,
      'parentId':parentId
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;
      
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? '',
          parentId: data['parentId'] ?? '',
          isFeatured: data['isFeatured'] ?? false
      );
    }else{
      return CategoryModel.empty();
    }
  }



}