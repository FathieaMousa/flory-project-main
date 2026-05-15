import 'package:flory/features/shop/controllers/order_controller.dart';
import 'package:flory/screens/drawer_items/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import '../screens/drawer_items/notifications.dart';
import '../screens/drawer_items/orders/ordertracking.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/loader/loaders.dart';
import '../utils/network/network_manager.dart';
import 'app_mode_bottomSheet.dart';
import 'navigation_menu.dart';

class DrawerNav extends StatelessWidget {
  const DrawerNav({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Drawer(
      backgroundColor: dark ? TColors.blackF : TColors.primaryBackground,
      width: THelperFunctions.screenWidth() * 0.7.w,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
          bottom: Radius.circular(0.r),
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(30.w, 40.h, 0, 0),
        child: ListView(
          children: [
            ListTile(
              title: Text("Home"),
              leading: Icon(Iconsax.home, size: 30.sp, color: TColors.primary),
              onTap: () {
                Get.find<NavigationController>().goToHome();
                Navigator.pop(context);
              },
            ),
            //  SizedBox(height: 5,),
            ListTile(
              title: Text("Notification"),
              leading: Icon(
                Iconsax.notification,
                size: 30.sp,
                color: TColors.primary,
              ),
              onTap: () {
                Get.to(Notifications());
              },
            ),
            ListTile(
              title: Text("Order Tracking"),
              leading: Icon(
                Icons.track_changes,
                size: 30.sp,
                color: TColors.primary,
              ),
              onTap: () {
                Get.to(OrdersScreen());
              },
            ),
            ListTile(
              title: Text("App Mode"),
              leading: Icon(
                Iconsax.colorfilter,
                size: 30.sp,
                color: TColors.primary,
              ),
              onTap: () {
                Navigator.pop(context);
                AppModeBottomSheet.show(context);
              },
            ),
            ListTile(
              title: Text("share"),
              leading: Icon(Iconsax.share, size: 30.sp, color: TColors.primary),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(
                Iconsax.logout,
                size: 30.sp,
                color: TColors.primary,
              ),
              onTap: () => showLogoutDialog(),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog() {
    final dark = THelperFunctions.isDarkMode(Get.context!);
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(30),
        icon: Icon(Iconsax.logout, color: TColors.primary),
        alignment: Alignment.center,
        //insetPadding: EdgeInsets.all(30),
        backgroundColor: dark ? TColors.black : TColors.white,
        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        content: const Text(
          "Do you really want to log out?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // close the dialog.
            child: Text(
              "No",
              style: TextStyle(color: dark ? TColors.grey : TColors.darkGrey),
            ),
          ),
          TextButton(
            onPressed: () async {
             // Get.back();
              try {
                // check internet connection
                final isConnected = await NetworkManager.instance.isConnected();
                if (!isConnected) {
                  Loaders.errorSnackBar(
                    title: 'No Internet Connection',
                    message:
                        'Please check your connection and try again later.',
                  );
                  return;
                }
                THelperFunctions.openLoadDialog(
                  'Logging you out...',
                  TImages.loaderAsset,
                );
                AuthenticationRepository.instance.logout();
                THelperFunctions.stopLoading();
              } catch (e) {
                THelperFunctions.stopLoading();
                Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
              }
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: TColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
