import 'package:flutter/material.dart';
import 'package:hadith/core/features/save_point/load_save_point/components/navigate_auto_save_point_wrapper.dart';

class MyAppTopListeners extends StatelessWidget {
  final Widget child;
  const MyAppTopListeners({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigateAutoSavePointWrapper(
        child: child
    );
  }
}
