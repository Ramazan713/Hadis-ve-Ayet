


import 'package:hadith/db/entities/verse_audio.dart';
import 'package:hadith/db/services/cuz_dao.dart';
import 'package:hadith/db/services/manage_audio_dao.dart';
import 'package:hadith/db/services/surah_dao.dart';
import 'package:hadith/db/services/verse_audio_dao.dart';
import 'package:hadith/features/verse/common_services/file_service.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';


class ManageAudioRepo{

  late final ManageAudioDao _manageAudioDao;
  late final CuzDao _cuzDao;
  late final SurahDao _surahDao;
  late final FileService _fileService;
  late final VerseAudioDao _verseAudioDao;

  ManageAudioRepo({required ManageAudioDao manageAudioDao,required CuzDao cuzDao,required SurahDao surahDao,
    required FileService fileService,required VerseAudioDao verseAudioDao}){
    _manageAudioDao = manageAudioDao;
    _cuzDao = cuzDao;
    _surahDao = surahDao;
    _fileService = fileService;
    _verseAudioDao = verseAudioDao;
  }

  Stream<List<ManageAudioModel>> getAudioManageModels(String identifier)async*{
    final cuzs = await _cuzDao.getAllCuz();
    final surahs = await _surahDao.getAllSurah();
    final surahManageStream = _manageAudioDao.getStreamSurahAudioViews(identifier)
        .map((surahViewList) => surahViewList.map((surahView){
          final surah = surahs.firstWhere((element) => element.id == surahView.surahId);
          return ManageAudioModel.fromSurahAudioView(surahView, surah.name);
    }).toList());
    final cuzManageStream = _manageAudioDao.getStreamCuzAudioViews(identifier)
        .map((cuzViewList) => cuzViewList.map((cuzView){
        final cuz = cuzs.firstWhere((element) => element.cuzNo == cuzView.cuzNo);
        return ManageAudioModel.fromCuzAudioView(cuzView, cuz.name);
    }).toList());

    yield* Rx.combineLatest<List<ManageAudioModel>,List<ManageAudioModel>>([surahManageStream,cuzManageStream],(list)=>list.reduce((value, element){
      value.addAll(element);
      return value;
    }));
  }


  Future<void>deleteAudios(ManageAudioModel audioModel)async{
    final List<VerseAudio> verseAudios;
    switch(audioModel.manageEnum){
      case AudioManageEnum.surah:
        verseAudios = await _verseAudioDao.getVerseAudiosWithSurahId(audioModel.key, audioModel.identifier);
        break;
      case AudioManageEnum.cuz:
        verseAudios = await _verseAudioDao.getVerseAudiosWithCuzNo(audioModel.key, audioModel.identifier);
        break;
    }

    final appDocDir = await VerseAudio.appDocDirPath();
    final files = verseAudios.map((e) => VerseAudio.getAudioFileWithDir(appDocDir, e.fileName??"")).toList();
    await _fileService.deleteFiles(files);
    await _verseAudioDao.deleteVerseAudios(verseAudios);
  }


}