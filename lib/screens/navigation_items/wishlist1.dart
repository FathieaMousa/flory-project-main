import 'package:flory/data/services/shimmer_effect.dart';
import 'package:flory/features/shop/controllers/favourites_controller.dart';
import 'package:flory/screens/navigation_items/favourite_icon.dart';
import 'package:flory/widgets/item_card_add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../features/shop/models/item_model.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/text_theme.dart';
import '../../widgets/search_Field.dart';
import '../detailsPage/artificialDetailsPage.dart';
import '../detailsPage/detailsPage.dart';

class Wishlist1 extends StatefulWidget {
  const Wishlist1({super.key});

  @override
  State<Wishlist1> createState() => _Wishlist1State();
}

class _Wishlist1State extends State<Wishlist1> {

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Wish List",style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                fontFamily: 'LibreBaskerville',
                fontSize: 24,
                color: dark ? TColors.light : TColors.black,
              ),
              ),  ),
              SizedBox(height: 15.h,),
              Text("Loved it? Don't lose it",style: TextStyle(fontSize: 24.sp,fontFamily: "ScheherazadeNew",color:TColors.primary)),
              SizedBox(height: 18.h,),
              SearchField.searchFiled(context),
              SizedBox(height: 10.h,),
              Container(
                padding: EdgeInsets.only(left: 0.w),
                margin: EdgeInsets.only(left: 0.w),
                child:
                Obx(() {
                  final emptyWidget = Container(
                    height: 300.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.h,),
                          Icon(
                            Iconsax.heart,
                            size: 50.sp,
                            color: TColors.primary,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Your wishlist is empty',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Start adding items you love',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  );
                  if (controller.favourites.isEmpty) {
                    print("Wishlist empty → skip FutureBuilder");
                    return emptyWidget;
                  }

                    return FutureBuilder<List<ItemModel>>(
                      future: controller.favouriteItems(),
                      builder: (context, snapshot) {
                        const loader = TShimmerEffect(height: 23, width: 23);
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return loader;
                        }

                        if (snapshot.hasError) {
                          print("Error loading favourites: ${snapshot.error}");
                          return emptyWidget;
                        }
                        final items = snapshot.data!;
                        if (items.isEmpty) {
                          print("FutureBuilder returned empty list");
                          return emptyWidget;
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return GestureDetector(
                              onTap: () {
                                if (item.categoryId == "3") {
                                  Get.to(() => Artificialdetailspage(item: item));
                                } else {
                                  Get.to(() => Detailspage(item: item));} } ,
                          child: Column(
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 150.h,
                                    color: dark ? TColors.blackF : TColors.primaryBackground,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 111.w,
                                          height: 122.h,
                                          margin: EdgeInsets.only(bottom: 5.h),
                                          padding: EdgeInsets.all(4.r),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(18.r),
                                            border: Border.all(color: TColors.primary, width: 1.w),
                                            boxShadow: [
                                              BoxShadow(
                                                color: TColors.primary40,
                                                offset: Offset(0, 1.h),
                                                spreadRadius: 1.r,
                                                blurRadius: 4.r,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                              children: [
                                                SizedBox( width: 102.w, height: 113.h, child: ClipRRect( borderRadius: BorderRadius.circular(14.r), child:Image.network(item.image,fit: BoxFit.fitWidth,),), ),
                                                Positioned( top: 8.h, right: 5.w, child: TFavouriteIcon(itemId: item.id), )
                                              ] ), ),
                                        Container(
                                          width: 150.w,
                                          height: 100.h,
                                          // color: Colors.purple,
                                          padding: EdgeInsets.only(top: 6.h),
                                          margin: EdgeInsets.only(left: 15.w),
                                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(item.name,style: TextStyle(fontFamily: "Inter",fontSize: 15.sp,color: TColors.primary),
                                              ),
                                              SizedBox(height: 10.h,), Text(item.price.toString(),
                                                  style: TextStyle(fontFamily: "Inter",fontSize: 16.sp,color: Colors.black)),
                                            ],
                                          ),
                                        ), SizedBox(width: 10.w,),
                                        Container(
                                            alignment: Alignment.center,
                                            width: 45.w,
                                            height: 38.h,
                                            decoration: BoxDecoration(
                                              color: TColors.primary,
                                              borderRadius: BorderRadius.circular(5.r), ),
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Center(
                                                  child: ItemCardAddToCartButton(item: item) ), ) ),
                                      ],
                                    ) ),

                                Divider( thickness: 2, color: TColors.primary, ),
                              ],
                            )
                            );
                          },
                        );
                      },
                    );



                })

              ),
              SizedBox(height: 50.w,),
            ],
          ),
        ),
      ),
    );
  }
}