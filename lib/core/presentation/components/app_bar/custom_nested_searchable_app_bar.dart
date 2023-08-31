import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/presentation/components/app_bar/search_sliver_appbar.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/widgets/app_bar/custom_search_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';

import 'custom_appbar_searchable.dart';
import 'custom_nested_view.dart';

class CustomNestedSearchableAppBar extends StatefulWidget {

  final Widget child;
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
    required Key? key,
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
  State<CustomNestedSearchableAppBar> createState() => _CustomNestedSearchableAppBarState();
}

class _CustomNestedSearchableAppBarState extends State<CustomNestedSearchableAppBar>{
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(widget.searchBarVisible && widget.useWillPopScope){
          widget.onTextChanged("");
          textEditingController.text = "";
          widget.onSearchVisibilityChanged(false);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: CustomNestedView(
        scrollController: widget.scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            _getSearchableAppBar(),
            ...widget.headerSlivers
          ];
        },
        child: widget.child
      ),
    );
  }

  CustomAppBarSearchable _getSearchableAppBar(){
    return CustomAppBarSearchable(
      searchBarVisible: widget.searchBarVisible,
      onChanged: widget.onTextChanged,
      onClosed: (){
        widget.onSearchVisibilityChanged(false);
      },
      sliverAppBar: _getAppBar(),
      textEditingController: textEditingController,
    );
  }

  CustomSliverAppBar _getAppBar(){
    return CustomSliverAppBar(
      title: widget.title,
      actions: [
        IconButton(
          onPressed: () {
            widget.onSearchVisibilityChanged(true);
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
        ...?widget.actions,
      ],
      bottom: widget.appBarBottom,
      floating: widget.floating,
      pinned: widget.pinned,
      snap: widget.snap,
      appBarType: widget.appBarType,
      showNavigateBack: widget.showNavigateBack,
    );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }
}
