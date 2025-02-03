import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class EasyLocalizationHelper {
  static Future<void> changeLanguage(BuildContext context,
          {required Locale locale}) async =>
      await EasyLocalization.of(context)?.setLocale(locale);

  static String? currentLanguage(BuildContext context) =>
      EasyLocalization.of(context)?.currentLocale?.languageCode;
}
