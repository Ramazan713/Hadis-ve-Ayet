import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';

class SingleAdaptivePane extends StatelessWidget {
  final bool useAdaptivePadding;
  final Widget child;

  const SingleAdaptivePane({
    super.key,
    required this.child,
    this.useAdaptivePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 810),
        child: AdaptivePadding(
          key: const ValueKey("AdaptivePadding"),
          useAdaptivePadding: useAdaptivePadding,
          applyOnlyWindowClasses: const [WindowSizeClass.Compact, WindowSizeClass.Medium],
          child: child
        ),
      ),
    );
  }
}
