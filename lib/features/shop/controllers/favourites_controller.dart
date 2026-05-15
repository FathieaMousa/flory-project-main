import 'dart:convert';
import 'package:flory/data/repositories/categories/item_repository.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/utils/loader/loaders.dart';
import 'package:flory/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController{
  static FavouritesController get instance => Get.find();


  final favourites = <String,bool>{}.obs;

  bool get hasFavourites => favourites.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() {
    try {
      final raw = TLocalStorage.instance().readData('favourites');
      print("Stored favourites raw: $raw");

      if (raw == null || raw == '' || raw == '{}') {
        favourites.clear();
        return;
      }
      final decoded = jsonDecode(raw);

        if (decoded is Map<String, dynamic>) {
          favourites.value = decoded.map((k, v) => MapEntry(k, v == true));
        } else {
          favourites.clear();
          TLocalStorage.instance().saveData('favourites', jsonEncode({}));
      }
    } catch (e) {
      print("Error decoding favourites: $e");
      favourites.clear();
      TLocalStorage.instance().saveData('favourites', jsonEncode({}));
    }
  }

  bool isFavourites(String itemId) {
    return favourites[itemId] ?? false;
  }

  void toggleFavouritesItem(String itemId) {
    if(!favourites.containsKey(itemId)){
      favourites[itemId] = true;
      saveFavouritesToStorage();
      Loaders.customToast(message: 'Item has been added to the wishlist');
    }else{
      favourites.remove(itemId);
      saveFavouritesToStorage();
      favourites.refresh();
      Loaders.customToast(message: 'Item has been removed from the wishlist');
    }
  }

  void saveFavouritesToStorage() {
    try {
      final encodedFavourites = jsonEncode(favourites);
      TLocalStorage.instance().saveData('favourites', encodedFavourites);
    } catch (e) {
      print("Error saving favourites: $e");
    }
  }

  Future<List<ItemModel>> favouriteItems() async {
    print("Favourites content before fetch: $favourites");

    // Prevent repository call when favourites are empty
    if (favourites.isEmpty) {
      print("No favourites to fetch (controller).");
      return [];
    }

    try {
      final result = await ItemRepository.instance
          .getFavouriteItems(favourites.keys.toList());
      return result;
    } catch (e) {
      print("Error fetching favourite items: $e");
      return [];
    }
  }

  void clearFavourites() {
    favourites.clear();
    TLocalStorage.instance().saveData('favourites', jsonEncode({}));
    print("After removal favourites: ${favourites.keys}");

  }

}