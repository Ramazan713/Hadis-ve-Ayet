import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/show_manage_edition_audios_dia.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_event.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_state.dart';
import 'package:hadith/core/features/select_edition/components/select_edition_item.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_config/select_quran_section_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/presentation/show_select_quran_section_dia.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/core/presentation/selections/dropdown_text_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';

void showSelectEdition(BuildContext context) {

  context.read<SelectEditionBloc>().add(EditionEventLoadData());

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    child: _DialogContent(
      scrollController: ScrollController(),
    ),
    bottomSheetChild: DraggableScrollableSheet(
      minChildSize: 0.5,
      initialChildSize: 0.7,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollControllerDraggable) {
        return _DialogContent(
          scrollController: scrollControllerDraggable,
        );
      },
    ),
    onClosed: (){
      context.read<BasicAudioBloc>().add(BasicAudioEventCancel());
    }
  );

}


class _DialogContent extends StatelessWidget {

  final ScrollController scrollController;

  const _DialogContent({
    super.key,
    required this.scrollController
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SelectEditionBloc>();

    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeader(context),
            
            Expanded(
              child: BlocBuilder<SelectEditionBloc, SelectEditionState>(
                builder: (context, state){
                  return StackSecondContent(
                    getSecondChild: (){
                      return getEmptyOrLoadingWidget(context, state);
                    },
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CardListTile(
                            onTap: (){
                              showSelectQuranSectionDia(
                                context: context,
                                config: const SelectQuranSectionConfig(
                                  showArabicContent: false,
                                  showMeaningContent: false,
                                  showAutoName: false,
                                  showSelectPage: false,
                                  showSelectJuz: false,
                                  title: "Kurandan Seç",
                                  btnName: "Seç"
                                ),
                                loadConfig: SelectQuranSectionLoadConfig(
                                  surahId: state.audioRequest.surahId,
                                  firstVerseNumber: state.audioRequest.startVerseId,
                                  lastVerseNumber: state.audioRequest.endVerseId
                                ),
                                onSubmit: (data){
                                  bloc.add(EditionEventSetAudioRequest(result: data));
                                }
                              );
                            },
                            title: const Text("Dinlemek için Kuran'dan bölüm seç"),
                            subtitle: Text(state.audioRequestSource),
                          ),
                          const SizedBox(height: 8,),
                          getBody(context, state)
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
            getBottomButtons(context)
          ],
        ),
      )
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          "Kıraat Seç",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)
          ),
        )
      ],
    );
  }


  Widget? getEmptyOrLoadingWidget(BuildContext context, SelectEditionState state){
    if(state.isLoading) {
      return const SharedLoadingIndicator();
    }
    final items = state.items;

    if (items.isEmpty) {
      return const SharedEmptyResult();
    }
    return null;
  }

  Widget getBody(BuildContext context, SelectEditionState state){
    final items = state.items;
    return ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(),
      itemBuilder: (context, index) {
        final item = items[index];
        return SelectEditionItem(
          edition: item,
          selectedSelectEdition: state.selectedEdition,
          onNextClick: (){
            showManageEditionAudiosDia(context, audioEdition: item.audioEdition);
          },
          onSelectClick: (){
            context.read<SelectEditionBloc>()
                .add(EditionEventSetEdition(edition: item)
            );
          },
          onPlay: (){
            context.read<BasicAudioBloc>()
              .add(BasicAudioEventRequestAudio(
                identifier: item.audioEdition.identifier,
                request: state.audioRequest,
                audioQuality: item.qualityEnum
            ));
          },
        );
      },
      itemCount: state.items.length,
    );
  }

  Widget getBottomButtons(BuildContext context){
    final bloc = context.read<SelectEditionBloc>();

    return BlocBuilder<SelectEditionBloc, SelectEditionState>(
      buildWhen: (prevState, nextState){
        return prevState.resetButtonEnabled != nextState.resetButtonEnabled ||
            prevState.saveButtonEnabled != nextState.saveButtonEnabled;
      },
      builder: (context, state){
        return SharedDiaButtons(
          enabledApprove: state.saveButtonEnabled,
          enabledCancel: state.resetButtonEnabled,
          approveLabel: "Kaydet",
          cancelLabel: "Değişiklikleri geri al",
          onApprove: (){
            bloc.add(EditionEventSave());
          },
          onCancel: (){
            bloc.add(EditionEventResetChanges());
          },
        );
      },
    );
  }

  Widget getListeners({required Widget child}){
    return MultiBlocListener(
      listeners: [
        BlocListener<BasicAudioBloc, BasicAudioState>(
            listener: (context, state) {
              final message = state.message;
              if (message != null) {
                ToastUtils.showLongToast(message);
                context.read<BasicAudioBloc>()
                    .add(BasicAudioEventClearMessage());
              }
            }),
        BlocListener<SelectEditionBloc, SelectEditionState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state) {
            final message = state.message;
            if (message != null) {
              ToastUtils.showLongToast(message);
              context.read<SelectEditionBloc>()
                  .add(EditionEventClearMessage());
            }
          },
        )
      ],
      child: child,
    );
  }

}


