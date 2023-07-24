

import 'package:hadith/core/data/local/entities/verse_audio_entity.dart';
import 'package:hadith/core/data/local/services/audio_edition_dao.dart';
import 'package:hadith/core/data/local/services/cuz_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_audio_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_dao.dart';
import 'package:hadith/core/data/repo/verse/get_verses.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_meal_voice_repo.dart';
import 'package:collection/collection.dart';

class VerseMealVoiceRepoImpl extends VerseMealVoiceRepo{
  late final VerseAudioDao _verseAudioDao;
  late final VerseDao _verseDao;
  late final GetVerses _getVerses;
  late final AudioEditionDao _editionDao;
  late final CuzDao _cuzDao;

  VerseMealVoiceRepoImpl({
    required VerseAudioDao verseAudioDao,
    required VerseDao verseDao,
    required GetVerses getVerses,
    required AudioEditionDao editionDao,
    required CuzDao cuzDao
  }){
    _verseAudioDao = verseAudioDao;
    _verseDao = verseDao;
    _getVerses = getVerses;
    _editionDao = editionDao;
    _cuzDao = cuzDao;
  }

  @override
  Future<List<VerseMealVoiceModel>> getVerseVoiceModels(ListenAudioParam listenAudioParam) async{

    List<VerseAudioEntity> verseAudioEntities = await _getEntities(listenAudioParam);

    final startVerseId = listenAudioParam.startVerseId;
    if(startVerseId!=null){
      final initialIndex = verseAudioEntities.indexWhere((element) => element.mealId == startVerseId);
      if(initialIndex!=-1){
        verseAudioEntities = verseAudioEntities.sublist(initialIndex, verseAudioEntities.length);
      }
    }

    final verses = await _getVersesByEntities(verseAudioEntities);

    final editionName = await _editionDao.getEditionNameByIdentifier(listenAudioParam.identifier);

    if(editionName == null) return [];

    final cuzs = await _cuzDao.getAllCuz();

    final items = <VerseMealVoiceModel>[];

    for(final vae in verseAudioEntities){
      final verse = verses.firstWhereOrNull((e) => e.id == vae.mealId);
      if(verse == null) continue;

      final item = VerseMealVoiceModel(
        identifier: listenAudioParam.identifier,
        fileName: vae.fileName,
        surahId: verse.surahId,
        surahName: verse.surahName,
        cuzNo: verse.cuzNo,
        cuzName: cuzs.firstWhereOrNull((e) => e.cuzNo == verse.cuzNo)?.name ?? "",
        mealId: vae.mealId,
        pageNo: verse.pageNo,
        editionName: editionName,
        verseNumbers: verse.verseNumber
      );

      items.add(item);
    }

    return items;
  }

  Future<List<Verse>> _getVersesByEntities(List<VerseAudioEntity> entities)async{
    final mealIds = entities.map((e) => e.mealId).toList();
    final verseEntities = await _verseDao.getVersesByIds(mealIds);
    return await _getVerses.call(verseEntities);
  }


  Future<List<VerseAudioEntity>> _getEntities(ListenAudioParam listenAudioParam)async{

    final itemId = listenAudioParam.itemId;
    final identifier = listenAudioParam.identifier;
    final startVerseId = listenAudioParam.startVerseId;

    final List<VerseAudioEntity> verseAudioEntities;

    switch(listenAudioParam.op){
      case QuranAudioOption.cuz:
        if(startVerseId!=null){
          verseAudioEntities = await _verseAudioDao.getVerseAudioWithCuzNo(itemId, identifier, startVerseId);
        }else{
          verseAudioEntities = await _verseAudioDao.getAllVerseAudioWithCuzNo(itemId, identifier);
        }
        break;
      case QuranAudioOption.surah:
        if(startVerseId!=null){
          verseAudioEntities = await _verseAudioDao.getVerseAudioWithSurahId(itemId, identifier, startVerseId);
        }else{
          verseAudioEntities = await _verseAudioDao.getAllVerseAudioWithSurahId(itemId, identifier);
        }
        break;
      case QuranAudioOption.page:
        if(startVerseId!=null){
          verseAudioEntities = await _verseAudioDao.getVerseAudioWithPageNo(itemId, identifier, startVerseId);
        }else{
          verseAudioEntities = await _verseAudioDao.getAllVerseAudioWithPageNo(itemId, identifier);
        }
        break;
      case QuranAudioOption.verse:
        verseAudioEntities = await _verseAudioDao.getAllVerseAudioWithMealId(itemId, identifier);
        break;
    }

    return verseAudioEntities;
  }

}