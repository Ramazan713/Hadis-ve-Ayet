

import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';

abstract class DownloadedAudioViewRepo{

  Stream<List<DownloadedAudioViewModel>> getStreamModels({
    required String? identifier,
    required DownloadedAudioViewEnum audioEnumView
  });

  Future<void> deleteAudios(DownloadedAudioViewModel model);
}