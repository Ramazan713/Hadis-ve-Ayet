
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_validators.dart';
import 'package:hadith/core/domain/enums/searchable_scroll_type.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/presentation/components/shared_header.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';
import 'package:hadith/core/presentation/selections/custom_searchable_select_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_result/select_page_result.dart';
import 'package:hadith/features/verses/shared/presentation/select_verse_page/bloc/select_verse_page_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/select_verse_page/bloc/select_verse_page_event.dart';
import 'package:hadith/features/verses/shared/presentation/select_verse_page/bloc/select_verse_page_state.dart';

void selectVersePageDia(BuildContext context,{
  required void Function(SelectPageResult) onApproved,
  int? startPage
}){

  final selectPageBloc = context.read<SelectVersePageBloc>();
  selectPageBloc.add(SelectVerseEventLoadData(startPage: startPage));


  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
    child: _DialogContent(
      onApproved: onApproved,
      onCancel: (){
        Navigator.pop(context);
      },
    )
  );
}


class _DialogContent extends StatefulWidget {

  final void Function() onCancel;
  final void Function(SelectPageResult result) onApproved;

  const _DialogContent({
    required this.onCancel,
    required this.onApproved
  });

  @override
  State<_DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  final TextEditingController textPageEditingController = TextEditingController();

  EdgeInsets get margins => const EdgeInsets.symmetric(vertical: 8);

  final focusPageNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<SelectVersePageBloc>();
    textPageEditingController.setTextWithCursor(bloc.state.page.toString());
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: IntrinsicHeight(
        child: getListeners(
          context: context,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SharedHeader(title: "Pozisyon Seç", onClose: widget.onCancel),
                Flexible(
                  child: getContent(context),
                ),
                getButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getContent(BuildContext context){
    final bloc = context.read<SelectVersePageBloc>();

    return BlocBuilder<SelectVersePageBloc,SelectVersePageState>(
      builder: (context, state){
        final isEnabled = !state.isLoading;
        return StackSecondContent(
          showStackChild: true,
          getSecondChild: (){
            if(state.isLoading) return const SharedLoadingIndicator();
            return const SizedBox();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getAnimation(
                  child: CustomSearchableSelectTextMenu<Cuz>(
                    enabled: isEnabled,
                    margins: margins,
                    items: state.cuzs,
                    selectedItem: state.selectedCuz,
                    label: "Cüz Seç",
                    onSelected: (selected){
                      bloc.add(SelectVerseEventSelectCuz(cuz: selected));
                    },
                  ),
                ),

                getAnimation(
                  child: CustomSearchableSelectTextMenu<Surah>(
                    enabled: isEnabled,
                    margins: margins,
                    items: state.surahes,
                    selectedItem: state.selectedSurah,
                    label: "Sure Seç",
                    onSelected: (selected){
                      bloc.add(SelectVerseEventSelectSurah(surah: selected));
                    },
                  ),
                ),

                getAnimation(
                  child: CustomSearchableSelectTextMenu(
                    enabled: isEnabled,
                    margins: margins,
                    items: state.verseNumbers,
                    selectedItem: state.selectedVerseNumber,
                    label: "Ayet Seç",
                    scrollType: SearchableScrollType.navigatePosition,
                    onSelected: (selected){
                      bloc.add(SelectVerseEventSelectVerse(verseNumber: selected));
                    },
                  ),
                ),

                getAnimation(
                  child: CustomFormTextField(
                    enabled: focusPageNode.hasFocus || isEnabled,
                    focusNode: focusPageNode,
                    autoFocus: false,
                    controller: textPageEditingController,
                    padding: margins,
                    keyBoardType: TextInputType.number,
                    hintText: "Sayfa giriniz",
                    label: "Sayfa",
                    validators: [
                      KValidate.onlyNumbers(),
                      KValidate.numberInterval(1, state.maxPage.toDouble())
                    ],
                    onChanged: (newText){
                      bloc.add(SelectVerseEventSelectPage(page: newText ?? ""));
                    },
                  ),
                ),
                const SizedBox(height: 8,)
              ],
            ),
          ));
      }
    );
  }

  Widget getAnimation({required Widget child}){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }

  Widget getButton(BuildContext context){
    final bloc = context.read<SelectVersePageBloc>();
    return BlocBuilder<SelectVersePageBloc,SelectVersePageState>(
      buildWhen: (prevState, nextState){
        return prevState.isLoading != nextState.isLoading;
      },
      builder: (context, state){
        return FilledButton(
          onPressed: state.isLoading ? null : (){
            bloc.add(SelectVerseEventApprove());
          },
          child: const Text("Onayla"),
        );
      },
    );
  }

  Widget getListeners({required BuildContext context,required Widget child}){
    final bloc = context.read<SelectVersePageBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<SelectVersePageBloc,SelectVersePageState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(SelectVersePageEventClearMessage());
            }
          },
        ),
        BlocListener<SelectVersePageBloc,SelectVersePageState>(
          listenWhen: (prevState, nextState){
            return prevState.selectResult != nextState.selectResult;
          },
          listener: (context, state){
            final selectResult = state.selectResult;
            if(selectResult != null){
              widget.onApproved(selectResult);
              widget.onCancel();
              bloc.add(SelectVerseEventClearResult());
            }
          },
        ),
        BlocListener<SelectVersePageBloc,SelectVersePageState>(
          listenWhen: (prevState, nextState){
            return prevState.page != nextState.page;
          },
          listener: (context, state){
            textPageEditingController.setTextWithCursor(state.page.toString());
          }
        )
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    textPageEditingController.dispose();
    focusPageNode.dispose();
    super.dispose();
  }

}


