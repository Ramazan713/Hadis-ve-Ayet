

import 'package:mutex/mutex.dart';
import 'package:rxdart/rxdart.dart';

import '../enums/listen_audio_enum.dart';
import 'listen_audio/listen_audio_service_state.dart';
import 'listen_audio/verse_meal_voice_model.dart';

class ListenAudioStateManager{

  final Mutex _lock = Mutex();

  ListenAudioServiceState _state = ListenAudioServiceState.init();
  final BehaviorSubject<ListenAudioServiceState> _streamResource = BehaviorSubject();

  ValueStream<ListenAudioServiceState> get stateStream => _streamResource.shareValue();
  ListenAudioServiceState get state => _state;

  void setNewState({
    ListenAudioEnum? audioEnum,
    VerseMealVoiceModel? audio,bool setAudio=false,
    Duration?duration,
    Duration?position,
    double? speed,
    bool?isLoop,
    String?error,bool setError=false,
  })async{
    await _lock.acquire();

    _state = _state.copyWith(
      audioEnum: audioEnum,
      audio: audio, setAudio: setAudio,
      duration: duration,
      position: position,
      speed: speed,
      isLoop: isLoop,
      error: error, setError: setError,
    );
    _streamResource.add(_state);

    _lock.release();
  }

  Future<void> dispose()async{
    await _streamResource.close();
  }

}