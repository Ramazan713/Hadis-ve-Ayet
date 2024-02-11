import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/constants/k_verse.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_bloc.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_event.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_state.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/core/presentation/selections/dropdown_text_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import '../../features/select_font_size/components/font_slider_item.dart';

void showSelectFontSizeDia(BuildContext context){

  final selectFontBloc = context.read<SelectFontSizeBloc>();
  selectFontBloc.add(SelectFontSizeEventInit());

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    child: _DialogContent(
      controller: ScrollController(),
      flexFit: FlexFit.loose,
      onClose: (){
        context.pop();
      },
    ),
    bottomSheetChild: DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.7,
      maxChildSize: 0.99,
      builder: (context, scrollController){
        return _DialogContent(
          controller: scrollController,
          flexFit: FlexFit.tight,
          onClose: (){
            context.pop();
          },
        );
      },
    )
  );
}

class _DialogContent extends StatelessWidget {
  final void Function() onClose;
  final ScrollController controller;
  final FlexFit flexFit;

  const _DialogContent({
    super.key,
    required this.onClose,
    required this.controller,
    required this.flexFit
  });

  @override
  Widget build(BuildContext context) {
    final selectFontBloc = context.read<SelectFontSizeBloc>();

    return BlocListener<SelectFontSizeBloc,SelectFontSizeState>(
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          selectFontBloc.add(SelectFontSizeEventClearMessage());
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 13,left: 13,top: 5,bottom: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            getCloseIcon(context),
            Flexible(
              fit: flexFit,
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 150
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: getContent(context)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24,bottom: 16),
                      child: _getDropdownArabicFont(context)
                    ),
                    _getContentSlider(),
                    _getArabicSlider(),
                  ],
                ),
              ),
            ),
            _getButtons(context)
          ],
        ),
      ),
    );
  }


  Widget getCloseIcon(BuildContext context){
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: onClose,
        icon: const Icon(Icons.close)
      ),
    );
  }

  Widget getContent(BuildContext context){
    return Column(
      children: [
        _getArabicContent(context),
        const SizedBox(height: 17,),
        _getTextContent(context),
      ],
    );
  }
}



Widget _getButtons(BuildContext context){
  final selectFontBloc = context.read<SelectFontSizeBloc>();
  return BlocBuilder<SelectFontSizeBloc,SelectFontSizeState>(
    builder: (context, state){
      return SharedDiaButtons(
        enabledCancel: state.resetButtonEnabled,
        enabledApprove: state.saveButtonEnabled,
        approveLabel: "Kaydet",
        cancelLabel: "Değişikleri geri al",
        onApprove: (){
          selectFontBloc.add(SelectFontSizeEventSave());
        },
        onCancel: (){
          selectFontBloc.add(SelectFontSizeEventReset());
        },
      );
    },
  );
}


Widget _getArabicContent(BuildContext context){
  return BlocBuilder<SelectFontSizeBloc,SelectFontSizeState>(
    buildWhen: (prevState,nextState){
      return prevState.selectedArabicFontSize != nextState.selectedArabicFontSize ||
            prevState.selectedFontFamilyArabic != nextState.selectedFontFamilyArabic;
    },
    builder: (context, state){
      return AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: ArabicContentItem(
          content: KVerse.mentionTextArabic,
          fontSize: state.selectedArabicFontSize.size,
          fontFamily: state.selectedFontFamilyArabic,
        ),
      );
    },
  );
}


Widget _getTextContent(BuildContext context){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,double>(
    selector: (state) => state.selectedContentFontSize.size,
    builder: (context, contentFontSize){
      return AnimatedSize(
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
  final selectFontBloc = context.read<SelectFontSizeBloc>();
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,FontFamilyArabicEnum>(
    selector: (state) => state.selectedFontFamilyArabic,
    builder: (context, currentFontFamilyArabic){
      return CustomDropdownTextMenu(
        items: FontFamilyArabicEnum.values,
        selectedItem: currentFontFamilyArabic,
        label: "Arapça Font",
        onSelected: (selected){
          if(selected != null){
            selectFontBloc.add(SelectFontSizeEventSetArabicFamily(fontFamilyArabic: selected));
          }
        },
      );
    }
  );
}

Widget _getContentSlider(){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,FontSizeEnum>(
    selector: (state) => state.selectedArabicFontSize,
    builder: (context, arabicFontSize){
      final selectFontBloc = context.read<SelectFontSizeBloc>();
      return FontSliderItem(
          title: "Arapça Yazı Boyutu",
          onChanged: (newValue){
            selectFontBloc.add(SelectFontSizeEventSetArabicSize(fontSize: newValue));
          },
          currentValue: arabicFontSize,
      );
    }
  );
}

Widget _getArabicSlider(){
  return BlocSelector<SelectFontSizeBloc,SelectFontSizeState,FontSizeEnum>(
    selector: (state) => state.selectedContentFontSize,
    builder: (context, contentFontSize){
      final selectFontBloc = context.read<SelectFontSizeBloc>();
      return FontSliderItem(
        title: "Yazı Boyutu",
        onChanged: (newValue){
          selectFontBloc.add(SelectFontSizeEventSetContentSize(fontSize: newValue));
        },
        currentValue: contentFontSize,
      );
    }
  );
}
