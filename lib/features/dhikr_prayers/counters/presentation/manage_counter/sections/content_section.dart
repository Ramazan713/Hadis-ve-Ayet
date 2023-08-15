

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/components/input_text_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/components/select_counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/manage_counter_page.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

extension ManageCounterPageContentExt on ManageCounterPage{


  Widget getSelectTypeWidget(){
    return BlocSelector<ManageCounterBloc,ManageCounterState,CounterType>(
      selector: (state)=>state.selectedType,
      builder: (context,counterType){
        return SelectCounter(
          title: "Sayaç Türü Seç",
          selectedItem: counterType,
          onChange: (type){
            context.read<ManageCounterBloc>()
                .add(ManageCounterEventSetType(type: type));
          },
        );
      },
    );
  }

  Widget getBottomButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CustomButtonPositive(
        onTap: (){
          context.read<ManageCounterBloc>().add(ManageCounterEventUpdate(
            newName: nameTextController.text,
            newArabicContent: arabicContentController.text,
            newGoal: goalTextController.text,
            newContent: contentTextController.text,
            newMeaning: meaningTextController.text,
          ));
        },
        label: actionName,
      ),
    );
  }

  Widget getContentFields(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputTextItem(
          name: "İsim (zorunlu alan) ",
          textEditingController: nameTextController,
          maxLines: 2,
          textInputAction: TextInputAction.next,
        ),
        InputTextItem(
          name: "İçerik (isteğe bağlı) ",
          textEditingController: contentTextController,
          maxLines: 7,
          minLines: 2,
          inputType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
        ),
        InputTextItem(
          name: "Anlamı (isteğe bağlı) ",
          textEditingController: meaningTextController,
          maxLines: 7,
          minLines: 2,
          inputType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
        ),
        InputTextItem(
          name: "Arapça İçerik (isteğe bağlı)",
          textEditingController: arabicContentController,
          maxLines: 7,
          minLines: 2,
          inputType: TextInputType.multiline,
          fontFamily: KPref.fontFamilyArabic.defaultPrefEnum.fontName,
          textDirection: TextDirection.rtl,
          plusFontSize: 5,
          textInputAction: TextInputAction.next,
        ),
        InputTextItem(
          name: "Açıklama (isteğe bağlı)",
          textEditingController: arabicContentController,
          maxLines: 5,
          minLines: 2,
          inputType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
        ),
        InputTextItem(
          name: "Hedef (isteğe bağlı)",
          textEditingController: goalTextController,
          maxLines: 1,
          inputType: TextInputType.number,
          hintText: "Belirlenmedi",
          textInputAction: TextInputAction.done,
        ),
      ]
    );
  }
}