import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/play_basic_audio.dart';
import 'package:hadith/core/presentation/dialogs/show_manage_edition_audios.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_event.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_state.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showSelectEdition(BuildContext context) {
  final editionBloc = context.read<SelectEditionBloc>();
  editionBloc.add(EditionEventLoadInit());

  void setSelectionFunc(AudioEdition edition) {
    editionBloc.add(EditionEventSetEdition(edition: edition));
  }

  Widget getDropdown(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: BlocSelector<SelectEditionBloc, SelectEditionState, AudioQualityEnum>(
        selector: (state) => state.selectedQuality,
        builder: (context, audioQuality) {
          return DropdownButton<AudioQualityEnum>(
            value: audioQuality,
            items: AudioQualityEnum.values.map((e) {
              return DropdownMenuItem<AudioQualityEnum>(
                value: e,
                child: Text("Bitrate: ${e.quality}"),
              );
            }).toList(),
            onChanged: (selected) {
              if (selected != null) {
                editionBloc.add(EditionEventSetQuality(audioQuality: selected));
              }
            },
          );
        },
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getDropdown(context),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
    );
  }

  Widget getBody(ScrollController scrollControllerDraggable){
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
            controller: scrollControllerDraggable,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                margin: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(13),
                  onTap: () {
                    setSelectionFunc(item);
                  },
                  child: Row(
                    children: [
                      Radio<AudioEdition>(
                          value: item,
                          groupValue: state.selectedEdition,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setSelectionFunc(newValue);
                            }
                          }),
                      Expanded(child: Text(item.name)),
                      PlayBasicAudio(
                        identifier: item.identifier,
                        audioQuality: state.selectedQuality,
                      ),
                      IconButton(
                        onPressed: () async {
                          showManageEditionAudios(context, audioEdition: item);
                        },
                        icon: const Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.items.length,
          );
        });
  }

  Widget getBottomButtons(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 4,
          child: BlocSelector<SelectEditionBloc, SelectEditionState, bool>(
            selector: (state) => state.resetButtonEnabled,
            builder: (context, buttonEnabled) {
              return CustomButtonPositive(
                enabled: buttonEnabled,
                onTap: () {
                  editionBloc.add(EditionEventResetChanges());
                },
                label: "Değişiklikleri geri al",
              );
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: BlocSelector<SelectEditionBloc, SelectEditionState, bool>(
            selector: (state) => state.saveButtonEnabled,
            builder: (context, buttonEnabled) {
              return CustomButtonPositive(
                enabled: buttonEnabled,
                onTap: () {
                  editionBloc.add(EditionEventSave());
                },
                label: "Kaydet",
              );
            },
          ),
        ),
      ],
    );
  }

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<BasicAudioBloc, BasicAudioState>(
                listener: (context, state) {
                  if (state.message != null) {
                    ToastUtils.showLongToast(state.message ?? "");
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
                  editionBloc.add(EditionEventClearMessage());
                }
              },
            )
          ],
          child: DraggableScrollableSheet(
            minChildSize: 0.4,
            initialChildSize: 0.5,
            maxChildSize: 1.0,
            expand: false,
            builder: (context, scrollControllerDraggable) {
              return SafeArea(
                child: Column(
                  children: [
                    getHeader(context),
                    Expanded(
                      child: getBody(scrollControllerDraggable),
                    ),
                    getBottomButtons(context)
                  ],
                ),
              );
            },
          ),
        );
      }).then((value) {
    context.read<BasicAudioBloc>().add(BasicAudioEventStopListening());
  });
}
