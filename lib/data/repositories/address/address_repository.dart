import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flory/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/address_model.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance =>Get.find();

  final _db = FirebaseFirestore.instance ;

  // function to fetch user addresses
  Future<List<AddressModel>>fetchUserAddresses ()async{
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty)throw "Unable to find user information . Try again in few minutes" ;

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot)=>AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();

    }catch(e){
      throw "Something went wrong while fetching Address Information. Try again later" ;
    }

  }

  ///store new user address
  Future<String> addAddress(AddressModel address)async{
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id ;
    }catch(e){
      throw "Something went wrong while fetching Address Information. Try again later" ;
    }
  }

  ///clear the selected field for all address
  Future<void> updateSelectedField(String addressId , bool selected)async{
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress':selected});

    }catch(e){
      throw "Unable to update your address selection. Try again later" ;
    }
  }

  /// Update address fields
  Future<void> updateAddressFields(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw "Unable to find user information. Try again in few minutes";

      await _db.collection('Users').doc(userId).collection('Addresses')
          .doc(address.id)
          .update(address.toJson());

    } catch (e) {
      throw "Unable to update your address. Try again later";
    }
  }

  // Delete user address
  Future<void> deleteAddress(String addressId) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw "Unable to find user information. Try again in few minutes";

      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).delete();

    } catch (e) {
      throw "Something went wrong while deleting address. Try again later";
    }
  }


}

