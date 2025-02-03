import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:it_roots_task/features/static_data/widgets/item_widget.dart';
import 'package:it_roots_task/utils/app_spaces.dart';

class StaticDataScreen extends StatelessWidget {
  const StaticDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSpaces.sliverSpace(AppSpaces.verticalSpace7),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ItemWidget(
                    index: index,
                    isVertical: false,
                  );
                },
              ),
            ),
          ),
          AppSpaces.sliverSpace(AppSpaces.verticalSpace3),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ItemWidget(
                  index: index,
                  isVertical: true,
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
