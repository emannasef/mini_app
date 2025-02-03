import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/utils/app_spaces.dart';
import '../../utils/app_styles.dart';
import '../../widgets/language_toggle_button.dart';
import 'cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = SettingsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "settings".tr(),
              style: AppStyles.mediumTitleStyle,
            ),
          ),
          body: Column(
            children: [
              AppSpaces.verticalSpace4,
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  trailing: LanguageToggleButton(
                    isEnglish: cubit.isEnglish,
                    onPressed: () => cubit.onToggleLanguage(context),
                  ),
                  title: Text(
                    "language".tr(),
                    style: AppStyles.normalTitleStyle,
                  ),
                ),
              ),
              AppSpaces.verticalSpace4,
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () => cubit.onLogout(context),
                  trailing: const Icon(Icons.logout),
                  title: Text(
                    "logout".tr(),
                    style: AppStyles.normalTitleStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

