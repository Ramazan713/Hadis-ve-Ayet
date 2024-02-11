
import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';

void adaptiveBaseForDialogAndBottomSheet({
  required BuildContext context,
  required Widget child,
  Widget? dialogChild,
  Widget? bottomSheetChild,
  AdaptiveBaseDialogSheetEnum baseType = AdaptiveBaseDialogSheetEnum.adaptiveDialogSheet,
  bool useRootNavigator = false,
  bool useSafeArea = true,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool useDialogAsParent = true,
  WindowSizeClass? windowSizeClass,
  void Function()? onClosed
}){
  final currentWindowSizeClass = windowSizeClass ?? calculateWindowSize(context);

  switch(baseType){
    case AdaptiveBaseDialogSheetEnum.bottomSheet:
      _bottomSheetContent(
        context: context,
        useRootNavigator: useRootNavigator,
        useSafeArea: useSafeArea,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        onClosed: onClosed,
        child: child,
        bottomSheetChild: bottomSheetChild
      );
      break;
    case AdaptiveBaseDialogSheetEnum.adaptiveDialog:
      _dialogContent(
        context: context,
        useRootNavigator: useRootNavigator,
        useSafeArea: useSafeArea,
        isDismissible: isDismissible,
        onClosed: onClosed,
        child: child,
        dialogChild: dialogChild,
        useDialogAsParent: useDialogAsParent
      );
      break;
    case AdaptiveBaseDialogSheetEnum.adaptiveDialogSheet:
      if(currentWindowSizeClass.isExpanded){
        _dialogContent(
          context: context,
          useRootNavigator: useRootNavigator,
          useSafeArea: useSafeArea,
          isDismissible: isDismissible,
          onClosed: onClosed,
          child: child,
          dialogChild: dialogChild,
          useDialogAsParent: useDialogAsParent
        );
      }else{
        _bottomSheetContent(
          context: context,
          useRootNavigator: useRootNavigator,
          useSafeArea: useSafeArea,
          isScrollControlled: isScrollControlled,
          isDismissible: isDismissible,
          onClosed: onClosed,
          child: child,
          bottomSheetChild: bottomSheetChild
        );
        break;
      }
      break;
  }
}

void _dialogContent({
  required BuildContext context,
  required Widget child,
  required Widget? dialogChild,
  required bool useRootNavigator,
  required bool useSafeArea,
  required bool isDismissible,
  required bool useDialogAsParent,
  required void Function()? onClosed
}){
  showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    barrierDismissible: isDismissible,
    builder: (context){
      if(useDialogAsParent){
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            width: 560,
            child: dialogChild ?? child
          ),
        );
      }
      return SizedBox(
          width: 560,
          child: dialogChild ?? child
      );
    }
  ).then((value){
    onClosed?.call();
  });
}


void _bottomSheetContent({
  required BuildContext context,
  required Widget child,
  required Widget? bottomSheetChild,
  required bool useRootNavigator,
  required bool useSafeArea,
  required bool isScrollControlled,
  required bool isDismissible,
  required void Function()? onClosed
}){
  showBottomSheetHandler(
    context: context,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
    child: bottomSheetChild ?? child,
    onClosed: onClosed,
  );
}