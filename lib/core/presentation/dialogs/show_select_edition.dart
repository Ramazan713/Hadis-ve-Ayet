import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/select_edition/components/select_edition_item.dart';
import 'package:hadith/core/presentation/components/dropdown_text_menu.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/core/presentation/dialogs/show_manage_edition_audios.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_event.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_state.dart';
import 'package:hadith/utils/toast_utils.dart';

void showSelectEdition(BuildContext context) {

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return DraggableScrollableSheet(
          minChildSize: 0.5,
          initialChildSize: 0.7,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollControllerDraggable) {
            return _DialogContent(
              scrollController: scrollControllerDraggable,
            );
          },
        );
      }).then((value) {
    context.read<BasicAudioBloc>().add(BasicAudioEventStopListening());
  });
}


class _DialogContent extends StatelessWidget {

  final ScrollController scrollController;

  const _DialogContent({
    Key? key,
    required this.scrollController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<SelectEditionBloc>()
        .add(EditionEventLoadInit());

    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeader(context),
            
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getDropdown(context),
                    const SizedBox(height: 8,),
                    getBody()
                  ],
                ),
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

  Widget getDropdown(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: BlocSelector<SelectEditionBloc, SelectEditionState, AudioQualityEnum>(
        selector: (state) => state.selectedQuality,
        builder: (context, audioQuality) {
          return CustomDropdownTextMenu(
            items: AudioQualityEnum.values,
            selectedItem: audioQuality,
            onSelected: (selected){
              if(selected!=null){
                context.read<SelectEditionBloc>()
                    .add(EditionEventSetQuality(audioQuality: selected));
              }
            },
          );
        },
      ),
    );
  }

  Widget getBody(){
    return BlocBuilder<SelectEditionBloc, SelectEditionState>(
        builder: (context, state) {
          final items = state.items;
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (items.isEmpty) {
            return const Text("Boş");
          }
          return ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemBuilder: (context, index) {
              final item = items[index];
              return SelectEditionItem(
                edition: item,
                audioQuality: state.selectedQuality,
                selectedEdition: state.selectedEdition,
                onNextClick: (){
                  showManageEditionAudios(context, audioEdition: item);
                },
                onSelectClick: (){
                  context.read<SelectEditionBloc>()
                      .add(EditionEventSetEdition(edition: item)
                  );
                },
              );
            },
            itemCount: state.items.length,
          );
        });
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


