import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel{
  String id;
  String categoryId;
  String name;
  String description;
  String image;
  bool isFeatured;
  double price;
  Map<String, dynamic>? includes;

   ItemModel({
    required this.id,
     required this.categoryId,
     required this.name,
     this.description ='',
     this.image = '',
     required this.isFeatured,
     this.price = 0.0,
     required this.includes

  });

  static ItemModel empty() =>
      ItemModel(id: '', categoryId: '', name: '', description: '', image: '', isFeatured: false, price: 0, includes: {
  });

  Map<String,dynamic>toJson(){
    return{
      'categoryId':categoryId,
      'name':name,
      'description':description,
      'image':image,
      'isFeatured':isFeatured,
      'price':price,
      'includes':includes
    };
  }

  factory ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null) return ItemModel.empty();
      final data = document.data()!;
      return ItemModel(
          id: document.id,
          categoryId: data['categoryId'] ?? '',
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          image: data['image'] ?? '',
          isFeatured: data['isFeatured'] ?? false,
          price:double.parse((data['price'] ?? 0.0).toString()),
          includes: data['includes'] != null
            ? Map<String, dynamic>.from(data['includes'])
            : null,
      );

  }


}