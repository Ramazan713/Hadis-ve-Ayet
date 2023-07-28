
import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showCustomAlertBottomDia(BuildContext context, {
  String? title,
  String? content,
  void Function()? btnApproved,
  void Function()? btnCancelled,
  String? negativeLabel,
  String? positiveLabel,
  bool useRootNavigator = false
}) {

  duplicateDialogHandler(func: ()async{
    showModalBottomSheet(
        useRootNavigator: useRootNavigator,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          List<Widget> getChildren() {
            List<Widget> children = [];
            if (title != null) {
              children.add(Padding(
                  padding: const EdgeInsets.only(top: 13,bottom: 7),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  )));
            }
            if (content != null) {
              children.add(Padding(
                  padding: const EdgeInsets.only(bottom: 19,top: 19),
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

          return SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
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
        });
  });


}
