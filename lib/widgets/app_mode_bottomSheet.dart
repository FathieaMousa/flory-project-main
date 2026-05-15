import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/theme/theme_manager.dart';

class AppModeBottomSheet extends StatefulWidget {
  const AppModeBottomSheet({super.key});

  @override
  _AppModeBottomSheetState createState() => _AppModeBottomSheetState();

  static void show(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    showModalBottomSheet(
      barrierColor: dark ? TColors.dark.withOpacity(0.7) : TColors.primaryBackground.withOpacity(0.7),
      backgroundColor: TColors.primary,
      context: context,
      isScrollControlled: true,
      builder: (context) => AppModeBottomSheet(),
    );
  }
}

class _AppModeBottomSheetState extends State<AppModeBottomSheet> {
  late String _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = ThemeManager.getCurrentMode();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeManager.isDarkMode(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Text(
            'Choose App Mode',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: dark ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(height: 20.h),

          _buildOption('light', 'Light Mode', Icons.light_mode, dark),
          _buildOption('dark', 'Dark Mode', Icons.dark_mode, dark),
          _buildOption('system', 'System Mode', Icons.settings, dark),
          SizedBox(height: 20.h),

          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                ThemeManager.setThemeMode(_selectedMode);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: dark ? TColors.dark : TColors.primaryBackground,
                foregroundColor:dark ? TColors.white : TColors.primary ,
                elevation: 5,
                shadowColor: TColors.primaryBackground,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, letterSpacing: 1),
              ),
            ),
          ),
          SizedBox(height: 10.h,)
        ],
      ),
    );
  }

  Widget _buildOption(String mode, String title, IconData icon, bool isDark) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: isDark ? Colors.black : Colors.white),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
      trailing: Radio<String>(
        activeColor: TColors.primaryBackground,
        value: mode,
        groupValue: _selectedMode,
        onChanged: (String? value) {
          setState(() {
            _selectedMode = value!;
          });
        },
      ),
      onTap: () {
        setState(() {
          _selectedMode = mode;
        });
      },
    );
  }
}