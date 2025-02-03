import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/core/constants/cache_constants.dart';
import 'package:it_roots_task/core/helpers/cache_helper.dart';
import 'package:it_roots_task/utils/app_routes.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  void onRegister(BuildContext context) async {
    _unFocus();
    if (formKey.currentState!.validate()) {
      await CacheHelper.setBoolData(key: CacheConstants.logged, value: true);
      Navigator.pushNamed(context, AppRoutes.navBar);
    }
  }

  void _unFocus() {
    firstNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    phoneFocusNode.unfocus();
  }

  @override
  Future<void> close() {
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
