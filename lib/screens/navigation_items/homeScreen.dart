import 'package:flory/features/shop/controllers/category_controller.dart';
import 'package:flory/features/shop/controllers/popular_items_controller.dart';
import 'package:flory/screens/categories/categories_screen.dart';
import 'package:flory/screens/detailsPage/detailsPage.dart';
import 'package:flory/screens/navigation_items/favourite_icon.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flory/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../widgets/search_Field.dart';
import '../detailsPage/artificialDetailsPage.dart';
class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final popularItemsController = Get.put(PopularItemsController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(35.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Welcome",
                  style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                    fontFamily: 'LibreBaskerville',
                    fontSize: 24,
                    color: dark ? TColors.light : TColors.black,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "Your stories, sealed in every flowers",
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 18.h),
              SearchField.searchFiled(context),
              SizedBox(height: 28.h),
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: dark ? TColors.light : TColors.black,
                ),
              ),
              SizedBox(height: 7.h),

              Obx((){
                if (categoryController.featuredCategories.isEmpty) {
                  print("Products list is empty in Obx");
                  return Text("No data found");
                }
                return Container(
                  width: double.infinity.w,
                  height: 76.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: categoryController.featuredCategories.length,
                    itemBuilder: (context, index) {
                      final category = categoryController.featuredCategories[index];
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(0, 5, 10, 6).r,
                        padding: EdgeInsets.fromLTRB(20, 0, 7, 0).r,
                        width: 100.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(color: TColors.primary, width: 1.w),
                        ),
                        child:  TextButton(
                            style:ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ) ,
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesScreen(category:category)));
                            },child: Text(category.name,
                          style: TextStyle(color: TColors.primary, fontSize: 16.sp),)

                        ),
                      );
                    },
                  ),
                );
              }
              ),
              SizedBox(height: 17.h),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 0).r,
                width: double.infinity.w,
                child: Row(
                  children: [
                    Text(
                      "Popular Items",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: dark ? TColors.light : TColors.black,
                      ),
                    ),
                    SizedBox(width: 110.w),
                    GestureDetector(
                      onTap: (){
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesScreen(category:category)));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 20.sp, color: TColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Obx((){
                if (popularItemsController.popularItems.isEmpty) {
                  print("Products list is empty in Obx");
                  return Text("No data found");
                }
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: double.infinity.w,
                  height: 270.h,
                  //  color: Colors.blue,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularItemsController.popularItems.length,
                    itemBuilder: (context, index) {
                      final popularItem = popularItemsController.popularItems[index];
                      return Container(
                        padding: EdgeInsets.only(right: 10.w),
                        margin: EdgeInsets.fromLTRB(0, 0, 2, 0).h.w,
                        width: 175.w,
                        height: 250.h,
                        // color: Colors.pink,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                if(popularItem.categoryId == "3"){
                                  Get.to(() => Artificialdetailspage(item: popularItem));
                                }else{
                                  Get.to(() => Detailspage(item: popularItem));
                                }

                              } ,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 145.w,
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                      color: TColors.primary,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                      border: Border.all(
                                        color: TColors.primary,
                                        width: 2.w,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: Image.network(
                                        popularItem.image,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 11.h,
                                      right: 11.w,
                                      child: TFavouriteIcon(
                                          itemId: popularItem.id)),
                                ],
                              ),
                            ),


                            SizedBox(height: 10.h),
                            Text(
                              popularItem.name,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: dark ? TColors.light : TColors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '\$${popularItem.price}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: TColors.primary,
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
