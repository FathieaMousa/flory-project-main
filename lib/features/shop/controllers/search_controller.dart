import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/repositories/categories/item_repository.dart';


class SearchCtr extends GetxController {
  static SearchCtr get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var searchQuery = ''.obs;
  var searchResults = <ItemModel>[].obs;
  var isLoading = false.obs;

  Timer? _debounceTimer;

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      _searchItems(query);
    });
  }

  Future<void> _searchItems(String query) async {
    try {
      isLoading.value = true;
      print('Searching: $query');

      final snapshot = await _db.collection('Items').get();
      print('Total items in DB: ${snapshot.docs.length}');

      final results = snapshot.docs.where((doc) {
        final data = doc.data();
        final name = data['name']?.toString().toLowerCase() ?? '';
        final description = data['description']?.toString().toLowerCase() ?? '';
        final searchLower = query.toLowerCase();

        return name.contains(searchLower) || description.contains(searchLower);
      }).map((doc) {
        return ItemModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      searchResults.value = results;
      print(' Search results: ${results.length}');

    } catch (e) {
      print(' Search failed: $e');
      searchResults.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ItemModel>> getAllItems() async {
    try {
      final snapshot = await _db.collection('Items').get();
      return snapshot.docs
          .map((doc) => ItemModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    } catch (e) {
      print('Error getting all items: $e');
      return [];
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    _debounceTimer?.cancel();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}