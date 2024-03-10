import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/constants/k_validators.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';
import 'package:hadith/core/domain/enums/searchable_scroll_type.dart';
import 'package:hadith/core/extensions/list_ext.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_config/select_quran_section_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_result/select_quran_section_result.dart';
import 'package:hadith/core/features/select_quran_section/presentation/bloc/select_quran_section_bloc.dart';
import 'package:hadith/core/features/select_quran_section/presentation/bloc/select_quran_section_event.dart';
import 'package:hadith/core/features/select_quran_section/presentation/bloc/select_quran_section_state.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/presentation/components/shared_header.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/core/presentation/selections/custom_searchable_select_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';

void showSelectQuranSectionDia({
  required BuildContext context,
  void Function(SelectQuranSectionResult)? onSubmit,
  SelectQuranSectionConfig config = const SelectQuranSectionConfig(),
  SelectQuranSectionLoadConfig loadConfig = const SelectQuranSectionLoadConfig(),
  AdaptiveBaseDialogSheetEnum baseType = AdaptiveBaseDialogSheetEnum.adaptiveDialog,
}){

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    baseType: baseType,
    child: _DialogContent(
      config: config,
      loadConfig: loadConfig,
      onSubmit: onSubmit,
    )
  );
}


class _DialogContent extends StatefulWidget {
  final SelectQuranSectionConfig config;
  final SelectQuranSectionLoadConfig loadConfig;
  final void Function(SelectQuranSectionResult)? onSubmit;

  const _DialogContent({
    super.key,
    required this.config,
    required this.loadConfig,
    this.onSubmit
  });

  @override
  State<_DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  final formKey = GlobalKey<FormBuilderState>();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController textPageEditingController = TextEditingController();


  EdgeInsets get margins => const EdgeInsets.symmetric(vertical: 8);

  final focusPageNode = FocusNode();

  SelectQuranSectionConfig get config => widget.config;


  @override
  void initState() {
    super.initState();
    final bloc = context.read<SelectQuranSectionBloc>();
    nameTextController.addListener(() {
      bloc.add(SelectQuranSectionEventCheckAutoGenerateName(text: nameTextController.text));
    });

    bloc.add(SelectQuranSectionEventLoadData(
      loadConfig: widget.loadConfig,
      generateVerseContent: config.showContentSection
    ));
    textPageEditingController.setTextWithCursor(widget.loadConfig.page?.toString() ?? bloc.state.page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
        child: BlocBuilder<SelectQuranSectionBloc,SelectQuranSectionState>(
          builder: (context, state){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[].fromFilteredItems([
                SharedHeader(
                  title: config.title ?? "Kurandan Ekle",
                  onClose: () {
                    context.pop();
                  },
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        getSelectionSection(context),
                        if(config.showContentSection)
                          getContentSection(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                if(config.showButton)
                  getSaveButton(context)
              ]),
            );
          },
        ),
      ),
    );
  }

  Widget getSaveButton(BuildContext context){
    final bloc = context.read<SelectQuranSectionBloc>();
    return FilledButton(
      child: Text(config.btnName ?? "Oluştur"),
      onPressed: (){
        formKey.currentState?.validate();
        if(formKey.currentState?.isValid == true){

          bloc.add(SelectQuranSectionEventSubmit(
            name: nameTextController.text,
            includeSelectedVerses: config.includeSelectedVerses
          ));
        }
      },
    );
  }

  Widget getSelectionSection(BuildContext context){
    final bloc = context.read<SelectQuranSectionBloc>();

    return FormBuilder(
      key: formKey,
      child: BlocBuilder<SelectQuranSectionBloc,SelectQuranSectionState>(
        builder: (context, state){
          return Column(
            children: [
              if(config.showAutoName)
                CustomFormTextField(
                  controller: nameTextController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  label: "İsim (zorunlu alan)",
                  minLines: 1,
                  maxLines: 2,
                  autoFocus: false,
                  forceCustomTrailingWidget: state.showAutoGenerateNameButton,
                  validators: [KValidate.required, KValidate.minRequire(3)],
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  trailingWidget: TextButton(
                      onPressed: (){
                        bloc.add(SelectQuranSectionEventAutoGenerateName());
                      },
                      child: const Text("Otomatik Oluştur")
                  ),
                ),
              if(config.showSelectJuz)
                CustomSearchableSelectTextMenu<Cuz>(
                  enabled: true,
                  margins: margins,
                  items: state.cuzs,
                  selectedItem: state.selectedCuz,
                  label: "Cüz Seç",
                  onSelected: (selected){
                    bloc.add(SelectQuranSectionEventSelectCuz(cuz: selected));
                  },
                ),
              if(config.showSelectSurah)
                CustomSearchableSelectTextMenu<Surah>(
                  enabled: true,
                  margins: margins,
                  items: state.surahes,
                  selectedItem: state.selectedSurah,
                  label: "Sure Seç",
                  onSelected: (selected){
                    bloc.add(SelectQuranSectionEventSelectSurah(surah: selected));
                  },
                ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if(config.showSelectFirstVerseNumber)
                      Expanded(
                        child: CustomSearchableSelectTextMenu(
                          enabled: true,
                          margins: margins,
                          items: state.verseNumbers,
                          selectedItem: state.firstSelectedVerseNumber,
                          scrollType: SearchableScrollType.navigatePosition,
                          label: config.selectFirstVerseTitle ?? "Başlangıç Ayeti Seç",
                          onSelected: (selected){
                            bloc.add(SelectQuranSectionEventSelectVerse(verseNumber: selected, isFirstField: true));
                          },
                        ),
                      ),
                    if(config.showSelectBothVerseNumbers)
                      const SizedBox(width: 8,),
                    if(config.showSelectLastVerseNumber)
                      Expanded(
                        child: CustomSearchableSelectTextMenu(
                          enabled: true,
                          margins: margins,
                          items: state.verseNumbers,
                          selectedItem: state.lastSelectedVerseNumber,
                          scrollType: SearchableScrollType.navigatePosition,
                          label: config.selectLastVerseTitle ??"Bitiş Ayeti Seç",
                          onSelected: (selected){
                            bloc.add(SelectQuranSectionEventSelectVerse(verseNumber: selected, isFirstField: false));
                          },
                        ),
                    )
                  ],
                ),
              ),
              if(config.showSelectPage)
                getAnimation(
                  child: CustomFormTextField(
                    enabled: focusPageNode.hasFocus || !state.isLoading,
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
                      bloc.add(SelectQuranSectionEventSelectPage(page: newText ?? ""));
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget getAnimation({required Widget child}){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }

  Widget getContentSection(BuildContext context){
    return BlocBuilder<SelectQuranSectionBloc,SelectQuranSectionState>(
        builder: (context, state){
          return Column(
            children: [
              if(config.showArabicContent)
                TitleSectionChild(
                  title: "Arapça İçerik",
                  expandable: true,
                  initExpand: true,
                  useDefaultColor: true,
                  useCard: true,
                  contentFontSize: FontSizeEnum.medium.size,
                  elevation: 3,
                  content: ArabicContentItem(
                    content: state.arabicContent ?? "",
                    fontSize: FontSizeEnum.medium.size,
                    fontFamily: FontFamilyArabicEnum.defaultValue,
                  )
                ),
              const SizedBox(height: 16,),
              if(config.showMeaningContent)
                TitleSectionItem(
                  title: "Anlamı",
                  expandable: true,
                  initExpand: true,
                  useDefaultColor: true,
                  useCard: true,
                  contentFontSize: FontSizeEnum.medium.size,
                  elevation: 3,
                  content: state.meaningContent ?? ""
                ),
            ],
          );
        }
    );
  }

  Widget getListeners({required Widget child}){
    final bloc = context.read<SelectQuranSectionBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<SelectQuranSectionBloc,SelectQuranSectionState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context,state){
            final message = state.message;
            if(message != null){
              bloc.add(SelectQuranSectionEventClearMessage());
              ToastUtils.showLongToast(message);
            }
          },
        ),
        BlocListener<SelectQuranSectionBloc,SelectQuranSectionState>(
          listenWhen: (prevState, nextState){
            return prevState.page != nextState.page;
          },
          listener: (context, state){
            textPageEditingController.setTextWithCursor(state.page.toString());
          }
        ),
        BlocListener<SelectQuranSectionBloc,SelectQuranSectionState>(
          listenWhen: (prevState, nextState){
            return prevState.result != nextState.result;
          },
          listener: (context, state){
            final selectResult = state.result;

            if(selectResult != null){
              bloc.add(SelectQuranSectionEventClearResult());
              context.pop();
              widget.onSubmit?.call(selectResult);
            }
          },
        ),
        BlocListener<SelectQuranSectionBloc,SelectQuranSectionState>(
          listenWhen: (prevState, nextState){
            return prevState.generatedName != nextState.generatedName;
          },
          listener: (context,state){
            final generatedName = state.generatedName;
            if(generatedName != null){
              bloc.add(SelectQuranSectionEventClearSetName());
              nameTextController.text = generatedName;
            }
          },
        )
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    nameTextController.dispose();
    textPageEditingController.dispose();
    super.dispose();
  }
}