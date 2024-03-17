
import 'package:flutter/material.dart';
import 'package:hadith/core/extensions/list_ext.dart';

class BaseExpandableItem extends StatefulWidget {
  final Widget Function(BuildContext, bool isExpanded) buildHeader;
  final Widget Function(BuildContext, bool isExpanded) buildContent;
  final Widget Function(BuildContext, bool isExpanded)? buildSeparator;
  final bool initialValue;
  final EdgeInsets? headerInnerPadding;
  final int durationInMilliSeconds;
  final bool enabledExpandable;

  const BaseExpandableItem({
    super.key,
    required this.buildHeader,
    required this.buildContent,
    this.initialValue = false,
    this.enabledExpandable = true,
    this.durationInMilliSeconds = 300,
    this.headerInnerPadding,
    this.buildSeparator
  });

  @override
  State<BaseExpandableItem> createState() => _BaseExpandableItemState();
}

class _BaseExpandableItemState extends State<BaseExpandableItem> {
  final ValueNotifier<bool> _isVisibleNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isVisibleNotifier.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.circular(8);

    return ValueListenableBuilder(
      valueListenable: _isVisibleNotifier,
      builder: (context, isVisible, child){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[].fromFilteredItems([
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                if(widget.enabledExpandable){
                  _isVisibleNotifier.value = !_isVisibleNotifier.value;
                }
              },
              child: Ink(
                padding: widget.headerInnerPadding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                ),
                child: widget.buildHeader(context, isVisible),
              ),
            ),
            widget.buildSeparator?.call(context,isVisible),
            AnimatedSwitcher(
              duration: Duration(milliseconds: widget.durationInMilliSeconds),
              child: isVisible ? widget.buildContent(context, isVisible) : null,
            )
          ]),
        );
      }
    );
  }
}