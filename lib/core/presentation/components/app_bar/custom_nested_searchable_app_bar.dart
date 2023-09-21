import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';

import 'custom_appbar_searchable.dart';
import 'custom_nested_view.dart';

class CustomNestedSearchableAppBar extends StatelessWidget {

  final Widget child;
  final TextEditingController textEditingController;
  final bool searchBarVisible;
  final void Function(String) onTextChanged;
  final void Function(bool isVisible) onSearchVisibilityChanged;
  final CustomScrollController? scrollController;
  final bool floatHeaderSlivers;
  final PreferredSizeWidget? appBarBottom;
  final bool useWillPopScope;
  final Widget? title;
  final bool pinned;
  final bool snap;
  final bool floating;
  final List<Widget>? actions;
  final List<Widget> headerSlivers;
  final AppBarType? appBarType;
  final bool? showNavigateBack;

  const CustomNestedSearchableAppBar({
    Key? key,
    required this.textEditingController,
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
    this.appBarType,
    this.useWillPopScope = true,
    this.showNavigateBack,
    this.headerSlivers = const []
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(searchBarVisible && useWillPopScope){
          onTextChanged("");
          textEditingController.text = "";
          onSearchVisibilityChanged(false);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: CustomNestedView(
          scrollController: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                      sliver: _getSearchableAppBar()
                  )
              ),
              ...headerSlivers
            ];
          },
          child: child
      ),
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
      textEditingController: textEditingController,
    );
  }

  CustomSliverAppBar _getAppBar(){
    return CustomSliverAppBar(
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
      appBarType: appBarType,
      showNavigateBack: showNavigateBack,
    );
  }

}
