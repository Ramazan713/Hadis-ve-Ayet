

import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/verse_meal_voice_model.dart';

abstract class VerseMealVoiceRepo{

  Future<List<VerseMealVoiceModel>> getVerseVoiceModels(ListenAudioParam listenAudioParam);

  Future<List<VerseMealVoiceModel>> getVerseVoiceModelsWithCustom({required String identifier, required List<int> verseIds});
}