
import 'package:collection/collection.dart';
import 'package:hadith/core/data/local/entities/verse_arabic_entity.dart';
import 'package:hadith/core/data/local/services/verse/verse_arabic_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_dao.dart';
import 'package:hadith/core/data/repo/verse/get_verses.dart';
import 'package:hadith/core/constants/k_verse.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_downloaded_voice_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

class VerseDownloadedVoiceRepoImpl extends VerseDownloadedVoiceRepo{
  late final VerseArabicDao _verseArabicDao;
  late final VerseDao _verseDao;
  late final GetVerses _getVerses;

  VerseDownloadedVoiceRepoImpl({
    required VerseArabicDao verseArabicDao,
    required VerseDao verseDao,
    required GetVerses getVerses,
  }){
    _verseArabicDao = verseArabicDao;
    _verseDao = verseDao;
    _getVerses = getVerses;
  }

  Future<List<VerseDownloadedVoiceModel>> getNotDownloadedAudioVersesWithIds({
    required List<int> verseIds,
    required String identifier,
  })async{
    final verseArabicEntities = await _verseArabicDao.getAllNotDownloadedVerseArabicsWithMealIdList(verseIds, identifier);
    return _getModels(verseArabicEntities);
  }

  Future<List<List<VerseDownloadedVoiceModel>>> getNotDownloadedAudioVersesWithGroupByMealIds({
    required List<int> verseIds,
    required String identifier,
    bool addMention = true
  })async{
    final models = await getNotDownloadedAudioVersesWithIds(verseIds: verseIds, identifier: identifier);
    return _groupByModels(models, addMention: addMention);
  }



  @override
  Future<List<VerseDownloadedVoiceModel>> getNotDownloadedAudioVerses({
    required int itemId,
    required QuranAudioOption op,
    required String identifier,
    int? startVerseId
  }) async{

    List<VerseArabicEntity> verseArabicEntities = await _getEntities(
        itemId: itemId, option: op, identifier: identifier
    );
    if(startVerseId!=null){
      final currentIndex = verseArabicEntities.indexWhere((element) => element.mealId == startVerseId);
      if(currentIndex!=-1){
        verseArabicEntities = verseArabicEntities.sublist(currentIndex,verseArabicEntities.length);
      }
    }
    return _getModels(verseArabicEntities);
  }






  @override
  Future<List<List<VerseDownloadedVoiceModel>>> getNotDownloadedAudioVersesWithGroupByMealId({
    required int itemId,
    required QuranAudioOption op,
    required String identifier,
    int? startVerseId,
    bool addMention = true
  }) async{
    final models = await getNotDownloadedAudioVerses(itemId: itemId, op: op, identifier: identifier,startVerseId: startVerseId);
    return _groupByModels(models, addMention: addMention);
  }

  List<List<VerseDownloadedVoiceModel>> _groupByModels(List<VerseDownloadedVoiceModel> models,{required bool addMention}){
    List<List<VerseDownloadedVoiceModel>> results = [];
    List<VerseDownloadedVoiceModel> tempArr = [];

    if(models.isEmpty){
      return results;
    }
    int mealId = models[0].mealId;
    for (var model in models){
      if(mealId!=model.mealId){
        results.add(tempArr);
        tempArr = [];
        mealId = model.mealId;
      }
      if(model.verseNumberTr == 1 && addMention && !KVerse.mentionExclusiveIds.contains(model.surahId)){
        final newModel = model.copyWith(verseNumberTr: 0,surahId: 1,verseId: 1);
        tempArr.add(newModel);
      }
      tempArr.add(model);
    }
    if(tempArr.isNotEmpty){
      results.add(tempArr);
    }
    return results;
  }

  Future<List<VerseDownloadedVoiceModel>> _getModels(List<VerseArabicEntity> verseArabicEntities)async{
    final verses = await _getVersesByEntities(verseArabicEntities);
    final items = <VerseDownloadedVoiceModel>[];

    for(final vae in verseArabicEntities){
      final verse = verses.firstWhereOrNull((e) => e.id == vae.mealId);
      if(verse == null) continue;

      final item = VerseDownloadedVoiceModel(
        verseId: vae.id ?? 0,
        surahId: verse.surahId,
        surahName: verse.surahName,
        mealId: vae.mealId,
        verseNumberTr: vae.verseNumberTr,
        cuzNo: verse.cuzNo,
        pageNo: verse.pageNo,
      );
      items.add(item);
    }
    return items;
  }

  Future<List<Verse>> _getVersesByEntities(List<VerseArabicEntity> entities)async{
    final mealIds = entities.map((e) => e.mealId).toList();
    final verseEntities = await _verseDao.getVersesByIds(mealIds);
    return await _getVerses.call(verseEntities);
  }


  Future<List<VerseArabicEntity>> _getEntities({
    required int itemId,
    required QuranAudioOption option,
    required String identifier,
    int? startVerseId
  })async{
    final List<VerseArabicEntity> verseArabicEntities;

    switch(option){
      case QuranAudioOption.cuz:
        if(startVerseId!=null){
          verseArabicEntities = await _verseArabicDao.getNotDownloadedVerseArabicsWithCuzNo(itemId, identifier, startVerseId);
        }else{
          verseArabicEntities = await _verseArabicDao.getAllNotDownloadedVerseArabicsWithCuzNo(itemId, identifier);
        }
        break;
      case QuranAudioOption.surah:
        if(startVerseId!=null){
          verseArabicEntities = await _verseArabicDao.getNotDownloadedVerseArabicsWithSurahId(itemId, identifier, startVerseId);
        }else{
          verseArabicEntities = await _verseArabicDao.getAllNotDownloadedVerseArabicsWithSurahId(itemId, identifier);
        }
        break;
      case QuranAudioOption.page:
        if(startVerseId!=null){
          verseArabicEntities = await _verseArabicDao.getNotDownloadedVerseArabicsWithPageNo(itemId, identifier, startVerseId);
        }else{
          verseArabicEntities = await _verseArabicDao.getAllNotDownloadedVerseArabicsWithPageNo(itemId, identifier);
        }
        break;
      case QuranAudioOption.verse:
        verseArabicEntities = await _verseArabicDao.getAllNotDownloadedVerseArabicsWithMealId(itemId, identifier);
        break;
    }

    return verseArabicEntities;
  }
}