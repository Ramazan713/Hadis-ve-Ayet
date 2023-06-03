import 'package:flutter/material.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../search_sliver_appbar.dart';

class CustomAppBarSearchable extends StatelessWidget {
  final void Function(String) onChanged;
  final void Function() onClosed;
  final CustomSliverAppBar sliverAppBar;
  final bool searchBarVisible;

  const CustomAppBarSearchable({
    Key? key,required this.searchBarVisible, required this.onChanged, required this.onClosed,
    required this.sliverAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = searchBarVisible
        ? _getSearchBar(context)
        : sliverAppBar;

    return SliverAnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: appBar,
    );
    return const Placeholder();
  }

  Widget _getSearchBar(BuildContext context){
    return SearchSliverAppBar(
      onChanged: onChanged,
      onClosed: onClosed,
    );
  }
}
