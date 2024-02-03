
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/constants/k_validators.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';
import 'package:hadith/core/presentation/selections/custom_segmented_button.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_state.dart';
import '../manage_counter_page.dart';

extension ManageCounterPageContentExt on ManageCounterPage{

  Widget getSelectTypeWidget(BuildContext context,{
    EdgeInsets? margins
  }){
    return Padding(
      padding: margins ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
             "Sayaç Türü",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4,),
          BlocSelector<ManageCounterBloc,ManageCounterState,CounterType>(
            selector: (state)=>state.selectedType,
            builder: (context,counterType){
              return SingleSelectSegmentedButton(
                items: CounterType.values,
                selectedItem: counterType,
                onSelected: (selected){
                  context.read<ManageCounterBloc>()
                      .add(ManageCounterEventSetType(type: selected));
                }
              );
            },
          )
        ],
      ),
    );
  }

  Widget getBottomButton(BuildContext context,{
    EdgeInsets? margins
  }){
    return Padding(
      padding: margins ?? EdgeInsets.zero,
      child: FilledButton(
        child: Text(actionName),
        onPressed: (){
          formKey.currentState?.validate();
          if(formKey.currentState?.isValid == true){
            context.read<ManageCounterBloc>().add(ManageCounterEventUpdate(
              newName: nameTextController.text,
              newArabicContent: arabicContentController.text,
              newGoal: goalTextController.text,
              newContent: contentTextController.text,
              description: descriptionTextController.text,
              newMeaning: meaningTextController.text,
            ));
          }
        },
      ),
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
    );
  }

  TextStyle? getArabicStyle(BuildContext context,{int plusFontSize = 5}){
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontFamily: KPref.fontFamilyArabic.defaultPrefEnum.fontName,
        fontSize: (Theme.of(context).textTheme.bodyLarge?.fontSize??17) + plusFontSize
    );
  }

  Widget getNewContents(BuildContext context,{
    required WindowSizeClass windowSizeClass
  }){
    final defaultMinLineSize = windowSizeClass.isExpanded ? 4 : 2;
    final axisCount = windowSizeClass.isExpanded ? 2 : 1;

    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
        child: StaggeredGrid.count(
          crossAxisCount: axisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
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
              minLines: defaultMinLineSize,
              inputType: TextInputType.multiline
            ),
            getFormField(
              controller: meaningTextController,
              title: "Anlamı (isteğe bağlı)",
              maxLines: 7,
              minLines: defaultMinLineSize,
              inputType: TextInputType.multiline
            ),
            getFormField(
              controller: arabicContentController,
              title: "Arapça İçerik (isteğe bağlı)",
              maxLines: 7,
              minLines: defaultMinLineSize,
              inputType: TextInputType.multiline,
              style: getArabicStyle(context),
              textDirection: TextDirection.rtl,
            ),
            getFormField(
              controller: descriptionTextController,
              title: "Açıklama (isteğe bağlı)",
              maxLines: 5,
              minLines: defaultMinLineSize,
              inputType: TextInputType.multiline
            ),
            getFormField(
              controller: goalTextController,
              title: "Hedef (isteğe bağlı)",
              inputType: TextInputType.number,
              inputAction: TextInputAction.done,
              validators: [KValidate.onlyNumbers()]
            ),
          ],
        ),
      ),
    );
  }

}