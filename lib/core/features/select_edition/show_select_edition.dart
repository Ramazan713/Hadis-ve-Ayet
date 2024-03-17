import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_event.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_state.dart';
import 'package:hadith/core/features/select_edition/components/select_edition_item.dart';
import 'package:hadith/core/features/select_edition/models/select_audio_edition.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_config/select_quran_section_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/presentation/show_select_quran_section_dia.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/presentation/components/base_expandable_item.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
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
                          selectQuranSection(context, state),
                          const SizedBox(height: 16,),
                          getFavoriteSection(context, state),
                          const SizedBox(height: 32,),
                          getBody(context, state, state.items)
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

  Widget selectQuranSection(BuildContext context, SelectEditionState state){
    final bloc = context.read<SelectEditionBloc>();
    return CardListTile(
      onTap: (){
        showSelectQuranSectionDia(
          context: context,
          config: const SelectQuranSectionConfig(
            showSelectSurah: true,
            showSelectFirstVerseNumber: true,
            showSelectLastVerseNumber: true,
            showSelectJuz: true,
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
    );
  }


  Widget getFavoriteSection(BuildContext context, SelectEditionState state){
    return BaseExpandableItem(
      buildHeader: (context, isExpanded){
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 12),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               "Favoriler",
               style: Theme.of(context).textTheme.titleMedium,
             ),
             Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down)
           ],
         ),
       );
      },
      buildContent: (context, isExpanded){
        final items = state.favoriteItems.toList();
        if(items.isEmpty){
          return const SharedEmptyResult(
            content: "Favoriler boş",
            textAlign: TextAlign.start,
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemBuilder: (context, index) {
            final item = items[index];
            return SelectEditionItem(
              edition: item,
              selectedSelectEdition: state.selectedEdition,
              audioRequest: state.audioRequest,
              isFavorite: item.isSelected,
            );
          },
          itemCount: items.length,
        );;
      },
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

  Widget getBody(BuildContext context, SelectEditionState state, List<SelectAudioEdition> items){
    return BaseExpandableItem(
      initialValue: true,
      enabledExpandable: false,
      buildHeader: (context, isExpanded){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Kıraatlar",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
      buildContent: (context, isExpanded){
        final items = state.items.toList();
        return ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemBuilder: (context, index) {
            final item = items[index];
            return SelectEditionItem(
              edition: item,
              selectedSelectEdition: state.selectedEdition,
              audioRequest: state.audioRequest,
              isFavorite: item.isSelected,
            );
          },
          itemCount: items.length,
        );
      },
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


