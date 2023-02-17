import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/common_components/icon_play_audio.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/features/verse/edition_bloc/edition_bloc.dart';
import 'package:hadith/features/verse/edition_bloc/edition_event.dart';
import 'package:hadith/features/verse/edition_bloc/edition_state.dart';
import 'package:hadith/features/verse/manage_audios/show_manage_audios.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_state.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showSelectEdition(BuildContext context) {
  final editionBloc = context.read<EditionBloc>();
  editionBloc.add(EditionEventSetInit());


  void setSelectionFunc(String identifier) {
    editionBloc.add(EditionEventSetSelected(identifier: identifier));
  }

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<BasicAudioBloc, BasicAudioState>(
                listener: (context, state) {
              if (state.message != null) {
                ToastUtils.showLongToast(state.message ?? "");
              }
            }),
            BlocListener<EditionBloc, EditionState>(
                listener: (context, state) {
                  if (state.message != null) {
                    ToastUtils.showLongToast(state.message ?? "");
                  }
                },
            )
          ],
          child: DraggableScrollableSheet(
            minChildSize: 0.2,
            initialChildSize: 0.5,
            maxChildSize: 1.0,
            expand: false,
            builder: (context, scrollControllerDraggable) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: BlocSelector<EditionBloc, EditionState,
                            AudioQualityEnum>(
                          selector: (state) => state.lastAudioQuality,
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
                                  editionBloc.add(EditionEventSetQuality(
                                      audioQuality: selected));
                                }
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<EditionBloc, EditionState>(
                        builder: (context, state) {
                      final items = state.filteredItems;
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
                                setSelectionFunc(item.identifier);
                              },
                              child: Row(
                                children: [
                                  Radio<String>(
                                      value: item.identifier,
                                      groupValue: state
                                          .lastSelectedEdition?.identifier,
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          setSelectionFunc(newValue);
                                        }
                                      }),
                                  Expanded(child: Text(item.name)),
                                  IconPlayAudio(
                                    identifier: item.identifier,
                                    audioQuality: state.lastAudioQuality,
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        showManageAudios(context,
                                            edition: item);
                                      },
                                      icon: const Icon(Icons.arrow_forward)),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.filteredItems.length,
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: BlocSelector<EditionBloc, EditionState, bool>(
                          selector: (state) => state.resetButtonEnabled,
                          builder: (context, buttonEnabled) {
                            return CustomButtonPositive(
                              enabled: buttonEnabled,
                              onTap: () {
                                editionBloc.add(EditionEventReset());
                              },
                              label: "Değişiklikleri geri al",
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: BlocSelector<EditionBloc, EditionState, bool>(
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
                  )
                ],
              );
            },
          ),
        );
      }).then((value) {
    context.read<BasicAudioBloc>().add(BasicAudioEventStopListening());
  });
}
