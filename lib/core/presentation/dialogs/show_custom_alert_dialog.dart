

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showCustomAlertDialog(BuildContext context,{
  String? title,
  String? content,
  void Function()? btnApproved,
  void Function()? btnCancelled,
  String? negativeLabel,
  String? positiveLabel,
  bool useRootNavigator = false
}){

  duplicateDialogHandler(func: ()async{

    List<Widget> getChildren() {
      List<Widget> children = [];
      if (title != null) {
        children.add(Padding(
            padding: const EdgeInsets.only(top: 11,bottom: 13),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )));
      }
      if (content != null) {
        children.add(Padding(
            padding: const EdgeInsets.only(top: 7,bottom: 13),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            )));
      }
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 7,top: 13),
        child: Row(
          children: [
            Expanded(
              child: CustomButtonNegative(
                onTap: () {
                  Navigator.of(context,rootNavigator: useRootNavigator).pop();
                  btnCancelled?.call();
                },label: negativeLabel,
              ),
            ),
            Expanded(
                child: CustomButtonPositive(
                  onTap: () {
                    Navigator.of(context,rootNavigator: useRootNavigator).pop();
                    btnApproved?.call();
                  },label: positiveLabel,
                )),
          ],
        ),
      ));
      return children;
    }

    showDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (context){
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 7),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: getChildren(),
                ),
              ),
            ),
          );
        }
    );
  });
}