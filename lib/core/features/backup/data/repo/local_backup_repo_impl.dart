import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:hadith/core/data/local/services/backup_dao.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/features/backup/data/mapper/counter_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/esmaul_husna_info_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/history_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/list_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/list_hadith_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/list_verse_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/prayer_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/prayer_backup_non_removable_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/prayer_verse_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/savepoint_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/topic_savepoint_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/counter_backup_dto/counter_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/esmaul_husna_info_dto/esmaul_husna_info_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/history_backup_dto/history_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/list_backup_dto/list_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/list_hadith_backup_dto/list_hadith_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/list_verse_backup_dto/list_verse_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/prayer_backup_dto/prayer_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/prayer_backup_dto/prayer_backup_non_removable_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/savepoint_backup_dto/savepoint_backup_dto.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/topic_savepoint_backup_dto/topic_savepoint_backup_dto.dart';
import 'package:hadith/core/features/backup/domain/repo/local_backup_repo.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LocalBackupRepoImpl extends LocalBackupRepo{

  late final BackupDao _backupDao;
  late final AppPreferences _appPreferences;

  LocalBackupRepoImpl({
    required BackupDao backupDao,
    required AppPreferences appPreferences
  }){
    _backupDao = backupDao;
    _appPreferences = appPreferences;
  }


  @override
  Future<Resource<void>> writeData({
    required Uint8List data,
    required bool deleteData
  })async{
    return _extractData(
      jsonData: const Utf8Decoder().convert(data),
      deleteData: deleteData,
    );
  }

  @override
  Future<Uint8List> getData()async{
    final jsonData = await _getJsonData();
    return Uint8List.fromList(
        const Utf8Encoder().convert(jsonData)
    );
  }

  @override
  Future<void> deleteAllData()async{
    await _backupDao.deleteHadithLists();
    await _backupDao.deleteLists();
    await _backupDao.deleteSavePoints();
    await _backupDao.deleteTopicSavePoints();
    await _backupDao.deleteVerseLists();
    await _backupDao.deleteHistories();
    await _backupDao.deleteCounterEntities(await _backupDao.getCounterEntities());
    await _backupDao.deletePrayers();
  }


  Future<String> _getJsonData()async{
    final hadithLists = await _backupDao.getHadithListEntities();
    final lists = await _backupDao.getLists();
    final savePoints = await _backupDao.getSavePoints();
    final topicSavePoints = await _backupDao.getTopicSavePoints();
    final verseLists = await _backupDao.getVerseListEntities();
    final histories = await _backupDao.getHistories();
    final counterEntities = await _backupDao.getCounterEntities();
    final esmaulHusnaEntities = await _backupDao.getEsmaulHusnas();
    final prayers = await _backupDao.getPrayersBackupDto();
    final prayersNonRemovable = await _backupDao.getPrayersNonRemovable();


    final hadithListJsonArr = hadithLists.map((e) => e.toListHadithBackupDto().toJson()).toList();
    final listsJsonArr = lists.map((e) => e.toListBackupDto().toJson()).toList();
    final savePointsJsonArr = savePoints.map((e) => e.toSavePointBackupDto().toJson()).toList();
    final topicSavePointsJsonArr = topicSavePoints.map((e) => e.toTopicSavePointBackupDto().toJson()).toList();
    final verseListJsonArr = verseLists.map((e) => e.toListVerseBackupDto().toJson()).toList();
    final historiesJsonArr = histories.map((e) => e.toHistoryBackupDto().toJson()).toList();
    final countersJsonArr = counterEntities.map((e) => e.toCounterBackupDto().toJson()).toList();
    final esmaulHusnaInfoJsonArr = esmaulHusnaEntities.map((e) => e.toEsmaulHusnaInfoDto().toJson()).toList();
    final prayersJsonArr = prayers.map((e) => e.toJson()).toList();
    final prayersNonRemovableJsonArr = prayersNonRemovable.map((e) => e.toPrayerBackupNonRemovableDto().toJson()).toList();


    final sharedJson = _appPreferences.toJson();

    final packageInfo=await PackageInfo.fromPlatform();

    final resultMap = {
      "info":{"version":packageInfo.version,"buildNumber":packageInfo.buildNumber},
      "history": historiesJsonArr,
      "list": listsJsonArr,
      "listHadith": hadithListJsonArr,
      "listVerse": verseListJsonArr,
      "savePoint": savePointsJsonArr,
      "topicSavePoint": topicSavePointsJsonArr,
      "appPreferences": sharedJson,
      "counters": countersJsonArr,
      "esmaulHusnaInfo": esmaulHusnaInfoJsonArr,
      "prayers": prayersJsonArr,
      "prayersNonRemovableInfo": prayersNonRemovableJsonArr
    };
    return jsonEncode(resultMap);
  }

  Future<Resource<void>> _extractData({
    required String jsonData,
    required bool deleteData
  })async{

    try{
      final Map<String,dynamic> data = jsonDecode(jsonData);

      final hadithListJsonArr = data["listHadith"] as List;
      final listsJsonArr = data["list"] as List;
      final savePointsJsonArr = data["savePoint"] as List;
      final topicSavePointsJsonArr = data["topicSavePoint"] as List;
      final verseListJsonArr = data["listVerse"] as List;
      final historiesJsonArr = data["history"] as List;
      final sharedJsonArr = data["sharedPreferences"] as List?;
      final appPrefJson = data["appPreferences"] as Map<String,dynamic>?;
      final countersJsonArr = data["counters"] as List?;
      final esmaulHusnaInfoJsonArr = data["esmaulHusnaInfo"] as List?;
      final prayersJsonArr = data["prayers"] as List?;
      final prayersNonRemovableJsonArr = data["prayersNonRemovableInfo"] as List?;

      final hadithLists = hadithListJsonArr.map((e) => ListHadithBackupDto.fromJson(_try(e))).toList();
      final lists = listsJsonArr.map((e) => ListBackupDto.fromJson(_try(e))).toList();
      final savePoints = savePointsJsonArr.map((e) => SavePointBackupDto.fromJson(_try(e))).toList();
      final topicSavePoints = topicSavePointsJsonArr.map((e) => TopicSavePointBackupDto.fromJson(_try(e))).toList();
      final verseLists = verseListJsonArr.map((e) => ListVerseBackupDto.fromJson(_try(e))).toList();
      final histories = historiesJsonArr.map((e) => HistoryBackupDto.fromJson(_try(e))).toList();

      final counters = countersJsonArr!=null ?
          countersJsonArr.map((e) => CounterBackupDto.fromJson(_try(e))).toList() : <CounterBackupDto>[];

      final esmaulHusnaInfo = esmaulHusnaInfoJsonArr != null ?
          esmaulHusnaInfoJsonArr.map((e) => EsmaulHusnaInfoDto.fromJson(_try(e))).toList() : <EsmaulHusnaInfoDto>[];

      final prayers = prayersJsonArr != null ?
          prayersJsonArr.map((e) => PrayerBackupDto.fromJson(_try(e))).toList() : <PrayerBackupDto>[];

      final prayersNonRemovable = prayersNonRemovableJsonArr != null ?
          prayersNonRemovableJsonArr.map((e) => PrayerBackupNonRemovableDto.fromJson(_try(e))).toList() : <PrayerBackupNonRemovableDto>[];

      if(sharedJsonArr != null){
        await _appPreferences.fromJsonListLegacy(sharedJsonArr);
      }else if(appPrefJson != null){
        await _appPreferences.fromJson(appPrefJson);
      }

      if(deleteData){
        await deleteAllData();
      }

      await _backupDao.insertHistories(histories.map((e) => e.toHistoryEntity()).toList());
      await _backupDao.insertSavePoints(savePoints.map((e) => e.toSavePointEntity()).toList());
      await _backupDao.insertTopicSavePoints(topicSavePoints.map((e) => e.toTopicSavePointEntity()).toList());

      await _backupDao.insertLists(lists.map((e) => e.toListEntity()).toList());
      await _backupDao.insertHadithLists(hadithLists.map((e) => e.toListHadithEntity()).toList());
      await _backupDao.insertVerseLists(verseLists.map((e) => e.toListVerseEntity()).toList());

      await _insertPrayerRelatedBackups(
          prayerBackups: prayers,
          prayerBackupNonRemovableBackups: prayersNonRemovable,
          esmaulHusnaInfoBackups: esmaulHusnaInfo,
          counterBackups: counters
      );
      return ResourceSuccess(null);
    }catch(e){
      return ResourceError(e.toString());
    }
  }

  Map<String,dynamic> _try(dynamic e){
    if(e is String){
      return jsonDecode(e);
    }
    return e;
  }


  Future<void> _insertPrayerRelatedBackups({
    required List<PrayerBackupNonRemovableDto> prayerBackupNonRemovableBackups,
    required List<PrayerBackupDto> prayerBackups,
    required List<EsmaulHusnaInfoDto> esmaulHusnaInfoBackups,
    required List<CounterBackupDto> counterBackups
  })async{
    //key -> old id, value -> new id
    Map<int?,int> prayerIdsMapper = HashMap();
    Map<int?,int> counterIdsMapper = HashMap();

    // insert prayerVerses and customPrayers
    for(final prayer in prayerBackups){
      final prayerVerseDtos = prayer.prayerVerseBackups;
      final prayerId = await _backupDao.insertPrayerEntity(prayer.toPrayerEntity());
      final prayerVerseEntities = prayerVerseDtos.map((e){
        return e.copyWith(prayerId: prayerId).toPrayerVerseEntity();
      }).toList();
      await _backupDao.insertPrayerVerseEntities(prayerVerseEntities);
      prayerIdsMapper[prayer.id] = prayerId;
    }

    //insert Counters
    for(final counter in counterBackups){
      final newPrayerId = prayerIdsMapper[counter.prayerId];
      final counterId = await _backupDao.insertCounterEntity(counter.toCounterEntity(updatedPrayerId: newPrayerId));
      counterIdsMapper[counter.id] = counterId;
    }

    //update EsmaulHusna info
    for(final esmaulHusnaInfo in esmaulHusnaInfoBackups){
      final newCounterId = counterIdsMapper[esmaulHusnaInfo.counterId ?? 0];
      if(newCounterId != null){
        await _backupDao.updateEsmaulHusnaCounterId(esmaulHusnaInfo.orderItem, newCounterId);
      }
    }

    //update non removable prayers
    for(final prayer in prayerBackupNonRemovableBackups){
      final newParentPrayerId = prayerIdsMapper[prayer.parentPrayerId];
      if(newParentPrayerId != null){
        await _backupDao.updateNonRemovablePrayers(prayer.orderItem, prayer.typeId, newParentPrayerId);
      }
    }

    //update custom prayer's counterId
    for(final prayer in prayerBackups){
      final insertedPrayerId = prayerIdsMapper[prayer.id];
      final updatedCounterId = counterIdsMapper[prayer.counterId];
      if(insertedPrayerId != null && updatedCounterId != null){
        await _backupDao.updatePrayerCounterId(updatedCounterId, insertedPrayerId);
      }
    }

  }

}