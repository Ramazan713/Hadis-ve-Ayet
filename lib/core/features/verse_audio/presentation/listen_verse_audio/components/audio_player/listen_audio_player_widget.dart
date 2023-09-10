import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/components/audio_player/audio_player_content_widget.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';

class ListenAudioPlayerWidget extends StatelessWidget {
  final SavePointDestination destination;

  const ListenAudioPlayerWidget({
    Key? key,
    required this.destination
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocSelector<ListenVerseAudioBloc,ListenVerseAudioState,_PlayerStateData>(
        selector: (state){
          return _PlayerStateData(currentSavePointId: state.currentSavePointId, showAudioPlayerWidget: state.showAudioPlayerWidget);
        },
        builder: (context,data){

          return CustomAnimatedSwitcher(
              firstChild: AudioPlayerContentWidget(
                onSavePointClick: (){
                  showEditSavePointsDiaGetApprovedSavePoint(
                      context,
                      destination: destination,
                      itemIndexPos: 0,
                      title: "Kayıt Noktası Seç",
                      description: "Dinleme sonrasında otomatik olarak kaydedilmesi için bir kayıt noktası seçiniz",
                      selectedSavePointId: data.currentSavePointId,
                      onSelectedSavePoint: (selectedSavePoint){
                        context.read<ListenVerseAudioBloc>()
                            .add(ListenAudioEventSetSavePointId(savepointId: selectedSavePoint.id));
                      }
                  );
                },
              ),
              secondChild: const SizedBox(),
              showFirstChild: data.showAudioPlayerWidget
          );
        }
    );
  }
}


class _PlayerStateData extends Equatable{
  final int? currentSavePointId;
  final bool showAudioPlayerWidget;

  const _PlayerStateData({required this.currentSavePointId, required this.showAudioPlayerWidget});

  @override
  List<Object?> get props => [currentSavePointId, showAudioPlayerWidget];
}