import 'package:flory/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class SearchField {
  SearchField._();

  static Widget searchFiled(BuildContext context)  {
    final dark = THelperFunctions.isDarkMode(context);
    final searchController = Get.put(SearchController());
    return SizedBox(
      width: 342.w,
      height: 40.h,
      child: TextField(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Search()));
      },
        style: TextStyle(fontSize: 22.sp),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                  color: TColors.primary
              )
          ),
          prefixIcon: const Icon(Icons.search_outlined),
          prefixIconColor: Color(0xff1c1c1c),
          contentPadding: EdgeInsets.all(5.r),

          hintText: "Search",
          hintStyle: TextStyle(fontSize: 20.sp, color: Colors.black),
          filled: true,
          fillColor: dark ? TColors.primary40 : TColors.white,
        ),
      ),
    );

  }
}