import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSpaces {
  static final SizedBox verticalSpace1 = SizedBox(height: 5.h);
  static final SizedBox verticalSpace3 = SizedBox(height: 15.h);
  static final SizedBox verticalSpace4 = SizedBox(height: 20.h);
  static final SizedBox verticalSpace6 = SizedBox(height: 30.h);
  static final SizedBox verticalSpace7 = SizedBox(height: 45.h);

  static const EdgeInsetsGeometry horizontalPadding =
      EdgeInsets.symmetric(horizontal: 16.5);

  static SliverToBoxAdapter sliverSpace(SizedBox size) =>
      SliverToBoxAdapter(child: size);
}
