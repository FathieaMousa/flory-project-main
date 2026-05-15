import 'package:flory/screens/navigation_items/profile_items/edit_address.dart';
import 'package:flory/screens/navigation_items/profile_items/newdeliveryaddress.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/shop/controllers/address_controller.dart';
import '../../../features/shop/models/address_model.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/appbar_theme.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class Shippingaddress extends StatefulWidget {
  const Shippingaddress({super.key});

  @override
  State<Shippingaddress> createState() => _ShippingaddressState();
}

class _ShippingaddressState extends State<Shippingaddress> {
  final controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
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
              actions: [
                SizedBox(width: 150.w),
                CircleAvatar(
                  backgroundColor: TColors.primary40,
                  radius: 40.r,
                  child: Icon(
                    Iconsax.location,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 30.w),
              ],
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
              actions: [
                SizedBox(width: 150.w),
                CircleAvatar(
                  backgroundColor: TColors.primary40,
                  radius: 40.r,
                  child: Icon(
                    Iconsax.location,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(

              children: [
                Center(child: Text("Shipping Address",style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                  fontFamily: 'LibreBaskerville',
                  fontSize: 24,
                  color: dark ? TColors.light : TColors.black,
                ),
                ),  ),
                SizedBox(height: 15,),
                Obx(
                  () => FutureBuilder<List<AddressModel>>(
                    key: ValueKey(controller.refreshData.value), // 🔑 التحديث
                    future: controller.getAllUserAddresses(),
                    builder: (context, snapshot) {
                      final state =
                          TCloudHelperFunctions.checkMultiRecordState<AddressModel>(
                            snapshot: snapshot,
                            nothingFound: _buildNewAddressOption(controller),
                            loader: const Center(child: CircularProgressIndicator()),
                            error: const Center(child: Text("Something went wrong")),
                          );

                      if (state != null) return state;

                      final addresses = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We’ll ship it to your address below:",
                            style: TextStyle(
                              fontSize: 20.sp,
                                fontFamily: "ScheherazadeNew",color:TColors.primary
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // 🟢 قائمة العناوين
                          Container(
                            height:  addresses.length * 120.h,
                            child: ListView.builder(
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                final address = addresses[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: GestureDetector(
                                    onTap: () => controller.selectAddress(address),
                                    child: Container(
                                      padding: EdgeInsets.all(16.r),
                                      decoration: BoxDecoration(
                                        color: address.selectedAddress
                                            ? TColors.primaryBackground
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20.r),
                                        boxShadow: address.selectedAddress
                                            ? [
                                                BoxShadow(
                                                  color: TColors.primary,
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Iconsax.house,
                                            color: TColors.primary,
                                            size: 28.sp,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  address.name,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${address.street}, ${address.city}, ${address.state}, ${address.country}, ${address.postalCode}",
                                                  style: TextStyle(fontSize: 14.sp),
                                                ),
                                                Text(
                                                  address.phoneNumber,
                                                  style: TextStyle(fontSize: 14.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Iconsax.edit_2),
                                            color: TColors.primary,
                                            onPressed: () {
                                              AddressController.instance.loadAddressData(address);
                                              Get.to(() => EditAddress());
                                            },
                                          ),IconButton(
                                            icon: const Icon(Icons.delete_outline),
                                            color: TColors.primary,
                                            onPressed: (){
                                              Get.defaultDialog(
                                                title: 'Delete Address',
                                                titleStyle: TextStyle(
                                                  fontSize: 20 ,
                                                  color: TColors.primary
                                                ),
                                                titlePadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                                contentPadding: EdgeInsets.all(20),
                                                backgroundColor: dark ? TColors.black : TColors.primaryBackground,
                                                buttonColor: TColors.primary,
                                                middleText: 'Are you sure you want to delete this address?',
                                                middleTextStyle: TextStyle(
                                                  fontSize: 16.sp
                                                ),
                                                textConfirm: 'Yes',
                                                textCancel: 'No',
                                                cancelTextColor: dark ?TColors.primaryBackground :TColors.primary ,
                                                confirmTextColor: Colors.white,
                                                onConfirm: () {
                                                  Get.back();
                                                  AddressController.instance.deleteUserAddress(address.id);
                                                },
                                              );                                          },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          _buildNewAddressOption(controller),
                          SizedBox(height: 20.h),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),


    );
  }

  Widget _buildNewAddressOption(AddressController controller) {
    return GestureDetector(
      onTap: () {
        controller.resetFormData();
        Get.to(() => Newdeliveryaddress());},
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          border: Border.all(color: TColors.primary),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(Iconsax.location_add, size: 28.sp, color: TColors.primary),
            SizedBox(width: 12.w),
            Text(
              "Add New Delivery Address",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
