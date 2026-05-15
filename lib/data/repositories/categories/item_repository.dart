import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/utils/exceptions/firebase_exceptions.dart';
import 'package:flory/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ItemRepository extends GetxController {
  static ItemRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Function to fetch items for each category
  Future<List<ItemModel>> getItemsForCategory({required String categoryId,}) async {
    try {
      print("Fetching items for categoryId: $categoryId");

      //Searching to get the category items by id
      QuerySnapshot itemCategoryQuery = await _db
          .collection('ItemCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // fetch items id , convert to string
      List<String> itemsIds = itemCategoryQuery.docs
          .map((doc) => doc['itemId'] as String)
          .toList();
      print("Item IDs found: $itemsIds");

      if (itemsIds.isEmpty) return [];

      // get items by id's
      final itemQuery = await _db
          .collection('Items')
          .where(FieldPath.documentId, whereIn: itemsIds)
          .get();

      print("Items docs: ${itemQuery.docs.length}");
      for (var doc in itemQuery.docs) {
        print("Doc: ${doc.id}, Data: ${doc.data()}");
      }
      List<ItemModel> items = itemQuery.docs
          .map((doc) => ItemModel.fromSnapshot(doc))
          .toList();
      return items;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("Error fetching items: $e");
      return [];
    }
  }

  // Function to get all items without conditions
  Future<List<ItemModel>> getAllItems() async {
    try {
      final snapshot = await _db.collection('Items').get();

      return snapshot.docs
          .map(
            (doc) => ItemModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching items";
    }
  }

   // Function to search for items
  Future<List<ItemModel>> searchItems(String query) async {
    try {
      final String searchQuery = query.toLowerCase();
      QuerySnapshot snapshot = await _db
          .collection('Items')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: searchQuery + 'z')
          .limit(20)
          .get();
    // search in description if not found in names
      if (snapshot.docs.isEmpty) {
        snapshot = await _db
            .collection('Items')
            .where('description', isGreaterThanOrEqualTo: searchQuery)
            .where('description', isLessThan: searchQuery + 'z')
            .limit(20)
            .get();
      }
        // convert to list
      return snapshot.docs
          .map(
            (doc) => ItemModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
      // catch exceptions
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try again";
    }
  }

  // Function to get favourite items by ids
  Future<List<ItemModel>> getFavouriteItems(List<String> itemIds) async {
    try {
      print("getFavouriteItems called with: $itemIds");
      if (itemIds.isEmpty) return [];

      final snapshot = await _db
          .collection('Items')
          .where(FieldPath.documentId, whereIn: itemIds)
          .get();

      return snapshot.docs
          .map((querySnapshot) => ItemModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("Error in getFavouriteItems: $e");
      throw "Something went wrong, Please try again";
    }
  }
}
