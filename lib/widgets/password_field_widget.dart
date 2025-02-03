import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/widgets/text_form_field_widget.dart';
import 'package:it_roots_task/utils/app_validator.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? label, hint;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      label: widget.label ?? 'password'.tr(),
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.visiblePassword,
      hint: widget.hint,
      onChanged: widget.onChanged,
      isPassword: showPassword,
      suffixIcon: IconButton(
        icon: Icon(
          showPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: 22.sp,
        ),
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
      ),
      validator:
          widget.validator ?? (value) => AppValidators.passwordValidator(value),
    );
  }
}
