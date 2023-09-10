


import 'package:hadith/core/data/local/entities/verse_audio_entity.dart';
import 'package:hadith/core/data/local/entities/views/cuz_audio_view.dart';
import 'package:hadith/core/data/local/entities/views/surah_audio_view.dart';
import 'package:hadith/core/data/local/services/audio_view_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_audio_dao.dart';
import 'package:hadith/core/domain/services/file_service.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';
import 'package:hadith/core/domain/repo/downloaded_audio_view_repo.dart';
import 'package:hadith/core/features/verse_audio/data/mapper/download_audio_view_mapper.dart';

class DownloadedAudioViewRepoImpl extends DownloadedAudioViewRepo{

  late final AudioViewDao _audioViewDao;
  late final VerseAudioDao _verseAudioDao;
  late final FileService _fileService;

  DownloadedAudioViewRepoImpl({
    required AudioViewDao audioViewDao,
    required VerseAudioDao verseAudioDao,
    required FileService fileService
  }){
    _audioViewDao = audioViewDao;
    _verseAudioDao = verseAudioDao;
    _fileService = fileService;
  }

  @override
  Stream<List<DownloadedAudioViewModel>> getStreamModels({
    required String? identifier,
    required DownloadedAudioViewEnum audioEnumView
  }) {
    switch(audioEnumView){
      case DownloadedAudioViewEnum.surah:
        return _getModelsFromSurahViews(identifier);
      case DownloadedAudioViewEnum.cuz:
        return _getModelsFromCuzViews(identifier);
    }
  }

  @override
  Future<void> deleteAudios(DownloadedAudioViewModel model) async{

    final List<VerseAudioEntity> audios;

    switch(model.audioEnum){
      case DownloadedAudioViewEnum.surah:
        audios = await _verseAudioDao.getAllVerseAudioWithSurahId(model.itemId, model.identifier);
        break;
      case DownloadedAudioViewEnum.cuz:
        audios = await _verseAudioDao.getAllVerseAudioWithCuzNo(model.itemId, model.identifier);
        break;
    }

    final fileNames = audios.map((e) => e.fileName ?? "").toList();

    await _fileService.deleteFilesWithFileNames(fileNames);
    await _verseAudioDao.deleteVerseAudios(audios);
  }


  Stream<List<DownloadedAudioViewModel>> _getModelsFromSurahViews(String? identifier){
    final Stream<List<SurahAudioView>> models;
    if(identifier!=null){
      models = _audioViewDao.getStreamSurahAudioViewsWithIdentifier(identifier);
    }else{
      models = _audioViewDao.getStreamSurahAudioViews();
    }
    return models.map((items) => items.map((e) => e.toAudioModel()).toList());
  }

  Stream<List<DownloadedAudioViewModel>> _getModelsFromCuzViews(String? identifier){
    final Stream<List<CuzAudioView>> models;
    if(identifier!=null){
      models = _audioViewDao.getStreamCuzAudioViewsWithIdentifier(identifier);
    }else{
      models = _audioViewDao.getStreamCuzAudioViews();
    }
    return models.map((items) => items.map((e) => e.toAudioModel()).toList());
  }




}