import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';

class DefaultAdaptiveLayout extends StatelessWidget {

  final bool useAdaptivePadding;
  final Widget Function(BuildContext context, WindowSizeClass windowSizeClass) builder;

  const DefaultAdaptiveLayout({
    super.key,
    required this.builder,
    this.useAdaptivePadding = false
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: {
          Breakpoints.small: SlotLayout.from(
            key: const Key("small"),
            builder: (context){
              return AdaptivePadding(
                useAdaptivePadding: useAdaptivePadding,
                windowSizeClass: WindowSizeClass.Compact,
                child: builder(context, WindowSizeClass.Compact),
              );
            }
          ),
          Breakpoints.medium: SlotLayout.from(
              key: const Key("medium"),
              builder: (context){
                return AdaptivePadding(
                  useAdaptivePadding: useAdaptivePadding,
                  windowSizeClass: WindowSizeClass.Medium,
                  child: builder(context, WindowSizeClass.Medium),
                );
              }
          ),
          Breakpoints.large: SlotLayout.from(
              key: const Key("large"),
              builder: (context){
                return AdaptivePadding(
                  useAdaptivePadding: useAdaptivePadding,
                  windowSizeClass: WindowSizeClass.Expanded,
                  child: builder(context, WindowSizeClass.Expanded),
                );
              }
          )
        },
      ),
    );
  }
}
