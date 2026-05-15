
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show rootBundle, PlatformException;
import 'package:get/get.dart';
import 'dart:typed_data';

class TFirebaseStorageService extends GetxController{
  static TFirebaseStorageService get instance =>Get.find();

final _firebaseStorage = FirebaseStorage.instance;

// Function to convert the photo to Unit8List
Future<Uint8List> getImageDataFromAssets(String path) async{
  try{
    final byteData = await rootBundle.load(path);
    final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes);
    return imageData;
  }catch(e){
        throw 'Error loading image data : $e';
  }
}

// Function to upload the photo to the firestore
Future<String> uploadImageData(String path , Uint8List image , String name) async{
  try{
     final ref = _firebaseStorage.ref(path).child(name);
     await ref.putData(image);
     final url = await ref.getDownloadURL();
     return url;
  }catch(e){
     if(e is FirebaseException){
         throw 'Firebase Exception ${e.message}';
     }else if(e is SocketException){
         throw 'Network Error ${e.message}';
     }else if (e is PlatformException){
         throw 'Platform Exception ${e.message}';
  }else{
       throw 'Something wrong';
     }
  }
}
}