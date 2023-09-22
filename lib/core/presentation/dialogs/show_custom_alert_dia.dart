
import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';

void showCustomAlertDia(BuildContext context, {
  required String title,
  String? content,
  void Function()? btnApproved,
  void Function()? btnCancelled,
  String? cancelLabel,
  String? approveLabel,
  bool useRootNavigator = false
}) {

  duplicateDialogHandler(func: ()async{
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: useRootNavigator,
      builder: (context){
        return AlertDialog(
          title: Text(title),
          content: content != null ? Text(content): null,
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context,rootNavigator: useRootNavigator).pop();
                  btnCancelled?.call();
                },
                child: Text(cancelLabel ?? "Iptal")
            ),
            FilledButton.tonal(
                onPressed: (){
                  Navigator.of(context,rootNavigator: useRootNavigator).pop();
                  btnApproved?.call();
                },
                child: Text(approveLabel ?? "Onayla")
            )
          ],
        );
      }
    );
  });
}
