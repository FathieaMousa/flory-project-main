import 'package:flory/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextTheme{
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(

      headlineLarge:  const TextStyle().copyWith(fontSize: 64,fontWeight: FontWeight.w400, color: TColors.black,fontFamily:'LibreBaskerville'),
      headlineMedium: const TextStyle().copyWith(color: TColors.primary,fontSize: 24,fontWeight: FontWeight.w400,fontFamily:'LibreBaskerville',),
      headlineSmall: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.normal,color: TColors.black ,fontFamily:'LibreBaskerville'),

      titleLarge: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: TColors.primary,letterSpacing: 2,fontFamily: 'ScheherazadeNew'),
      titleMedium: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),
      titleSmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),

      bodyLarge: const TextStyle().copyWith(fontSize: 15,fontWeight: FontWeight.w400,color:TColors.primary),
      bodyMedium: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black ),
      bodySmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.5)),

      labelLarge: const TextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black),
      labelMedium:  const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black.withOpacity(0.5)),
      labelSmall:  const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black)

  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 64,fontWeight: FontWeight.w400, color: TColors.white,fontFamily:'LibreBaskerville'),
    headlineMedium: const TextStyle().copyWith(color: TColors.primary,fontSize: 24,fontWeight: FontWeight.w600,fontFamily:'LibreBaskerville',),
    headlineSmall: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.normal,color: TColors.light ,fontFamily:'LibreBaskerville'),

    titleLarge: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: TColors.primary,letterSpacing: 2,fontFamily: 'ScheherazadeNew'),
    titleMedium: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 15,fontWeight: FontWeight.w400,color:TColors.primary),
    bodyMedium: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white ),
    bodySmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),
    labelMedium:  const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white.withOpacity(0.5)),

  );

}