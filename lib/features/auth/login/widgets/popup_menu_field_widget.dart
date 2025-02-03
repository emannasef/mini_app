import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/widgets/text_form_field_widget.dart';
import 'package:it_roots_task/utils/app_colors.dart';

class PopupMenuFieldWidget<T> extends StatelessWidget {
  const PopupMenuFieldWidget({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    required this.itemToString,
    required this.label,
    required this.hint,
    this.subLabel,
    this.controller,
    this.focusNode,
    this.validator,
    this.readOnly,
    this.enabled,
  });

  final List<T> items;
  final T? selectedItem;
  final Function(T)? onSelected;
  final String Function(T) itemToString;
  final String label, hint;
  final String? subLabel;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.transparent, width: 1.5),
      ),
      initialValue: selectedItem,
      itemBuilder: (_) => List.generate(
        items.length,
        (index) {
          return PopupMenuItem(
            value: items[index],
            child: Text(itemToString(items[index])),
          );
        },
      ),
      onSelected: onSelected,
      child: TextFormFieldWidget(
        label: label,
        hint: hint,
        subLabel: subLabel,
        controller: controller,
        readOnly: readOnly ?? false,
        enabled: enabled ?? true,
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 24.sp,
            color: AppColors.gray200Color,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
