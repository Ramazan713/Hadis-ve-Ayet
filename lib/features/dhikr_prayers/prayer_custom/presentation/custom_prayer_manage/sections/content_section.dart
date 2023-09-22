
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/constants/k_validators.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';

import '../bloc/custom_prayer_manage_bloc.dart';
import '../bloc/custom_prayer_manage_event.dart';
import '../custom_prayer_manage_page.dart';

extension ManageCustomPrayerPageContentExt on CustomPrayerManagePage{


  Widget getBottomButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FilledButton(
        child: Text(actionName),
        onPressed: (){
          formKey.currentState?.validate();
          if(formKey.currentState?.isValid == true){
            context.read<CustomPrayerManageBloc>().add(CustomPrayerManageEventUpdate(
              newName: nameTextController.text,
              newArabicContent: arabicContentController.text,
              newSource: sourceTextController.text,
              newContent: contentTextController.text,
              newMeaning: meaningTextController.text,
            ));
          }
        },
      )
    );
  }

  Widget getFormField({
    required TextEditingController controller,
    required String title,
    int? maxLines,
    int? minLines = 1,
    TextInputType? inputType,
    TextInputAction inputAction = TextInputAction.next,
    TextStyle? style,
    TextDirection? textDirection,
    List<FormFieldValidator<String>> validators = const []
  }){
    return CustomFormTextField(
      controller: controller,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputAction: inputAction,
      label: title,
      maxLines: maxLines,
      minLines: minLines,
      keyBoardType: inputType,
      style: style,
      textDirection: textDirection,
      validators: validators,
      padding: const EdgeInsets.symmetric(vertical: 13),
    );
  }

  TextStyle? getArabicStyle(BuildContext context,{int plusFontSize = 5}){
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontFamily: KPref.fontFamilyArabic.defaultPrefEnum.fontName,
        fontSize: (Theme.of(context).textTheme.bodyLarge?.fontSize??17) + plusFontSize
    );
  }

  Widget getContents(BuildContext context){
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getFormField(
            controller: nameTextController,
            title: "İsim (zorunlu alan)",
            maxLines: 2,
            validators: [KValidate.required, KValidate.minRequire(3)]
          ),
          getFormField(
            controller: contentTextController,
            title: "İçerik (isteğe bağlı)",
            maxLines: 7,
            minLines: 2,
            inputType: TextInputType.multiline
          ),
          getFormField(
            controller: meaningTextController,
            title: "Anlamı (isteğe bağlı)",
            maxLines: 7,
            minLines: 2,
            inputType: TextInputType.multiline
          ),
          getFormField(
            controller: arabicContentController,
            title: "Arapça İçerik (isteğe bağlı)",
            maxLines: 7,
            minLines: 2,
            inputType: TextInputType.multiline,
            style: getArabicStyle(context),
            textDirection: TextDirection.rtl,
          ),
          getFormField(
            controller: sourceTextController,
            title: "Kaynak (isteğe bağlı)",
            inputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

}