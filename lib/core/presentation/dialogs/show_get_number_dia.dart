

import 'package:flutter/material.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';

void showGetNumberDia(BuildContext context,{
  required int currentIndex,
  required int limitIndex,
  required void Function(int selectedIndex) listener
}){

  void navigateBack(){
    Navigator.of(context,rootNavigator: true).pop();
  }

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
    child: _DialogContent(
      currentIndex: currentIndex,
      limitIndex: limitIndex,
      onCancel: navigateBack,
      onApprove: (number){
        listener(number);
        navigateBack();
      }
    )
  );
}

class _DialogContent extends StatelessWidget {

  final int currentIndex;
  final int limitIndex;
  final void Function()? onCancel;
  final void Function(int selectedIndex)? onApprove;

  _DialogContent({
    Key? key,
    required this.currentIndex,
    required this.limitIndex,
    required this.onApprove,
    this.onCancel
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.setTextWithCursor((currentIndex+1).toString());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "1 ile ${limitIndex+1} arasında bir sayı giriniz",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8,),
            Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Sayı girin"),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))
                  )
                ),
                validator: (text){
                  if(text==null||text.trim()==""){
                    return "yazı alanı boş geçilemez";
                  }
                  var reg=RegExp(r"^[0-9]+$");
                  if(!reg.hasMatch(text)){
                    return "yalnızca sayı giriniz";
                  }
                  int value=int.parse(text);
                  if(value<1||value>limitIndex+1){
                    return "lütfen sayıyı değer aralığında giriniz";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 19,),
            getButtons()
          ],
        ),
      ),
    );
  }

  Widget getButtons(){
    return SharedDiaButtons(
      onCancel: onCancel,
      onApprove: (){
        if (_formKey.currentState?.validate() == true) {
          var number = int.tryParse(controller.text);
          if(number!=null){
            onApprove?.call(number-1);
          }
        }
      },
    );
  }

}
