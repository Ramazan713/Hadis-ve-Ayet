import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_delay_type.dart';
import 'package:hadith/core/presentation/components/app_bar/base_nested_scroll_view.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_appbar_searchable.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';

class DefaultNestedSearchableAppBar extends StatelessWidget {

  final Widget child;
  final TextEditingController textEditingController;
  final bool searchBarVisible;
  final void Function(String) onTextChanged;
  final void Function(bool isVisible) onSearchVisibilityChanged;
  final CustomScrollController? scrollController;
  final CustomAutoScrollController? contentScrollController;
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
  final int delayMilliSeconds;
  final ScrollDelayType scrollDelayType;

  const DefaultNestedSearchableAppBar({
    Key? key,
    required this.textEditingController,
    required this.child,
    required this.onTextChanged,
    required this.onSearchVisibilityChanged,
    this.scrollDelayType = ScrollDelayType.both,
    this.searchBarVisible = false,
    this.floatHeaderSlivers = false,
    this.useWillPopScope = true,
    this.delayMilliSeconds = 500,
    this.headerSlivers = const [],
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.contentScrollController,
    this.scrollController,
    this.appBarBottom,
    this.title,
    this.actions,
    this.appBarType,
    this.showNavigateBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !(searchBarVisible && useWillPopScope),
      onPopInvoked: (canPop){
        if(!canPop){
          onTextChanged("");
          textEditingController.text = "";
          onSearchVisibilityChanged(false);
        }
      },
      child: BaseNestedScrollView(
        scrollController: scrollController,
        contentScrollController: contentScrollController,
        floatHeaderSlivers: floatHeaderSlivers,
        headerSlivers: headerSlivers,
        delayMilliSeconds: delayMilliSeconds,
        scrollDelayType: scrollDelayType,
        sliverAppBar: _getSearchableAppBar(),
        child: child,
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
