import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'home_item.dart';


class HomeSectionItem extends StatelessWidget {
  final String title;
  final List<HomeItem> items;
  final int gridCount;

  const HomeSectionItem({
    Key? key,
    required this.title,
    required this.items,
    required this.gridCount
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600
            ),
          ),
        ),

        StaggeredGrid.count(
          crossAxisCount: gridCount,
          crossAxisSpacing: 10,
          children: items,
        )
      ],
    );
  }
}