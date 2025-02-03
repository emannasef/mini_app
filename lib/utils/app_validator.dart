import 'package:easy_localization/easy_localization.dart';
import 'package:it_roots_task/core/extensions/validator_extension.dart';

abstract class AppValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterEmail'.tr();
    } else if (!value.isValidEmail) {
      return 'emailInvalid'.tr();
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "passwordInvalid".tr();
    } else if (value.length < 8 || value.length > 20) {
      return 'passwordLength'.tr();
    } else if (!value.isValidPassword) {
      return 'passwordInvalid'.tr();
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'nameInvalid'.tr();
    } else if (value.length < 3) {
      return 'nameInvalid'.tr();
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterPhone'.tr();
    } else if (!value.isValidPhone) {
      return 'phoneInvalid'.tr();
    }
    return null;
  }

  static String? emptyValidator(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'empty'.tr();
    }
    return null;
  }
}
