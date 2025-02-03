import 'package:flutter/material.dart';
import 'package:it_roots_task/utils/app_styles.dart';

class LanguageToggleButton extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onPressed;

  const LanguageToggleButton({
    super.key,
    required this.isEnglish,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isEnglish ? 'EN' : 'عربي',
                style:
                    AppStyles.mediumTitleStyle.copyWith(color: Colors.white)),
            const SizedBox(width: 8.0),
            const Icon(Icons.language, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
