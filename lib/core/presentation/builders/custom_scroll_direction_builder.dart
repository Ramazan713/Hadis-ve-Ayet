import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';

class CustomScrollDirectionBuilder extends StatefulWidget {
  final ScrollController controller;
  final Widget Function(BuildContext context, CustomScrollDirection direction) builder;

  const CustomScrollDirectionBuilder({
    Key? key,
    required this.controller,
    required this.builder
  }) : super(key: key);

  @override
  State<CustomScrollDirectionBuilder> createState() => _CustomScrollDirectionBuilderState();
}

class _CustomScrollDirectionBuilderState extends State<CustomScrollDirectionBuilder> {

  final ValueNotifier<bool> _notifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _notifier,
        builder: (context, isScrollingUp, child){
          return widget.builder(
              context,
              isScrollingUp ? CustomScrollDirection.up : CustomScrollDirection.down
          );
        }
    );
  }

  void listen(){
    EasyDebounce.debounce("scroll_x", const Duration(milliseconds: 300), () {
      setValue();
    });

    EasyThrottle.throttle("scroll_y", const Duration(milliseconds: 300), () {
      setValue();
    });
  }

  void setValue(){
    if (widget.controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (_notifier.value == true) {
        _notifier.value = false;
      }
    } else {
      if (widget.controller.position.userScrollDirection == ScrollDirection.forward) {
        if (_notifier.value == false) {
          _notifier.value = true;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    _notifier.dispose();
    super.dispose();
  }

}
