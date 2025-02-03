import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/utils/app_assets.dart';
import 'package:it_roots_task/utils/app_colors.dart';

import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Center(
              child: Image.asset(
            AppAssets.itRootsLogo,
          ));
        },
      ),
    );
  }
}
