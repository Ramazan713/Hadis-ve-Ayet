
import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';

final _formKey = GlobalKey<FormState>();


void showEditTextDia(BuildContext context, Function(String) listener, {
  String title = "Başlık",
  String content = "",
  bool useRootNavigator = true
}) async{

  final controller = TextEditingController(text: content);
  String? errorText;

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    useSafeArea: true,
    useRootNavigator: useRootNavigator,
    baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
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
                key: _formKey,
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
                if (_formKey.currentState!.validate()) {
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