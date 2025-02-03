import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/core/constants/cache_constants.dart';
import 'package:it_roots_task/core/helpers/cache_helper.dart';
import 'package:it_roots_task/core/helpers/easy_localization_helper.dart';
import 'package:it_roots_task/it_roots_app.dart';
import 'package:it_roots_task/features/auth/login/model/drop_down_model.dart';
import 'package:it_roots_task/utils/app_routes.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode userTypeFocusNode = FocusNode();

  List<DropDownModel> get userTypes {
    return [
      DropDownModel(label: "admin".tr(), value: 0),
      DropDownModel(label: "user".tr(), value: 1),
    ];
  }

  bool isEnglish = EasyLocalizationHelper.currentLanguage(
          ItRootsApp.navigatorKey.currentContext!) ==
      'en';

  DropDownModel? selectedUserType;

  void onSelectedUserType(DropDownModel? value) {
    _selectUserType(value);
    emit(LoginChangedValueState());
  }

  void onToggleLanguage(BuildContext context) async {
    if (isEnglish) {
      await EasyLocalizationHelper.changeLanguage(
        context,
        locale: const Locale('ar'),
      );
      await CacheHelper.setStringData(
          key: CacheConstants.language, value: 'ar');
      isEnglish = false;
    } else {
      await EasyLocalizationHelper.changeLanguage(
        context,
        locale: const Locale('en'),
      );
      await CacheHelper.setStringData(
          key: CacheConstants.language, value: 'en');
      isEnglish = true;
    }
    emit(LoginChangedValueState());
  }

  void onLogin(BuildContext context) async {
    _unFocus();
    if (formKey.currentState!.validate()) {
      await CacheHelper.setBoolData(key: CacheConstants.logged, value: true);

      Navigator.pushNamed(context, AppRoutes.navBar);
    }
  }

  void _selectUserType(DropDownModel? value) {
    selectedUserType = value;
    if (selectedUserType != null) {
      userTypeController.text = selectedUserType!.label;
    } else {
      userTypeController.text = '';
    }
  }

  void _unFocus() {
    userNameFocusNode.unfocus();
    passwordFocusNode.unfocus();
    userTypeFocusNode.unfocus();
  }

  @override
  Future<void> close() {
    userNameController.dispose();
    passwordController.dispose();
    userTypeController.dispose();
    return super.close();
  }
}
