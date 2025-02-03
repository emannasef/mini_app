import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/utils/app_assets.dart';
import 'package:it_roots_task/utils/app_colors.dart';

abstract class AppStyles {

  static final TextStyle largeTitleStyle = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: AppColors.gray800Color,
      overflow: TextOverflow.ellipsis,
      fontFamily: AppAssets.cairoFont);

  static final TextStyle mediumTitleStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: AppColors.gray800Color,
      overflow: TextOverflow.ellipsis,
      fontFamily: AppAssets.cairoFont);

  static final TextStyle normalTitleStyle = TextStyle(
      fontSize: 14.sp,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: AppColors.gray600Color,
      overflow: TextOverflow.ellipsis,
      fontFamily: AppAssets.cairoFont);

  static final TextStyle buttonStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.whiteColor,
    overflow: TextOverflow.ellipsis,
  );
}
