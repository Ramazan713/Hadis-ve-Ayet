import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/models/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';

class SingleAdaptivePane extends StatelessWidget {
  final Widget child;
  final int Function(BuildContext context, WindowSizeClass windowSizeClass)? getContentFlex;

  const SingleAdaptivePane({
    super.key,
    required this.child,
    this.getContentFlex
  });

  @override
  Widget build(BuildContext context) {
    return DefaultAdaptiveLayout(
      builder: (context, windowSizeClass){
        if(!windowSizeClass.isCompact){
          final defaultFlex = windowSizeClass.isExpanded ? 3 : 7;
          final contentFlex = getContentFlex?.call(context, windowSizeClass) ?? defaultFlex;
          return Row(
            children: [
              const Spacer(),
              Expanded(
                flex: contentFlex,
                child: child
              ),
              const Spacer()
            ],
          );
        }
        return child;
      },
    );
  }
}
