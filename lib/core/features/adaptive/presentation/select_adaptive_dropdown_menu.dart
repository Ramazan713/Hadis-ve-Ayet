

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_dropdown_menu_type.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';

class SelectAdaptiveDropdownMenu<T extends IMenuItem> extends StatelessWidget {
  final List<T> items;
  final void Function(T, AdaptiveDropdownMenuType) onItemClick;
  final WindowSizeClass? windowSizeClass;
  final String? title;
  final bool useRootNavigator;
  final Icon? icon;
  final bool popWhenItemSelect;

  const SelectAdaptiveDropdownMenu({super.key,
    required this.items,
    required this.onItemClick,
    this.useRootNavigator = false,
    this.popWhenItemSelect = false,
    this.windowSizeClass,
    this.icon,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);
    final currentIcon = icon ?? const Icon(Icons.more_vert);

    if(currentWindowSizeClass.isExpanded){
      return CustomDropdownIconMenu(
        items: items,
        onSelected: (selected){
          onItemClick(selected, AdaptiveDropdownMenuType.dropdownMenu);
        },
        icon: currentIcon,
      );
    }

    return IconButton(
      onPressed: (){
        showBottomMenuItems(context,
          items: items,
          onItemClick: (selected){
            if(popWhenItemSelect){
              Navigator.of(context,rootNavigator: useRootNavigator).pop();
            }
            onItemClick(selected, AdaptiveDropdownMenuType.bottomSheet);
          },
          title: title,
          useRootNavigator: useRootNavigator
        );
      },
      icon: currentIcon
    );
  }
}