
import 'package:flutter/material.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showEditTextBottomDia(BuildContext context, Function(String) listener, {
  String title = "Başlık",
  String content = "",
  bool useRootNavigator = false
}) async{

  var controller = TextEditingController(text: content);
  var _errorText = "";
  final _formKey = GlobalKey<FormState>();
  await showModalBottomSheet(
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style:  Theme.of(context).textTheme.bodyText1,
                      autofocus: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Boş geçilemez";
                        }
                        return null;
                      },
                      controller: controller,
                      decoration: InputDecoration(
                          errorText: _errorText,
                          hintText: "yazı alanı",
                          filled: true,
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonNegative(
                        onTap: () {
                          Navigator.of(context,rootNavigator: useRootNavigator).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomButtonPositive(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            var text = controller.text;
                            listener.call(text);
                            Navigator.of(context,rootNavigator: useRootNavigator).pop();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}