
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flory/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../screens/navigation_items/homeScreen.dart';
import '../screens/navigation_items/profile.dart';
import '../screens/navigation_items/shoppingBag.dart';
import '../screens/navigation_items/wishlist1.dart';
import '../utils/constants/colors.dart';
import '../utils/theme/custom_themes/appbar_theme.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar:  dark ? TAppbarTheme.darkAppBarTheme() : TAppbarTheme.lightAppBarTheme(),
      drawer: DrawerNav(),
      body: Stack(
          children: [
            Obx(() => controller.screens[controller.selectedIndex.value]),
            Positioned(
              bottom: 0,
              left:20 ,
              right: 20,
              child: Obx(
                    () => Container(
                  width: 281.w,
                  height: 40.h,
                  // padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 4.h),
                  margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavItem(
                          icon: Iconsax.home,
                          index: 0,
                          controller: controller,
                        ),
                        SizedBox(width: 30.w),
                        _buildNavItem(
                          icon: Iconsax.heart,
                          index: 1,
                          controller: controller,
                        ),
                        SizedBox(width: 30.w),
                        _buildNavItem(
                          icon: Iconsax.shopping_cart,
                          index: 2,
                          controller: controller,
                        ),
                        SizedBox(width: 30.w),
                        _buildNavItem(
                          icon: Iconsax.user,
                          index: 3,
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ]
      ) ,

    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required NavigationController controller,
  }) {
    bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.selectedIndex.value = index;

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? TColors.light : TColors.primaryBackground,
            size: 22.sp,
          ),
          SizedBox(height: 3.h,),
          Container(
            width: 20.w,
            height: 1.h,
            decoration: BoxDecoration(
              color: isSelected ? TColors.light : Colors.transparent,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [HomeScreen(), Wishlist1(), ShoppingBag(), Profile()];

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void goToHome() {
    selectedIndex.value = 0;
  }

}
