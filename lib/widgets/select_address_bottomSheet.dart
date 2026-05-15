import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../features/shop/controllers/address_controller.dart';
import '../screens/navigation_items/profile_items/edit_address.dart';
import '../screens/navigation_items/profile_items/newdeliveryaddress.dart';

class SelectAddressBottomSheet extends StatelessWidget {
   SelectAddressBottomSheet({super.key});
         final addressController = AddressController.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.lg),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Address",
            style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: FutureBuilder(
                future: addressController.getAllUserAddresses(),
                builder: (_, snapshot) {
                  final response =
                  TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if (response != null) return response;

                  final addresses = snapshot.data!;
                  if (addresses.isEmpty) {
                    return Center(child: Text("No addresses found"));
                  }
                  return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (_, index) {
                      final dark = THelperFunctions.isDarkMode(context);
                      final address = addresses[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: GestureDetector(
                          onTap: () async {
                            await addressController.selectAddress(address);
                            Get.back();
                          },
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
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  color: TColors.primary,
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'Delete Address',
                                      titleStyle: TextStyle(
                                          fontSize: 20, color: TColors.primary),
                                      titlePadding:
                                      EdgeInsets.fromLTRB(30, 30, 30, 0),
                                      contentPadding: EdgeInsets.all(20),
                                      backgroundColor: dark
                                          ? TColors.black
                                          : TColors.primaryBackground,
                                      buttonColor: TColors.primary,
                                      middleText:
                                      'Are you sure you want to delete this address?',
                                      middleTextStyle: TextStyle(fontSize: 16.sp),
                                      textConfirm: 'Yes',
                                      textCancel: 'No',
                                      cancelTextColor: dark
                                          ? TColors.primaryBackground
                                          : TColors.primary,
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Get.back();
                                        AddressController.instance
                                            .deleteUserAddress(address.id);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const Newdeliveryaddress()),
              child: const Text("Add new Address"),
            ),
          ),
        ],
      ),
    );
  }
}