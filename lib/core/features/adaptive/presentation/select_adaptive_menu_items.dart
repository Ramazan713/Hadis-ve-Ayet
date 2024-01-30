

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/selections/show_select_menu_items_dia.dart';



void selectAdaptiveMenuItems<T extends IMenuItem>(BuildContext context, {
  required List<T> items,
  required void Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false,
  WindowSizeClass? windowSizeClass
}){
  final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);

  if(currentWindowSizeClass.isExpanded){
    showSelectMenuItemsDia(
      context,
      items: items,
      onItemClick: onItemClick,
      title: title,
      useRootNavigator: useRootNavigator
    );
  }else{
    showBottomMenuItems(
      context,
      items: items,
      onItemClick: onItemClick,
      title: title,
      useRootNavigator: useRootNavigator
    );
  }
}



void selectAdaptiveMenuItemsExtended<T extends IMenuItem>(BuildContext context, {
  required void Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false,
  required Widget Function({required Widget Function(List<T> newItems) updateItems}) wrapper,
  WindowSizeClass? windowSizeClass
}){

  final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);

  if(currentWindowSizeClass.isExpanded){
    showSelectMenuItemsExtendedDia(
        context,
        wrapper: wrapper,
        onItemClick: onItemClick,
        title: title,
        useRootNavigator: useRootNavigator
    );
  }else{
    showCustomExtendBottomMenuItems(
        context,
        wrapper: wrapper,
        onItemClick: onItemClick,
        title: title,
        useRootNavigator: useRootNavigator
    );
  }
}