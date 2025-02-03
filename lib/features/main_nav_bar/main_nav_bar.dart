import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:it_roots_task/features/map/map_screen.dart';
import 'package:it_roots_task/features/posts/presentation_layer/posts_screen.dart';
import 'package:it_roots_task/features/static_data/static_data_screen.dart';

import 'package:it_roots_task/features/map/cubit/map_cubit.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const StaticDataScreen(),
    const MapScreen(),
    const PostsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            final cubit = MapCubit.get(context);
            cubit.onInitMap();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.view_module),
            label: "data".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: 'map'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: 'posts'.tr(),
          ),
        ],
      ),
    );
  }
}
