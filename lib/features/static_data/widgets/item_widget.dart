import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/utils/app_colors.dart';
import 'package:it_roots_task/utils/app_styles.dart';

class ItemWidget extends StatelessWidget {
  final int index;
  final bool isVertical;

  const ItemWidget({super.key, required this.index, required this.isVertical});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? double.infinity : 120.w,
      margin: isVertical
          ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
          : const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isVertical ? Colors.teal : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          isVertical ? 'Vertical Item $index' : 'Item $index',
          style: AppStyles.mediumTitleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
