

import 'package:hadith/core/data/local/entities/verse_audio_entity.dart';
import 'package:hadith/core/data/local/services/verse/verse_audio_dao.dart';
import 'package:hadith/core/domain/services/file_service.dart';
import 'package:hadith/core/features/verse_audio/data/mapper/verse_audio_mapper.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/core/features/verse_audio/domain/model/verse_audio.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_audio_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/services/audio_file_editor.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

class VerseAudioRepoImpl extends VerseAudioRepo{

  late final VerseAudioDao _verseAudioDao;
  late final FileService _fileService;
  late final AudioFileEditor _audioFileEditor;


  VerseAudioRepoImpl({
    required VerseAudioDao verseAudioDao,
    required FileService fileService,
    required AudioFileEditor audioFileEditor
  }){
    _verseAudioDao = verseAudioDao;
    _fileService = fileService;
    _audioFileEditor = audioFileEditor;
  }

  @override
  Future<void> updateVerseAudios(List<VerseAudio> verseAudios) async{
    await _verseAudioDao.updateVerseAudios(verseAudios.map((e) => e.toVerseAudioEntity()).toList());
  }

  @override
  Future<bool> hasVerseAudiosWithIds({
    required List<int> verseIds,
    required String identifier
  })async{
    return (await _verseAudioDao.hasVerseAudiosWithMealIdList(verseIds, identifier)) ?? false;
  }

  @override
  Future<bool> hasVerseAudios(ListenAudioParam listenAudioParam) async{

    final itemId = listenAudioParam.itemId;
    final identifier = listenAudioParam.identifier;
    final startVerseId = listenAudioParam.startVerseId;

    if(startVerseId!=null){
      switch(listenAudioParam.op){
        case QuranAudioOption.cuz:
          return (await _verseAudioDao.hasVerseAudiosWithCuzNoAndStartVerseId(itemId, identifier,startVerseId)) ?? false;
        case QuranAudioOption.surah:
          return (await _verseAudioDao.hasVerseAudiosWithSurahIdAndStartVerseId(itemId, identifier,startVerseId)) ?? false;
        case QuranAudioOption.page:
          return (await _verseAudioDao.hasVerseAudiosWithPageNoAndStartVerseId(itemId, identifier,startVerseId)) ?? false;
        case QuranAudioOption.verse:
          return (await _verseAudioDao.hasVerseAudiosWithMealId(itemId, identifier)) ?? false;
      }
    }else{
      switch(listenAudioParam.op){
        case QuranAudioOption.cuz:
          return (await _verseAudioDao.hasVerseAudiosWithCuzNo(itemId, identifier)) ?? false;
        case QuranAudioOption.surah:
          return (await _verseAudioDao.hasVerseAudiosWithSurahId(itemId, identifier)) ?? false;
        case QuranAudioOption.page:
          return (await _verseAudioDao.hasVerseAudiosWithPageNo(itemId, identifier)) ?? false;
        case QuranAudioOption.verse:
          return (await _verseAudioDao.hasVerseAudiosWithMealId(itemId, identifier)) ?? false;
      }
    }


  }


  @override
  Future<void> createVerseAudioAndFile({
    required int mealId,
    required String identifier,
    required List<int> bytes,
    bool hasEdited = false
  }) async{

    final newFileName = VerseAudio.newFileName(identifier, mealId);
    final arabicAudio = VerseAudio(mealId: mealId, identifier: identifier, fileName: newFileName, hasEdited: hasEdited);

    await _verseAudioDao.insertVerseAudio(arabicAudio.toVerseAudioEntity());
    await _fileService.writeFile(bytes, newFileName);
  }

  @override
  Future<void> deleteVerseAudiosAndFiles({required List<VerseAudio> verseAudios}) async{
    final fileNames = verseAudios.map((e) => e.fileName??"").toList();

    await _fileService.deleteFilesWithFileNames(fileNames);
    await _verseAudioDao.deleteVerseAudios(verseAudios.map((e) => e.toVerseAudioEntity()).toList());
  }

  @override
  Future<bool> validateVerseAudios({required List<VerseMealVoiceModel> verseAudios}) async{

    bool anyMissing=false;

    final fileNames = verseAudios.map((e) => e.fileName??"").toList();
    final files = await _fileService.getFilesFromFileNames(fileNames);

    for(var i = 0; i < verseAudios.length; i++){
      final file = files[i];
      final model = verseAudios[i];
      if(!file.existsSync()){
        await _verseAudioDao.deleteVerseAudioWithQuery(model.identifier, model.mealId);
        anyMissing=true;
      }
    }

    return !anyMissing;
  }


  @override
  Future<void> editUnEditedAudios(ListenAudioParam param)async{
    final List<VerseAudioEntity> unEditedAudios;
    final itemId = param.itemId;
    final identifier = param.identifier;

    switch(param.op){
      case QuranAudioOption.verse:
        unEditedAudios = await _verseAudioDao.getUnEditedVerseAudiosWithMealId(itemId, identifier);
        break;
      case QuranAudioOption.page:
        unEditedAudios = await _verseAudioDao.getUnEditedVerseAudiosWithPageNo(itemId, identifier);
        break;
      case QuranAudioOption.surah:
        unEditedAudios = await _verseAudioDao.getUnEditedVerseAudiosWithSurahId(itemId, identifier);
        break;
      case QuranAudioOption.cuz:
        unEditedAudios = await _verseAudioDao.getUnEditedVerseAudiosWithCuzNo(itemId, identifier);
        break;
    }

    final files = await _fileService.getFilesFromFileNames(unEditedAudios.map((e) => e.fileName??"").toList());

    await _audioFileEditor.editAudioFiles(files);

    final updateAudios = unEditedAudios.map((e) => e.toVerseAudio(hasEdited: true)).map((e) => e.toVerseAudioEntity()).toList();
    await _verseAudioDao.updateVerseAudios(updateAudios);
  }


}