import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/constants/k_verse.dart';
import 'package:hadith/core/domain/enums/font_family_arabic.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_bloc.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_event.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_state.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button1.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'components/font_slider_item.dart';

void showSelectFontSizeDia(
    BuildContext context,
    ){

  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context){

        final selectFontBloc = context.read<SelectFontSizeBloc>();
        selectFontBloc.add(SelectFontSizeEventInit());

        return BlocListener<SelectFontSizeBloc,SelectFontSizeState>(
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              selectFontBloc.add(SelectFontSizeEventClearMessage());
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 13,left: 13,top: 5,bottom: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: (){
                          context.pop();
                        },
                        icon: const Icon(Icons.close)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Column(
                      children: [
                        _getArabicContent(context),
                        const SizedBox(height: 17,),
                        _getTextContent(context),
                      ],
                    ),
                  ),

                  _getDropdownArabicFont(context),
                  _getContentSlider(),
                  _getArabicSlider(),
                  _getButtons(context)
                ],
              ),
            ),
          ),
        );
      }
  );
}

Widget _getButtons(BuildContext context){
  final selectFontBloc = context.read<SelectFontSizeBloc>();

  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      children: [
        Expanded(
          child: CustomButton1(
            onTap: (){
              selectFontBloc.add(SelectFontSizeEventReset());
            },
            label: "Varsayılan",
          ),
        ),
        Expanded(
          child: CustomButtonPositive(
            onTap: (){
              selectFontBloc.add(SelectFontSizeEventSave());
            },
            label: "Kaydet",
          ),
        )
      ],
    ),
  );
}


Widget _getArabicContent(BuildContext context){
  return BlocBuilder<SelectFontSizeBloc,SelectFontSizeState>(
    buildWhen: (prevState,nextState){
      return prevState.arabicFontSize != nextState.arabicFontSize ||
            prevState.fontFamilyArabic != nextState.fontFamilyArabic;
    },
    builder: (context, state){
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: ArabicContentItem(
          content: KVerse.mentionTextArabic,
          fontSize: state.arabicFontSize,
          fontFamily: state.fontFamilyArabic,
        ),
      );
    },
  );
}


Widget _getTextContent(BuildContext context){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,double>(
      selector: (state) => state.contentFontSize,
      builder: (context, contentFontSize){
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Text(
              KVerse.mentionText,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: contentFontSize)
          ),
        );
      }
  );
}


Widget _getDropdownArabicFont(BuildContext context){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,FontFamilyArabicEnum>(
      selector: (state) => state.fontFamilyArabic,
      builder: (context, currentFontFamilyArabic){

        final selectFontBloc = context.read<SelectFontSizeBloc>();

        return Row(
          children: [
            Text(
              "Arapça Font: ",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 13,),
            DropdownButton<FontFamilyArabicEnum>(
              value: currentFontFamilyArabic,

              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 3),
              items: FontFamilyArabicEnum.values.map((e){
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if(value==null) return;
                selectFontBloc.add(SelectFontSizeEventSetArabicFamily(fontFamilyArabic: value));
              },
            ),
          ],
        );
      }
  );
}

Widget _getContentSlider(){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,double>(
      selector: (state) => state.arabicFontSize,
      builder: (context, arabicFontSize){
        final selectFontBloc = context.read<SelectFontSizeBloc>();
        return FontSliderItem(
            title: "Arapça Yazı Boyutu",
            onChanged: (newValue){
              selectFontBloc.add(SelectFontSizeEventSetArabicSize(size: newValue));
            },
            currentValue: arabicFontSize
        );
      }
  );
}

Widget _getArabicSlider(){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,double>(
      selector: (state) => state.contentFontSize,
      builder: (context, contentFontSize){
        final selectFontBloc = context.read<SelectFontSizeBloc>();
        return FontSliderItem(
            title: "Yazı Boyutu",
            onChanged: (newValue){
              selectFontBloc.add(SelectFontSizeEventSetContentSize(size: newValue));
            },
            currentValue: contentFontSize
        );
      }
  );
}
