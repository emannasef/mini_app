import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/core/constants/cache_constants.dart';
import 'package:it_roots_task/core/helpers/cache_helper.dart';
import 'package:it_roots_task/it_roots_app.dart';
import 'package:it_roots_task/utils/app_routes.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of(context);

  void onInitializeSplash() async => await Future.wait([_handleSplashRoute()]);

  Future<void> _handleSplashRoute() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (CacheHelper.getBoolData(key: CacheConstants.logged) != null) {
        Navigator.pushReplacementNamed(
            ItRootsApp.navigatorKey.currentContext!, AppRoutes.navBar);
      } else {
        Navigator.pushReplacementNamed(
            ItRootsApp.navigatorKey.currentContext!, AppRoutes.login);
      }
      emit(SplashCompleted());
    });
  }
}
