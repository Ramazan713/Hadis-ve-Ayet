import 'dart:ffi';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class ListDetailAdaptiveLayout extends StatefulWidget {

  final Widget Function(bool isSinglePane) onListWidget;
  final Widget Function(bool isSinglePane) onDetailWidget;
  final bool? showDetailInSinglePane;
  final Widget Function(Widget Function(bool showDetailInSinglePane) onShowDetailResult)? onShowDetailInSinglePaneBuilder;
  final ScrollController? listScrollController;
  final ScrollController? detailScrollController;

  final void Function()? onListOffsetListener;
  final void Function()? onListPostFrameCallback;
  final void Function()? onDetailOffsetListener;
  final void Function()? onDetailPostFrameCallback;
  final bool enableListeners;
  final bool useListOffset;
  final bool useDetailOffset;
  final int listenerDebounceMilliSeconds;

  const ListDetailAdaptiveLayout({
    super.key,
    required this.onListWidget,
    required this.onDetailWidget,
    this.enableListeners = true,
    this.useListOffset = true,
    this.useDetailOffset = true,
    this.listenerDebounceMilliSeconds = 350,
    this.onDetailPostFrameCallback,
    this.onDetailOffsetListener,
    this.showDetailInSinglePane,
    this.onShowDetailInSinglePaneBuilder,
    this.listScrollController,
    this.detailScrollController,
    this.onListOffsetListener,
    this.onListPostFrameCallback,
  });

  @override
  State<ListDetailAdaptiveLayout> createState() => _ListDetailAdaptiveLayoutState();
}

class _ListDetailAdaptiveLayoutState extends State<ListDetailAdaptiveLayout> {

  var listOffset = 0.0;
  var detailOffset = 0.0;

  @override
  void initState() {
    super.initState();
    if(widget.enableListeners){
      widget.listScrollController?.addListener(_listOffsetListener);
      widget.detailScrollController?.addListener(_detailOffsetListener);
    }
  }


  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: {
          Breakpoints.standard:  SlotLayout.from(
            key: const Key("ListDetailAdaptiveLayout Standard"),
            builder: (context){
              if(widget.showDetailInSinglePane == true){
                return _getAndHandleDetailWidget(true);
              }else if(widget.showDetailInSinglePane == false){
                return _getAndHandleListWidget(true);
              }

              final showDetailInSinglePaneBuilder = widget.onShowDetailInSinglePaneBuilder;
              if(showDetailInSinglePaneBuilder == null){
                return _getAndHandleListWidget(true);
              }

              return showDetailInSinglePaneBuilder(
                (showDetailInSinglePane){
                  if(showDetailInSinglePane){
                    return _getAndHandleDetailWidget(true);
                  }
                  return _getAndHandleListWidget(true);
                }
              );
            }
          ),
          Breakpoints.large:  SlotLayout.from(
            key: const Key("ListDetailAdaptiveLayout Large"),
            builder: (context){
              return Row(
                children: [
                  Expanded(
                    child: _getAndHandleListWidget(false)
                  ),
                  const SizedBox(width: 24,),
                  Expanded(
                      child: _getAndHandleDetailWidget(false)
                  )
                ],
              );
            }
          ),
        },
      ),
    );
  }

  Widget _getAndHandleDetailWidget(bool isSinglePane){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.detailScrollController?.hasClients == true){
        if(widget.useDetailOffset){
          widget.detailScrollController?.jumpTo(listOffset);
        }
        widget.onDetailPostFrameCallback?.call();
      }
    });
    return widget.onDetailWidget(isSinglePane);
  }

  Widget _getAndHandleListWidget(bool isSinglePane){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.listScrollController?.hasClients == true){
        if(widget.useListOffset){
          widget.listScrollController?.jumpTo(listOffset);
        }
        widget.onListPostFrameCallback?.call();
      }
    });
    return widget.onListWidget(isSinglePane);
  }


  void _listOffsetListener(){
    EasyDebounce.debounce("ListScrollListener", Duration(milliseconds: widget.listenerDebounceMilliSeconds), () {
      listOffset = widget.listScrollController?.offset ?? listOffset;
      widget.onListOffsetListener?.call();
    });
  }

  void _detailOffsetListener(){
    EasyDebounce.debounce("DetailScrollListener", Duration(milliseconds: widget.listenerDebounceMilliSeconds), () {
      detailOffset = widget.detailScrollController?.offset ?? detailOffset;
      widget.onDetailOffsetListener?.call();
    });
  }

  @override
  void dispose() {
    if(widget.enableListeners){
      widget.listScrollController?.removeListener(_listOffsetListener);
      widget.detailScrollController?.removeListener(_detailOffsetListener);
    }
    super.dispose();
  }
}
