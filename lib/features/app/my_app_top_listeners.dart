import 'package:flutter/material.dart';
import 'package:hadith/core/features/ads/ad_listener.dart';
import 'package:hadith/core/features/handle_receive_intent/presentation/handle_receive_intent_connect.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/components/navigate_auto_save_point_wrapper.dart';
import 'package:hadith/core/features/share/share_connect.dart';

class MyAppTopListeners extends StatelessWidget {
  final Widget child;
  const MyAppTopListeners({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return ShareConnect(
      child: AdListener(
        child: HandleReceiveIntentConnect(
          child: NavigateAutoSavePointWrapper(
              child: child
          ),
        ),
      ),
    );
  }
}
