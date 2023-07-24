

import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';

abstract class VerseMealVoiceRepo{

  Future<List<VerseMealVoiceModel>> getVerseVoiceModels(ListenAudioParam listenAudioParam);
}