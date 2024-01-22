import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/constants/k_validators.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';
import 'package:hadith/core/domain/enums/searchable_scroll_type.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/presentation/components/shared_header.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/core/presentation/selections/custom_searchable_select_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/create_quran_prayer/bloc/create_quran_prayer_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/create_quran_prayer/bloc/create_quran_prayer_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/create_quran_prayer/bloc/create_quran_prayer_state.dart';

void showCreateQuranPrayerDia(BuildContext context){
  showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return const Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 8),
          child: _DialogContent(),
        );
      });
}


class _DialogContent extends StatefulWidget {
  const _DialogContent({super.key});

  @override
  State<_DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  final formKey = GlobalKey<FormBuilderState>();

  final TextEditingController nameTextController = TextEditingController();

  EdgeInsets get margins => const EdgeInsets.symmetric(vertical: 8);

  @override
  void initState() {
    super.initState();
    final bloc = context.read<CreateQuranPrayerBloc>();
    nameTextController.addListener(() {
      bloc.add(CreateQuranPrayerEventCheckAutoGenerateName(text: nameTextController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
        child: BlocBuilder<CreateQuranPrayerBloc,CreateQuranPrayerState>(
          builder: (context, state){
            return IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SharedHeader(
                    title: "Kurandan Ekle",
                    onClose: () {
                      context.pop();
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          getSelectionSection(context),
                          getContentSection(context),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  getSaveButton(context)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getSaveButton(BuildContext context){
    final bloc = context.read<CreateQuranPrayerBloc>();
    return FilledButton(
      child: const Text("Oluştur"),
      onPressed: (){
        formKey.currentState?.validate();
        if(formKey.currentState?.isValid == true){
          bloc.add(CreateQuranPrayerEventInsert(name: nameTextController.text));
        }
      },
    );
  }

  Widget getSelectionSection(BuildContext context){
    final bloc = context.read<CreateQuranPrayerBloc>();

    return FormBuilder(
      key: formKey,
      child: BlocBuilder<CreateQuranPrayerBloc,CreateQuranPrayerState>(
        builder: (context, state){
          return Column(
            children: [
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
                      bloc.add(CreateQuranPrayerEventAutoGenerateName());
                    },
                    child: const Text("Otomatik Oluştur")
                ),
              ),
              CustomSearchableSelectTextMenu<Cuz>(
                enabled: true,
                margins: margins,
                items: state.cuzs,
                selectedItem: state.selectedCuz,
                label: "Cüz Seç",
                onSelected: (selected){
                  bloc.add(CreateQuranPrayerEventSelectCuz(cuz: selected));
                },
              ),
              CustomSearchableSelectTextMenu<Surah>(
                enabled: true,
                margins: margins,
                items: state.surahes,
                selectedItem: state.selectedSurah,
                label: "Sure Seç",
                onSelected: (selected){
                  bloc.add(CreateQuranPrayerEventSelectSurah(surah: selected));
                },
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CustomSearchableSelectTextMenu(
                        enabled: true,
                        margins: margins,
                        items: state.verseNumbers,
                        selectedItem: state.firstSelectedVerseNumber,
                        scrollType: SearchableScrollType.navigatePosition,
                        label: "Başlangıç Ayeti Seç",
                        onSelected: (selected){
                          bloc.add(CreateQuranPrayerEventSelectVerse(verseNumber: selected, isFirstField: true));
                        },
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: CustomSearchableSelectTextMenu(
                        enabled: true,
                        margins: margins,
                        items: state.verseNumbers,
                        selectedItem: state.lastSelectedVerseNumber,
                        scrollType: SearchableScrollType.navigatePosition,
                        label: "Bitiş Ayeti Seç",
                        onSelected: (selected){
                          bloc.add(CreateQuranPrayerEventSelectVerse(verseNumber: selected, isFirstField: false));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getContentSection(BuildContext context){
    return BlocBuilder<CreateQuranPrayerBloc,CreateQuranPrayerState>(
        builder: (context, state){
          return Column(
            children: [
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
    final bloc = context.read<CreateQuranPrayerBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateQuranPrayerBloc,CreateQuranPrayerState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context,state){
            final message = state.message;
            if(message != null){
              bloc.add(CreateQuranPrayerEventClearMessage());
              ToastUtils.showLongToast(message);
            }
          },
        ),
        BlocListener<CreateQuranPrayerBloc,CreateQuranPrayerState>(
          listenWhen: (prevState, nextState){
            return prevState.navigateBack != nextState.navigateBack;
          },
          listener: (context,state){
            final navigateBack = state.navigateBack;
            if(navigateBack){
              bloc.add(CreateQuranPrayerEventClearNavigateBack());
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<CreateQuranPrayerBloc,CreateQuranPrayerState>(
          listenWhen: (prevState, nextState){
            return prevState.generatedName != nextState.generatedName;
          },
          listener: (context,state){
            final generatedName = state.generatedName;
            if(generatedName != null){
              bloc.add(CreateQuranPrayerEventClearSetName());
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
    super.dispose();
  }
}