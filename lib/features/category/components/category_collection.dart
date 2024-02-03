import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryCollection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final EdgeInsets? margins;
  final bool expandContent;

  const CategoryCollection({
    Key? key,
    required this.title,
    required this.items,
    required this.expandContent,
    this.margins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentMargins = margins ?? const EdgeInsets.symmetric(vertical: 16);

    return Padding(
      padding: currentMargins,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5,bottom: 3,top: 7),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          StaggeredGrid.extent(
            maxCrossAxisExtent: expandContent ? 500 : 250,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: items,
          )
        ],
      ),
    );
  }
}