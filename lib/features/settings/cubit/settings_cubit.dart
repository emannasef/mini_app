import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/utils/app_routes.dart';
import '../../../core/constants/cache_constants.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/easy_localization_helper.dart';
import '../../../it_roots_app.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);
  bool isEnglish = EasyLocalizationHelper.currentLanguage(
          ItRootsApp.navigatorKey.currentContext!) ==
      'en';

  void onToggleLanguage(BuildContext context) async {
    isEnglish = !isEnglish;

    Locale newLocale = isEnglish ? const Locale('en') : const Locale('ar');

    await EasyLocalizationHelper.changeLanguage(context, locale: newLocale);
    await CacheHelper.setStringData(
        key: CacheConstants.language, value: newLocale.languageCode);

    emit(SettingsChangedValueState());
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.navBar, (route) => false);
  }

  void onLogout(BuildContext context) {
    CacheHelper.clearData();
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.splash, (route) => false);
  }
}
