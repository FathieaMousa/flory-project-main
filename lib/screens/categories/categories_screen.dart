import 'package:flory/data/repositories/categories/item_repository.dart';
import 'package:flory/features/shop/controllers/category_controller.dart';
import 'package:flory/features/shop/controllers/item_controller.dart';
import 'package:flory/features/shop/models/cart_item_model.dart';
import 'package:flory/features/shop/models/category_model.dart';
import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/screens/detailsPage/artificialDetailsPage.dart';
import 'package:flory/screens/detailsPage/detailsPage.dart';
import 'package:flory/screens/navigation_items/favourite_icon.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flory/widgets/item_card_add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/services/shimmer_effect.dart';
import '../../features/shop/controllers/cart_controller.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/appbar_theme.dart';
import '../../utils/theme/custom_themes/text_theme.dart';
import '../../widgets/item_qantity_with_add_remove_button.dart';
import '../../widgets/search_Field.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final controller = Get.put(ItemController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: dark
          ? TAppbarTheme.darkAppBarTheme(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Iconsax.arrow_left_2),
            iconSize: 40.r,
            onPressed: () {
              Get.back();
            },
          ),
        ),
      )
          : TAppbarTheme.lightAppBarTheme(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0.w),
          child: IconButton(
            icon: Icon(Iconsax.arrow_left_2),
            iconSize: 40.r,
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.category.name,
                  style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                    fontFamily: 'LibreBaskerville',
                    fontSize: 24.sp,
                    color: dark ? TColors.light : TColors.black,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "In every frame, a story gently blooms",
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 18.h),
              SearchField.searchFiled(context),
              SizedBox(height: 30.h),

              /// Items Grid
              FutureBuilder<List<ItemModel>>(
                future: controller.fetchCategoryItems(
                    categoryId: widget.category.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const TShimmerEffect(
                      height: 190,
                      width: double.infinity,
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(fontFamily: "Inter", fontSize: 22),
                      ),
                    );
                  }

                  final items = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 19.h,
                      crossAxisSpacing: 32.w,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {
                          if (widget.category.id == "3") {
                            Get.to(() => Artificialdetailspage(item: item));
                          } else {
                            Get.to(() => Detailspage(item: item));
                          }
                        },
                        child: Stack(
                          children: [
                            /// Card
                            Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: TColors.primary, width: 1.r),
                                borderRadius: BorderRadius.circular(18.r),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// product image
                                  Container(
                                    width: 141.w,
                                    height: 165.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Image.network(item.image,
                                          fit: BoxFit.fitWidth),
                                    ),
                                  ),

                                  /// name + price + add button
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            '\$${item.price}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),

                                      Container(
                                          alignment: Alignment.center,
                                          width: 25.w,
                                             height: 25.h,
                                          decoration: BoxDecoration(
                                            color: TColors.primary,
                                            borderRadius: BorderRadius.circular(5.r),
                                          ),
                                          child: SizedBox(
                                                width: TSizes.iconLg * 1.2,
                                                height: TSizes.iconLg * 1.2,
                                            child: Center(
                                              child:  ItemCardAddToCartButton(item: item)
                                            ),
                                          )


                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// Favorite Icon
                            Positioned(
                                top: 16.h,
                                right: 16.w,
                                child: TFavouriteIcon(itemId: item.id))
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}