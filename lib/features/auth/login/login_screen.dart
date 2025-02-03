import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/features/auth/login/cubit/login_cubit.dart';
import 'package:it_roots_task/widgets/button_widget.dart';
import 'package:it_roots_task/widgets/language_toggle_button.dart';
import 'package:it_roots_task/widgets/password_field_widget.dart';
import 'package:it_roots_task/features/auth/login/widgets/popup_menu_field_widget.dart';
import 'package:it_roots_task/widgets/text_form_field_widget.dart';
import 'package:it_roots_task/utils/app_assets.dart';
import 'package:it_roots_task/utils/app_colors.dart';
import 'package:it_roots_task/utils/app_routes.dart';
import 'package:it_roots_task/utils/app_spaces.dart';
import 'package:it_roots_task/utils/app_styles.dart';
import 'package:it_roots_task/utils/app_validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(AppAssets.itRootsLogo),
            automaticallyImplyLeading: false,
          ),
          body: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: AppSpaces.horizontalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpaces.verticalSpace4,
                    Text(
                      'login'.tr(),
                      style: AppStyles.largeTitleStyle,
                    ),
                    Text(
                      'loginDescription'.tr(),
                      style: AppStyles.normalTitleStyle.copyWith(height: 1.8),
                    ),
                    AppSpaces.verticalSpace6,
                    TextFormFieldWidget(
                      label: "userName".tr(),
                      controller: cubit.userNameController,
                      focusNode: cubit.userNameFocusNode,
                      validator: (value) => AppValidators.nameValidator(value),
                    ),
                    AppSpaces.verticalSpace3,
                    PasswordFieldWidget(
                      controller: cubit.passwordController,
                      focusNode: cubit.passwordFocusNode,
                    ),
                    AppSpaces.verticalSpace3,
                    PopupMenuFieldWidget(
                      controller: cubit.userTypeController,
                      items: cubit.userTypes,
                      selectedItem: cubit.selectedUserType,
                      onSelected: cubit.onSelectedUserType,
                      itemToString: (value) => value.label,
                      label: 'userType'.tr(),
                      hint: "user".tr(),
                      readOnly: true,
                      enabled: false,
                      validator: (value) => AppValidators.emptyValidator(value),
                    ),
                    AppSpaces.verticalSpace3,
                    ButtonWidget(
                      minimumSize: Size(double.infinity, 50.h),
                      borderRadius: 12,
                      onPressed: () => cubit.onLogin(context),
                      title: "login".tr(),
                    ),
                    AppSpaces.verticalSpace3,
                    ButtonWidget(
                      fontColor: AppColors.primaryColor,
                      backgroundColor: Colors.white,
                      borderColor: AppColors.primaryColor,
                      minimumSize: Size(double.infinity, 50.h),
                      borderRadius: 12,
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      title: "createAccount".tr(),
                    ),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
