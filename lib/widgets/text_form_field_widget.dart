import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/utils/app_assets.dart';
import 'package:it_roots_task/utils/app_colors.dart';
import 'package:it_roots_task/utils/app_spaces.dart';
import 'package:it_roots_task/utils/app_styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.label,
    this.subLabel,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.fillColor,
    this.borderColor,
    this.maxLines = 1,
    this.enableSuffixPadding = true,
    this.labelSpace,
    this.icon,
    this.hint,
  });

  final String label;
  final String? subLabel, hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool readOnly, enabled;
  final Color? fillColor, borderColor;
  final int maxLines;
  final bool enableSuffixPadding;
  final double? labelSpace;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          inputFormatters: inputFormatters,
          cursorColor: AppColors.primaryColor,
          obscureText: isPassword,
          style: AppStyles.normalTitleStyle.copyWith(
            color: AppColors.gray600Color,
            fontSize: 14.sp,
          ),
          keyboardType: keyboardType,
          onTap: onTap,
          onChanged: onChanged,
          readOnly: readOnly,
          enabled: enabled,
          decoration: InputDecoration(
            icon: icon,
            filled: true,
            fillColor: fillColor ?? AppColors.whiteColor,
            labelText: label,
            labelStyle: AppStyles.normalTitleStyle.copyWith(
                color: fillColor != null ? AppColors.gray400Color : null),
            hintText: hint,
            hintStyle: AppStyles.normalTitleStyle.copyWith(
                color: fillColor != null ? AppColors.gray500Color : null),
            errorStyle: AppStyles.normalTitleStyle.copyWith(
              color: AppColors.errorColor,
              fontFamily: AppAssets.cairoFont,
              fontSize: 12.sp,
            ),
            errorMaxLines: 2,
            prefixIcon: prefixIcon,
            suffixIcon: Padding(
              padding: enableSuffixPadding
                  ? EdgeInsetsDirectional.only(end: 5.w)
                  : EdgeInsets.zero,
              child: suffixIcon,
            ),
            suffixIconConstraints: const BoxConstraints(),
            prefixIconConstraints: const BoxConstraints(),
            border: _border(context, borderColor: borderColor),
            enabledBorder: _border(context, borderColor: borderColor),
            focusedBorder: _focusedBorder(context, borderColor: borderColor),
            errorBorder: _errorBorder(context, borderColor: borderColor),
            focusedErrorBorder: _border(context, borderColor: borderColor),
            disabledBorder: _border(context, borderColor: borderColor),
          ),
        ),
        if (subLabel != null) AppSpaces.verticalSpace3,
        if (subLabel != null)
          Text(
            subLabel!,
            style: AppStyles.normalTitleStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  OutlineInputBorder _border(context, {required Color? borderColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? AppColors.gray200Color),
      );

  OutlineInputBorder _focusedBorder(context, {required Color? borderColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? AppColors.primaryColor),
      );

  OutlineInputBorder _errorBorder(context, {required Color? borderColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? AppColors.errorColor),
      );
}
