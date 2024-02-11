import 'package:flutter/material.dart';
import 'package:hadith/core/extensions/list_ext.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';

class SingleAdaptivePane extends StatelessWidget {
  final bool useAdaptivePadding;
  final Widget child;
  final int Function(BuildContext context, WindowSizeClass windowSizeClass)? getContentFlex;

  const SingleAdaptivePane({
    super.key,
    required this.child,
    this.useAdaptivePadding = false,
    this.getContentFlex
  });

  @override
  Widget build(BuildContext context) {
    final windowSizeClass = calculateWindowSize(context);

    if(!windowSizeClass.isCompact){
      final defaultFlex = windowSizeClass.isExpanded ? 3 : 7;
      final contentFlex = getContentFlex?.call(context, windowSizeClass) ?? defaultFlex;
      return AdaptivePadding(
        windowSizeClass: windowSizeClass,
        useAdaptivePadding: useAdaptivePadding,
        child: Row(
          children: [
            const Spacer(),
            Expanded(
                flex: contentFlex,
                child: child
            ),
            const Spacer()
          ],
        ),
      );
    }
    return AdaptivePadding(
        windowSizeClass: windowSizeClass,
        useAdaptivePadding: useAdaptivePadding,
        child: child
    );
  }
}
