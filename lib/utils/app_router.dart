import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/features/auth/login/login_screen.dart';
import 'package:it_roots_task/features/auth/register/cubit/register_cubit.dart';
import 'package:it_roots_task/features/auth/register/register_screen.dart';
import 'package:it_roots_task/features/main_nav_bar/main_nav_bar.dart';
import 'package:it_roots_task/features/map/cubit/map_cubit.dart';
import 'package:it_roots_task/features/posts/presentation_layer/cubit/posts_cubit.dart';
import 'package:it_roots_task/features/splash/cubit/splash_cubit.dart';
import 'package:it_roots_task/features/splash/splash_screen.dart';
import 'package:it_roots_task/features/settings/settings_screen.dart';
import 'package:it_roots_task/utils/app_routes.dart';

import '../features/auth/login/cubit/login_cubit.dart';
import '../features/settings/cubit/settings_cubit.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashCubit()..onInitializeSplash(),
            child: const SplashScreen(),
          ),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );

      case AppRoutes.navBar:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MapCubit()),
              BlocProvider(create: (context) => PostsCubit()),
            ],
            child: const MainNavBar(),
          ),
        );


      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SettingsCubit(),
            child: const SettingsScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Unknown Route'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
