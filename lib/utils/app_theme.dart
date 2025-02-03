import 'package:flutter/material.dart';
import 'package:it_roots_task/utils/app_assets.dart';
import 'package:it_roots_task/utils/app_colors.dart';
import 'package:it_roots_task/utils/app_styles.dart';

abstract class AppTheme {
  static final ThemeData appTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: AppAssets.cairoFont,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: AppColors.blackColor,
      ),
      elevation: 0,
    ),
  );
}
