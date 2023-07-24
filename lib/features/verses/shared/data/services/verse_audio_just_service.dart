
import 'dart:async';

import 'package:hadith/features/verses/shared/data/audio_players/verse_just_audio_player.dart';
import 'package:hadith/features/verses/shared/domain/enums/listen_audio_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/features/verses/shared/domain/services/i_verse_audio_service.dart';
import 'package:just_audio/just_audio.dart';

class VerseAudioJustService extends IVerseAudioService<VerseJustAudioPlayer>{

  StreamSubscription<int?>? _subsCurrentIndex;
  StreamSubscription<PlayerState>? _subsPlayerState;

  VerseAudioJustService({
    required super.verseVoiceRepo,
    required super.verseAudioRepo,
    required super.appPreferences,
    required super.fileService
  }): super(
      audioPlay: VerseJustAudioPlayer()
  );

  @override
  Future<void> play(List<VerseMealVoiceModel> items) async{
    final files = await getFiles(items);

    if(files.isNotEmpty){
      await _setListeners(items);

      await audioPlayer.setPlayList(files);
      await audioPlayer.resume();
    }
  }

  Future<void> _setListeners(List<VerseMealVoiceModel> items)async{
    await _subsCurrentIndex?.cancel();
    await _subsPlayerState?.cancel();


    _subsCurrentIndex = audioPlayer.currentIndexStream.listen((currentIndex) {
      if(currentIndex!=null){
        addState(sharedState.copyWith(
            setAudio: true, audio: items[currentIndex],
            audioEnum: ListenAudioEnum.running,
        ));
      }
    });

    _subsPlayerState = audioPlayer.playerState.listen((event) {
      if(event.processingState == ProcessingState.completed){
        addState(sharedState.copyWith(audioEnum: ListenAudioEnum.finish));
      }else if(event.processingState == ProcessingState.ready){
        addState(sharedState.copyWith(
            audioEnum: event.playing ? ListenAudioEnum.running : ListenAudioEnum.pause
        ));
      }
    });
  }


  @override
  Future<void> dispose() async{
    await _subsCurrentIndex?.cancel();
    await _subsPlayerState?.cancel();
    await super.dispose();
  }


}