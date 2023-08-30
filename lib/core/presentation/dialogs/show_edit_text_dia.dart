
import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showEditTextDia(BuildContext context, Function(String) listener, {
  String title = "Başlık",
  String content = "",
  bool useRootNavigator = false
}) async{

  var controller = TextEditingController(text: content);
  String? errorText;
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    useSafeArea: true,
    useRootNavigator: useRootNavigator,
    builder: (context){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      autofocus: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Boş geçilemez";
                        }
                        return null;
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        errorText: errorText,
                        label: const Text("Yazı alanı"),
                        filled: true,
                        border: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))
                        )
                      ),
                    ),
                  ),
                ),
                SharedDiaButtons(
                  onCancel: (){
                    Navigator.of(context,rootNavigator: useRootNavigator).pop();
                  },
                  onApprove: (){
                    if (formKey.currentState!.validate()) {
                      var text = controller.text;
                      listener.call(text);
                      Navigator.of(context,rootNavigator: useRootNavigator).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  );
}