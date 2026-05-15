import 'package:flory/utils/constants/colors.dart';
import 'package:flory/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:flory/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:flory/utils/theme/custom_themes/chip_theme.dart';
import 'package:flory/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';


class TAppTheme{
  TAppTheme._();

  static ThemeData LightTheme = ThemeData(
    useMaterial3: true,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,    //fontFamily: 'LibreBaskerville',
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: TColors.primaryBackground,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    // inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,


  );
  static ThemeData DarkTheme = ThemeData(
    focusColor: Colors.transparent,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: TColors.blackF,
      scrolledUnderElevation: 0,
    ),
    brightness: Brightness.dark,
    primaryColor: TColors.primaryBackground,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,



  );
}