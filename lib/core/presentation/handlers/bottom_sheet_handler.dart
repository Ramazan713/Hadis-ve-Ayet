

import 'package:flutter/material.dart';





void showBottomSheetHandler({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool useSafeArea = true,
  bool enableDrag = true,
  Color? backgroundColor,
  void Function()? onClosed
}){

  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: backgroundColor,
    builder: (context){
      return child;
    }
  ).then((value){
    onClosed?.call();
  });

}