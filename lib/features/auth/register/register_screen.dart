import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/features/auth/register/cubit/register_cubit.dart';
import 'package:it_roots_task/widgets/button_widget.dart';
import 'package:it_roots_task/widgets/password_field_widget.dart';
import 'package:it_roots_task/widgets/text_form_field_widget.dart';
import 'package:it_roots_task/utils/app_assets.dart';
import 'package:it_roots_task/utils/app_spaces.dart';
import 'package:it_roots_task/utils/app_styles.dart';
import 'package:it_roots_task/utils/app_validator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = RegisterCubit.get(context);
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
                      "register".tr(),
                      style: AppStyles.largeTitleStyle,
                    ),
                    AppSpaces.verticalSpace6,
                    TextFormFieldWidget(
                      label: "firstName".tr(),
                      controller: cubit.firstNameController,
                      focusNode: cubit.firstNameFocusNode,
                      validator: (value) => AppValidators.nameValidator(value),
                    ),
                    AppSpaces.verticalSpace3,
                    TextFormFieldWidget(
                      label: "lastName".tr(),
                      controller: cubit.lastNameController,
                      focusNode: cubit.lastNameFocusNode,
                      validator: (value) => AppValidators.nameValidator(value),
                    ),
                    AppSpaces.verticalSpace3,
                    TextFormFieldWidget(
                      label: "email".tr(),
                      controller: cubit.emailController,
                      focusNode: cubit.emailFocusNode,
                      validator: (value) => AppValidators.emailValidator(value),
                    ),
                    AppSpaces.verticalSpace3,
                    PasswordFieldWidget(
                      controller: cubit.passwordController,
                      focusNode: cubit.passwordFocusNode,
                    ),
                    AppSpaces.verticalSpace3,
                    TextFormFieldWidget(
                      keyboardType: TextInputType.phone,
                      label: "phone".tr(),
                      controller: cubit.phoneController,
                      focusNode: cubit.phoneFocusNode,
                      validator: (value) => AppValidators.phoneValidator(value),
                    ),
                    AppSpaces.verticalSpace3,
                    ButtonWidget(
                      minimumSize: Size(double.infinity, 50.h),
                      borderRadius: 12,
                      onPressed: () => cubit.onRegister(context),
                      title: "createAccount".tr(),
                    ),
                    AppSpaces.verticalSpace3,
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
