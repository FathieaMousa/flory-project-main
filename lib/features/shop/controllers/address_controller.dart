import 'package:flory/data/repositories/address/address_repository.dart';
import 'package:flory/utils/constants/image_strings.dart';
import 'package:flory/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/loader/loaders.dart';
import '../../../utils/network/network_manager.dart';
import '../../../widgets/select_address_bottomSheet.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final selectedCountry = "".obs;
  final state = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editAddressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      final addresses = await getAllUserAddresses();

      for (var addr in addresses) {
        if (addr.id != newSelectedAddress.id && addr.selectedAddress) {
          addr.selectedAddress = false;
          await addressRepository.updateSelectedField(addr.id, false);
        }
      }

      //Assign selected Address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      // set the selected field to true for the newly selected Address
      await addressRepository.updateSelectedField(
        selectedAddress.value.id,
        true,
      );
      // Refresh UI
      refreshData.toggle();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  /// Add new address
  Future addNewAddresses() async {
    try {
      //start loading
      THelperFunctions.openLoadDialog(
        'Storing Address.....',
        TImages.loaderAsset,
      );

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        THelperFunctions.stopLoading();
        return;
      }
      //Form Validations
      if (!addressFormKey.currentState!.validate()) {
        THelperFunctions.stopLoading();
        return;
      }

      //save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: selectedCountry.value,
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      ///update Selected Address Status
      address.id = id;
      await selectAddress(address);

      //Remove loader
      THelperFunctions.stopLoading();

      // success message
      Loaders.successSnackBar(
        title: 'Congratulation',
        message: 'Your Address has been saved successfully.',
      );

      //Refresh Addresses Data
      refreshData.toggle();

      //Reset fields
      resetFormData();
      //Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      THelperFunctions.stopLoading();
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  // load the data in the field for edit screen
  void loadAddressData(AddressModel address) {
    name.text = address.name;
    phoneNumber.text = address.phoneNumber;
    street.text = address.street;
    postalCode.text = address.postalCode;
    city.text = address.city;
    state.text = address.state;
    selectedCountry.value = address.country;
  }

  // update the address
  Future<void> updateUserAddress() async {
    try {
      if (!editAddressFormKey.currentState!.validate()) {
        return;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Loaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your connection and try again.',
        );
        return;
      }

      THelperFunctions.openLoadDialog(
        'Updating Address.....',
        TImages.loaderAsset,
      );
      final updatedAddress = AddressModel(
        id: selectedAddress.value.id,
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: selectedCountry.value,
        selectedAddress: selectedAddress.value.selectedAddress,
        dateTime: DateTime.now(),
      );

      await addressRepository.updateAddressFields(updatedAddress);

      if (updatedAddress.selectedAddress) {
        selectedAddress.value = updatedAddress;
      }

      THelperFunctions.stopLoading();

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Your address has been updated successfully.',
      );

      refreshData.toggle();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      THelperFunctions.stopLoading();
      Loaders.errorSnackBar(title: 'Update Failed', message: e.toString());
    }
  }

  /// Delete user address
  Future<void> deleteUserAddress(String addressId) async {
    try {
      THelperFunctions.openLoadDialog(
        'Deleting Address.....',
        TImages.loaderAsset,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        THelperFunctions.stopLoading();
        Loaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your connection and try again.',
        );
        return;
      }

      await addressRepository.deleteAddress(addressId);

      if (selectedAddress.value.id == addressId) {
        selectedAddress.value = AddressModel.empty();
      }

      THelperFunctions.stopLoading();

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Address has been deleted successfully.',
      );

      refreshData.toggle();
    } catch (e) {
      THelperFunctions.stopLoading();
      Loaders.errorSnackBar(title: 'Delete Failed', message: e.toString());
    }
  }

  /// Delete current selected address
  Future<void> deleteSelectedAddress() async {
    if (selectedAddress.value.id.isNotEmpty) {
      await deleteUserAddress(selectedAddress.value.id);
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SelectAddressBottomSheet(),
    );
  }

  ///Functions to reset form field
  void resetFormData() {
    name.clear();
    phoneNumber.clear();
    postalCode.clear();
    city.clear();
    street.clear();
    selectedCountry.value = "";
    state.clear();
  }
}
