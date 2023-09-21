

import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';
import 'package:hadith/core/domain/repo/downloaded_audio_view_repo.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:collection/collection.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';
import 'package:rxdart/rxdart.dart';

class VerseTopicGetDownloadedModelsUseCase{

  late final DownloadedAudioViewRepo _downloadedAudioViewRepo;
  late final EditionRepo _editionRepo;

  VerseTopicGetDownloadedModelsUseCase({
    required DownloadedAudioViewRepo downloadedAudioViewRepo,
    required EditionRepo editionRepo
  }){
    _downloadedAudioViewRepo = downloadedAudioViewRepo;
    _editionRepo = editionRepo;
  }

  Stream<List<VerseTopicModel<T>>> call<T>({
    required Stream<List<T>> dataSource,
    required int Function(T data) selectKey,
    required DownloadedAudioViewEnum viewEnum
  }){
    final audioViewStream = _editionRepo.getSelectedStreamEdition().switchMap((audioEdition){
      if(audioEdition == null) return Stream.value(<DownloadedAudioViewModel>[]);
      return _downloadedAudioViewRepo.getStreamModels(
          identifier: audioEdition.identifier,
          audioEnumView: viewEnum
      );
    });

    return Rx.combineLatest2(audioViewStream, dataSource, (audioViews, items){
      final models = <VerseTopicModel<T>>[];
      for(final item in items){
        final audioView = audioViews.firstWhereOrNull((e) => e.itemId == selectKey(item));
        models.add(VerseTopicModel<T>(data: item, audioViewModel: audioView));
      }
      return models;
    });
  }
}