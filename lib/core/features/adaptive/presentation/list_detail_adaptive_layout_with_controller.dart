import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';

class ListDetailAdaptiveLayoutWithController extends StatefulWidget {

  final Widget Function(ScrollController? controller, bool isSinglePane) onListWidget;
  final Widget Function(ScrollController? controller, bool isSinglePane) onDetailWidget;
  final bool? showDetailInSinglePane;
  final Widget Function(Widget Function(bool showDetailInSinglePane) onShowDetailResult)? onShowDetailInSinglePaneBuilder;
  final ScrollController Function(double offset)? onCreateListController;
  final ScrollController Function(double offset)? onCreateDetailController;
  final bool useAdaptivePadding;
  final void Function()? onListOffsetListener;
  final void Function()? onDetailOffsetListener;
  final bool enableListeners;
  final bool useListOffset;
  final bool useDetailOffset;
  final int listenerDebounceMilliSeconds;

  const ListDetailAdaptiveLayoutWithController({
    super.key,
    required this.onListWidget,
    required this.onDetailWidget,
    this.useAdaptivePadding = false,
    this.enableListeners = true,
    this.useListOffset = true,
    this.useDetailOffset = true,
    this.listenerDebounceMilliSeconds = 200,
    this.onCreateDetailController,
    this.onCreateListController,
    this.onDetailOffsetListener,
    this.showDetailInSinglePane,
    this.onShowDetailInSinglePaneBuilder,
    this.onListOffsetListener,
  });

  @override
  State<ListDetailAdaptiveLayoutWithController> createState() => _ListDetailAdaptiveLayoutWithControllerState();
}

class _ListDetailAdaptiveLayoutWithControllerState extends State<ListDetailAdaptiveLayoutWithController> {

  var listOffset = 0.0;
  var detailOffset = 0.0;
  ScrollController? listScrollController;
  ScrollController? detailScrollController;

  @override
  Widget build(BuildContext context) {
    return AdaptivePadding(
      useAdaptivePadding: widget.useAdaptivePadding,
      child: AdaptiveLayout(
        body: SlotLayout(
          config: {
            Breakpoints.smallAndUp:  SlotLayout.from(
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
      ),
    );
  }

  Widget _getAndHandleDetailWidget(bool isSinglePane){
    if(detailScrollController != null){
      _disposeController(true);
    }
    detailScrollController = widget.onCreateDetailController?.call(detailOffset);
    if(widget.enableListeners){
      detailScrollController?.addListener(_detailOffsetListener);
    }
    return widget.onDetailWidget(detailScrollController, isSinglePane);
  }

  Widget _getAndHandleListWidget(bool isSinglePane){
    if(listScrollController != null){
      _disposeController(false);
    }
    listScrollController = widget.onCreateListController?.call(listOffset);
    if(widget.enableListeners){
      listScrollController?.addListener(_listOffsetListener);
    }
    return widget.onListWidget(listScrollController,isSinglePane);
  }


  void _listOffsetListener(){
    EasyDebounce.debounce("ListScrollListener", Duration(milliseconds: widget.listenerDebounceMilliSeconds), () {
      listOffset = listScrollController?.offset ?? listOffset;
      widget.onListOffsetListener?.call();
    });
  }

  void _detailOffsetListener(){
    EasyDebounce.debounce("DetailScrollListener", Duration(milliseconds: widget.listenerDebounceMilliSeconds), () {
      detailOffset = detailScrollController?.offset ?? detailOffset;
      widget.onDetailOffsetListener?.call();
    });
  }


  void _disposeController(bool isDetail){
    if(isDetail){
      if(widget.enableListeners){
        detailScrollController?.removeListener(_detailOffsetListener);
      }
      detailScrollController?.dispose();
      detailScrollController = null;
    }else{
      if(widget.enableListeners){
        listScrollController?.removeListener(_listOffsetListener);
      }
      listScrollController?.dispose();
      listScrollController = null;
    }
  }

  @override
  void dispose() {
    _disposeController(true);
    _disposeController(false);
    super.dispose();
  }
}
