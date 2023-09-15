import 'package:flutter/material.dart';
import 'package:hadith/core/features/save_point/load_save_point/components/navigate_auto_save_point_wrapper.dart';
import 'package:hadith/core/features/share/share_connect.dart';

class MyAppTopListeners extends StatelessWidget {
  final Widget child;
  const MyAppTopListeners({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShareConnect(
      child: NavigateAutoSavePointWrapper(
          child: child
      ),
    );
  }
}
