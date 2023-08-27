import 'dart:convert';
import 'dart:typed_data';
import 'package:hadith/core/data/local/services/backup_dao.dart';
import 'package:hadith/core/data/mapper/backup/counter_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/history_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/list_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/list_hadith_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/list_verse_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/prayer_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/savepoint_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/topic_savepoint_backup_mapper.dart';
import 'package:hadith/core/data/remote/backup_dtos/counter_backup_dto/counter_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/history_backup_dto/history_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/list_backup_dto/list_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/list_hadith_backup_dto/list_hadith_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/list_verse_backup_dto/list_verse_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/savepoint_backup_dto/savepoint_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/topic_savepoint_backup_dto/topic_savepoint_backup_dto.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/backup/local_backup_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
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
    await _backupDao.deletePrayersWithTypeId(PrayerTypeEnum.custom.typeId);
  }


  Future<String> _getJsonData()async{
    final hadithLists = await _backupDao.getHadithListEntities();
    final lists = await _backupDao.getLists();
    final savePoints = await _backupDao.getSavePoints();
    final topicSavePoints = await _backupDao.getTopicSavePoints();
    final verseLists = await _backupDao.getVerseListEntities();
    final histories = await _backupDao.getHistories();
    final counterEntities = await _backupDao.getCounterEntities();
    final prayers = await _backupDao.getPrayersWithTypeId(PrayerTypeEnum.custom.typeId);

    final hadithListJsonArr = hadithLists.map((e) => e.toListHadithBackupDto().toJson()).toList();
    final listsJsonArr = lists.map((e) => e.toListBackupDto().toJson()).toList();
    final savePointsJsonArr = savePoints.map((e) => e.toSavePointBackupDto().toJson()).toList();
    final topicSavePointsJsonArr = topicSavePoints.map((e) => e.toTopicSavePointBackupDto().toJson()).toList();
    final verseListJsonArr = verseLists.map((e) => e.toListVerseBackupDto().toJson()).toList();
    final historiesJsonArr = histories.map((e) => e.toHistoryBackupDto().toJson()).toList();
    final countersJsonArr = counterEntities.map((e) => e.toCounterBackupDto().toJson()).toList();
    final prayersJsonArr = prayers.map((e) => e.toPrayerBackupDto().toJson()).toList();

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
      "prayers": prayersJsonArr
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
      final prayersJsonArr = data["prayers"] as List?;

      final hadithLists = hadithListJsonArr.map((e) => ListHadithBackupDto.fromJson(e)).toList();
      final lists = listsJsonArr.map((e) => ListBackupDto.fromJson(e)).toList();
      final savePoints = savePointsJsonArr.map((e) => SavePointBackupDto.fromJson(e)).toList();
      final topicSavePoints = topicSavePointsJsonArr.map((e) => TopicSavePointBackupDto.fromJson(e)).toList();
      final verseLists = verseListJsonArr.map((e) => ListVerseBackupDto.fromJson(e)).toList();
      final histories = historiesJsonArr.map((e) => HistoryBackupDto.fromJson(e)).toList();

      final counters = countersJsonArr!=null ?
          countersJsonArr.map((e) => CounterBackupDto.fromJson(e)).toList() : <CounterBackupDto>[];

      final prayers = prayersJsonArr != null ?
          prayersJsonArr.map((e) => PrayerBackupDto.fromJson(e)).toList() : <PrayerBackupDto>[];

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
      await _backupDao.insertCounterEntities(counters.map((e) => e.toCounterEntity()).toList());
      await _backupDao.insertPrayerEntities(prayers.map((e) => e.toPrayerEntity()).toList());

      return ResourceSuccess(null);
    }catch(e){
      return ResourceError(e.toString());
    }
  }

}