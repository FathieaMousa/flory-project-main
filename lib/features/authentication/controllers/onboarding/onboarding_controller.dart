import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../screens/onBoarding/welcomScreen.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current Index when page scroll
  void updatePageIndicator(index)=> currentPageIndex.value = index;

  // Jump to the specific dot selected
  void dotClick(index){
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Update index and go to the next page
  void nextPage(){
    if(currentPageIndex.value ==2){
      final storage = GetStorage();
      if(kDebugMode){
        print('------------- Get Storage Next Button -----------------');
        print(storage.read('IsFirstTime'));
      }

      storage.write('IsFirstTime', false);
      if(kDebugMode){
        print('------------- Get Storage Next Button -----------------');
        print(storage.read('IsFirstTime'));
      }

      Get.offAll(const Welcomescreen());
    } else{
      int page = currentPageIndex.value +1;
      pageController.jumpToPage(page);
    }
  }

  // update current index and go to the last page
  void skipPage(){

    final storage = GetStorage();
    if(kDebugMode){
      print('------------- Get Storage Next Button -----------------');
      print(storage.read('IsFirstTime'));
    }

    storage.write('IsFirstTime', false);
    if(kDebugMode){
      print('------------- Get Storage Next Button -----------------');
      print(storage.read('IsFirstTime'));
    }

    Get.offAll(const Welcomescreen());
  }


}