import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/widgets/app_bar/custom_search_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';

import 'custom_appbar_searchable.dart';
import 'custom_nested_view.dart';

class CustomNestedSearchableAppBar extends StatelessWidget {

  final Widget child;
  final bool searchBarVisible;
  final void Function(String) onTextChanged;
  final void Function(bool isVisible) onSearchVisibilityChanged;
  final CustomScrollController? scrollController;
  final bool floatHeaderSlivers;
  final PreferredSizeWidget? appBarBottom;
  final Widget? title;
  final bool pinned;
  final bool snap;
  final bool floating;
  final List<Widget>? actions;
  final List<Widget> headerSlivers;

  const CustomNestedSearchableAppBar({
    Key? key,
    required this.child,
    required this.onTextChanged,
    required this.onSearchVisibilityChanged,
    this.searchBarVisible = false,
    this.scrollController,
    this.floatHeaderSlivers = false,
    this.appBarBottom,
    this.title,
    this.actions,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.headerSlivers = const []
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedView(
        scrollController: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            _getSearchableAppBar(),
            ...headerSlivers
          ];
        },
        child: child
    );
  }

  CustomAppBarSearchable _getSearchableAppBar(){
    return CustomAppBarSearchable(
      searchBarVisible: searchBarVisible,
      onChanged: onTextChanged,
      onClosed: (){
        onSearchVisibilityChanged(false);
      },
      sliverAppBar: _getAppBar(),
    );
  }

  CustomSliverAppBar _getAppBar(){
    return  CustomSliverAppBar(
      title: title,
      actions: [
        IconButton(
          onPressed: () {
            onSearchVisibilityChanged(true);
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
        ...?actions,
      ],
      bottom: appBarBottom,
      floating: floating,
      pinned: pinned,
      snap: snap,
    );
  }

}
