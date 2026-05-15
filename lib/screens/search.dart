import 'package:flory/features/shop/controllers/search_controller.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/screens/detailsPage/detailsPage.dart';
import 'package:flory/screens/navigation_items/favourite_icon.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = Get.put(SearchCtr());
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark ? TColors.blackF :TColors.primaryBackground,
        scrolledUnderElevation: 0,
        title: _buildSearchField(dark),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildSearchBody(dark),
    );
  }

  Widget _buildSearchField(bool dark) {
    return Container(
      decoration: BoxDecoration(
        color: dark ? TColors.primary40 : TColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: _searchTextController,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search products...",
          hintStyle: TextStyle(fontSize: 18.sp, color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: TColors.primary),
          suffixIcon: Obx(() => controller.searchQuery.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: TColors.primary),
            onPressed: () {
              controller.clearSearch();
              _searchTextController.clear();
            },
          )
              : Icon(Icons.clear)),
        ),
        onChanged: controller.onSearchChanged,
      ),
    );
  }

  Widget _buildSearchBody(bool dark) {
    return Obx(() {

      if (controller.searchQuery.isEmpty) {
        return _buildSearchHistory(dark);
      }

      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: TColors.primary));
      }
      if (controller.searchQuery.isNotEmpty && controller.searchResults.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
              SizedBox(height: 16.h),
              Text('No results found for "${controller.searchQuery}"'),
            ],
          ),
        );
      }
      return ListView.builder(
        itemCount: controller.searchResults.length,
        itemBuilder: (context, index) {
          final item = controller.searchResults[index];
          return _buildSearchResultItem(item, dark);
        },
      );
    });
  }
  Widget _buildSearchResultItem(ItemModel item, bool dark) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ListTile(
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: NetworkImage(item.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          item.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            color: TColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: TFavouriteIcon(itemId: item.id),
        onTap: () => _openProductDetails(item),
      ),
    );
  }

  Widget _buildSearchHistory(bool dark) {
    return FutureBuilder<List<String>>(
      future: _getSearchHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.grey),
                SizedBox(height: 16.h),
                Text(
                  'No search history',
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Products you view will appear here',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        final historyIds = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Text(
                    'Recently Viewed',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Spacer(),
                  if (historyIds.isNotEmpty)
                    TextButton(
                      onPressed: _clearSearchHistory,
                      child: Text(
                        'Clear All',
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: historyIds.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<ItemModel?>(
                    future: _getItemById(historyIds[index]),
                    builder: (context, itemSnapshot) {
                      if (!itemSnapshot.hasData || itemSnapshot.data == null) {
                        return SizedBox.shrink();
                      }

                      final item = itemSnapshot.data!;
                      return _buildHistoryItem(item, dark);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoryItem(ItemModel item, bool dark) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: ListTile(
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            image: DecorationImage(
              image: NetworkImage(item.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          item.name,
          style: TextStyle(fontSize: 14.sp),
        ),
        subtitle: Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 12.sp, color: TColors.primary),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close, size: 18.sp),
          onPressed: () => _removeFromHistory(item.id),
        ),
        onTap: () => _openProductDetails(item),
      ),
    );
  }

  void _openProductDetails(ItemModel item) async {
    await _saveToSearchHistory(item);
    Get.to(() => Detailspage(item: item));
  }

  Future<void> _saveToSearchHistory(ItemModel item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> currentHistory = prefs.getStringList('search_history') ?? [];

      currentHistory.removeWhere((id) => id == item.id);
      currentHistory.insert(0, item.id);

      if (currentHistory.length > 10) {
        currentHistory = currentHistory.sublist(0, 10);
      }

      await prefs.setStringList('search_history', currentHistory);
      if (mounted) setState(() {});

    } catch (e) {
      print('Error saving to history: $e');
    }
  }

  Future<List<String>> _getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('search_history') ?? [];
  }

  Future<ItemModel?> _getItemById(String itemId) async {
    try {
      final items = await controller.getAllItems();
      return items.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _removeFromHistory(String itemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> currentHistory = prefs.getStringList('search_history') ?? [];
      currentHistory.removeWhere((id) => id == itemId);
      await prefs.setStringList('search_history', currentHistory);

      if (mounted) setState(() {});
    } catch (e) {
      print('Error removing from history: $e');
    }
  }

  Future<void> _clearSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('search_history');

      if (mounted) setState(() {});
    } catch (e) {
      print('Error clearing history: $e');
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}