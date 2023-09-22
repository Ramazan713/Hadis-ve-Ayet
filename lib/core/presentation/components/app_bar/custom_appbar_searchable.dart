import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_sliver_appbar.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'search_sliver_appbar.dart';

class CustomAppBarSearchable extends StatelessWidget {
  final void Function(String) onChanged;
  final void Function() onClosed;
  final CustomSliverAppBar sliverAppBar;
  final bool searchBarVisible;
  final TextEditingController textEditingController;


  const CustomAppBarSearchable({
    Key? key,
    required this.searchBarVisible,
    required this.onChanged,
    required this.onClosed,
    required this.sliverAppBar,
    required this.textEditingController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = searchBarVisible
        ? _getSearchBar(context)
        : sliverAppBar;

    return SliverAnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: appBar,
    );
  }

  Widget _getSearchBar(BuildContext context){
    return SearchSliverAppBar(
      onChanged: onChanged,
      onClosed: onClosed,
      textEditingController: textEditingController,
    );
  }
}
