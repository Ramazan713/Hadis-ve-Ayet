import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/features/adaptive/domain/models/enums/window_size_class.dart';

class DefaultAdaptiveLayout extends StatelessWidget {

  final Widget Function(BuildContext context, WindowSizeClass windowSizeClass) builder;

  const DefaultAdaptiveLayout({
    super.key,
    required this.builder
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: {
          Breakpoints.small: SlotLayout.from(
            key: const Key("small"),
            builder: (context){
              return builder(context, WindowSizeClass.Compact);
            }
          ),
          Breakpoints.medium: SlotLayout.from(
              key: const Key("medium"),
              builder: (context){
                return builder(context, WindowSizeClass.Medium);
              }
          ),
          Breakpoints.large: SlotLayout.from(
              key: const Key("large"),
              builder: (context){
                return builder(context, WindowSizeClass.Expanded);
              }
          )
        },
      ),
    );
  }
}
