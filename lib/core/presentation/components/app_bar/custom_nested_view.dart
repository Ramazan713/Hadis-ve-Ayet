import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';

@Deprecated("Use BaseNestedScrollView")
class CustomNestedView extends StatelessWidget {

  final List<Widget> Function(BuildContext context, bool innerBoxIsScrolled) headerSliverBuilder;
  final Widget child;
  final CustomScrollController? scrollController;
  final bool floatHeaderSlivers;

  const CustomNestedView({
    Key? key,
    required this.headerSliverBuilder,
    required this.child,
    this.scrollController,
    this.floatHeaderSlivers = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: headerSliverBuilder,
        body: child,
        controller: scrollController?.controller,
        floatHeaderSlivers: floatHeaderSlivers
    );
  }
}
