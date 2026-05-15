import 'package:flory/main.dart';
import 'package:flory/utils/theme/theme.dart';
import 'package:flory/utils/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flory/utils/constants/colors.dart';
import 'bindings/general_bindings.dart';


class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeNotifier,
      builder: (context, themeMode, child) {
        print('الوضع الحالي: $themeMode');
        return ScreenUtilInit(
          designSize: Size(412, 917),
          minTextAdapt: true,
          splitScreenMode: true,
          child: GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: TAppTheme.LightTheme,
            darkTheme: TAppTheme.DarkTheme,
            themeMode: themeMode,
            initialBinding: GeneralBindings(),
            home: const Scaffold(
              backgroundColor: TColors.primary,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}