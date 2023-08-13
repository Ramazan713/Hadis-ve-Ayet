// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HadithDaoOld? _hadithDaoInstance;

  CuzDaoOld? _cuzDaoOldInstance;

  ListDaoOld? _listDaoOldInstance;

  SurahDaoOld? _surahDaoOldInstance;

  VerseDaoOld? _verseDaoOldInstance;

  TopicDaoOld? _topicDaoOldInstance;

  SectionDao? _sectionDaoInstance;

  SavePointDaoOld? _savePointDaoOldInstance;

  TopicSavePointDaoOld? _topicSavePointDaoOldInstance;

  HistoryDaoOld? _historyDaoOldInstance;

  BackupMetaDao? _backupMetaDaoInstance;

  BackupDao? _backupDaoInstance;

  UserInfoDao? _userInfoDaoInstance;

  AudioEditionDaoOld? _editionDaoOldInstance;

  VerseAudioDaoOld? _verseAudioDaoOldInstance;

  VerseArabicDaoOld? _verseArabicDaoOldInstance;

  VerseAudioStateDao? _verseAudioStateDaoInstance;

  CounterDao? _counterDaoInstance;

  EsmaulHusnaDaoOld? _esmaulHusnaDaoOldInstance;

  PrayerDaoOld? _prayerDaoOldInstance;

  IslamicInfoDao? _islamicInfoDaoInstance;

  QuranPrayerDao? _quranPrayerDaoInstance;

  HadithAllDao? _hadithAllDaoInstance;

  ListDao? _listDaoInstance;

  ListHadithDao? _listHadithDaoInstance;

  ListHadithViewDao? _listHadithViewDaoInstance;

  ListVerseDao? _listVerseDaoInstance;

  ListVerseViewDao? _listVerseViewDaoInstance;

  SavePointDao? _savePointDaoInstance;

  HadithInfoListDao? _hadithInfoListDaoInstance;

  VerseInfoListDao? _verseInfoListDaoInstance;

  TopicDao? _topicDaoInstance;

  TopicHadithViewDao? _topicHadithsViewDaoInstance;

  TopicVersesViewDao? _topicVersesViewDaoInstance;

  SectionViewDao? _sectionViewDaoInstance;

  TopicSavePointDao? _topicSavePointDaoInstance;

  CuzDao? _cuzDaoInstance;

  SurahDao? _surahDaoInstance;

  VerseArabicDao? _verseArabicDaoInstance;

  VerseDao? _verseDaoInstance;

  TitleDao? _titleDaoInstance;

  SearchDao? _searchDaoInstance;

  HistoryDao? _historyDaoInstance;

  AudioEditionDao? _editionDaoInstance;

  VerseAudioDao? _verseAudioDaoInstance;

  AudioViewDao? _audioViewDaoInstance;

  PrayerDao? _prayerDaoInstance;

  EsmaulHusnaDao? _esmaulHusnaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 4,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `hadith` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER NOT NULL, `content` TEXT NOT NULL, `source` TEXT NOT NULL, `contentSize` INTEGER NOT NULL, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cuz` (`cuzNo` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`cuzNo`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Surah` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `searchName` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `topic` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `sectionId` INTEGER NOT NULL, FOREIGN KEY (`sectionId`) REFERENCES `section` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verse` (`surahId` INTEGER NOT NULL, `cuzNo` INTEGER NOT NULL, `pageNo` INTEGER NOT NULL, `verseNumber` TEXT NOT NULL, `content` TEXT NOT NULL, `isProstrationVerse` INTEGER NOT NULL, `surahName` TEXT, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER NOT NULL, FOREIGN KEY (`cuzNo`) REFERENCES `Cuz` (`cuzNo`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`surahId`) REFERENCES `Surah` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `section` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `bookId` INTEGER NOT NULL, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IntData` (`data` INTEGER NOT NULL, PRIMARY KEY (`data`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `savePoints` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemIndexPos` INTEGER NOT NULL, `title` TEXT NOT NULL, `autoType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, `savePointType` INTEGER NOT NULL, `bookScope` INTEGER NOT NULL, `parentName` TEXT NOT NULL, `parentKey` TEXT NOT NULL, FOREIGN KEY (`savePointType`) REFERENCES `savePointType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `savePointType` (`id` INTEGER, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BackupMeta` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fileName` TEXT NOT NULL, `updatedDate` TEXT NOT NULL, `isAuto` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `topicSavePoint` (`id` INTEGER, `pos` INTEGER NOT NULL, `type` INTEGER NOT NULL, `parentKey` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `originType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, FOREIGN KEY (`originType`) REFERENCES `sourceType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `userInfo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT NOT NULL, `img` BLOB)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseArabic` (`id` INTEGER, `mealId` INTEGER NOT NULL, `verse` TEXT NOT NULL, `verseNumber` TEXT NOT NULL, `verseNumberTr` INTEGER NOT NULL, FOREIGN KEY (`mealId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `list` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isRemovable` INTEGER NOT NULL, `sourceId` INTEGER NOT NULL, `isArchive` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`sourceId`) REFERENCES `sourceType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sourceType` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sourceType` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemCountModel` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `itemCount` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseTopic` (`verseId` INTEGER NOT NULL, `topicId` INTEGER NOT NULL, FOREIGN KEY (`verseId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`verseId`, `topicId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `listHadith` (`listId` INTEGER NOT NULL, `hadithId` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`listId`) REFERENCES `List<dynamic>` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`hadithId`) REFERENCES `hadith` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`listId`, `hadithId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseAudioDownloadTemp` (`verseId` INTEGER NOT NULL, `surahId` INTEGER NOT NULL, `mealId` INTEGER NOT NULL, `cuzNo` INTEGER NOT NULL, `verseNumber` INTEGER NOT NULL, `surahName` TEXT NOT NULL, PRIMARY KEY (`verseId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `listVerse` (`listId` INTEGER NOT NULL, `verseId` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`listId`) REFERENCES `List<dynamic>` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`verseId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`listId`, `verseId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `hadithTopic` (`topicId` INTEGER NOT NULL, `hadithId` INTEGER NOT NULL, FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`hadithId`) REFERENCES `hadith` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`topicId`, `hadithId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `book` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `sourceId` INTEGER NOT NULL, FOREIGN KEY (`sourceId`) REFERENCES `sourceType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseAudio` (`mealId` INTEGER NOT NULL, `identifier` TEXT NOT NULL, `fileName` TEXT, `hasEdited` INTEGER NOT NULL, FOREIGN KEY (`mealId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`identifier`) REFERENCES `AudioEdition` (`identifier`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mealId`, `identifier`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AudioEdition` (`identifier` TEXT NOT NULL, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL, `fileName` TEXT, PRIMARY KEY (`identifier`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseAudioTemp` (`mealId` INTEGER NOT NULL, `surahName` TEXT NOT NULL, `surahId` INTEGER NOT NULL, `identifier` TEXT NOT NULL, `editionName` TEXT NOT NULL, `fileName` TEXT, `cuzNo` INTEGER NOT NULL, `pageNo` INTEGER NOT NULL, `verseNumber` TEXT NOT NULL, PRIMARY KEY (`mealId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `counters` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `content` TEXT, `arabicContent` TEXT, `meaning` TEXT, `orderItem` INTEGER NOT NULL, `lastCounter` INTEGER NOT NULL, `goal` INTEGER, `type` INTEGER NOT NULL, `isRemovable` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EsmaulHusnaOld` (`id` INTEGER, `orderItem` INTEGER NOT NULL, `name` TEXT NOT NULL, `arabicName` TEXT NOT NULL, `meaning` TEXT NOT NULL, `dhikr` TEXT NOT NULL, `virtue` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IslamicInfoItem` (`id` INTEGER, `titleId` INTEGER NOT NULL, `name` TEXT, `description` TEXT, FOREIGN KEY (`titleId`) REFERENCES `IslamicInfoTitle` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IslamicInfoTitle` (`id` INTEGER, `title` TEXT NOT NULL, `description` TEXT, `type` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Prayers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `arabicContent` TEXT, `meaningContent` TEXT, `pronunciationContent` TEXT, `source` TEXT, `typeId` INTEGER NOT NULL, `orderItem` INTEGER NOT NULL, `isRemovable` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PrayersOld` (`id` INTEGER, `name` TEXT NOT NULL, `meaningContent` TEXT NOT NULL, `arabicContent` TEXT NOT NULL, `pronunciationContent` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EsmaulHusna` (`id` INTEGER, `orderItem` INTEGER NOT NULL, `name` TEXT NOT NULL, `arabicName` TEXT NOT NULL, `searchName` TEXT NOT NULL, `meaning` TEXT NOT NULL, `dhikr` TEXT NOT NULL, `virtue` TEXT NOT NULL, `counterId` INTEGER, FOREIGN KEY (`counterId`) REFERENCES `counters` (`id`) ON UPDATE NO ACTION ON DELETE SET NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verse` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER NOT NULL, `surahId` INTEGER NOT NULL, `cuzNo` INTEGER NOT NULL, `pageNo` INTEGER NOT NULL, `verseNumber` TEXT NOT NULL, `content` TEXT NOT NULL, `isProstrationVerse` INTEGER NOT NULL, FOREIGN KEY (`cuzNo`) REFERENCES `CuzEntity` (`cuzNo`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`surahId`) REFERENCES `SurahEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `originType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, FOREIGN KEY (`originType`) REFERENCES `sourceType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AudioEdition` (`identifier` TEXT NOT NULL, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL, `fileName` TEXT, PRIMARY KEY (`identifier`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseAudio` (`mealId` INTEGER NOT NULL, `identifier` TEXT NOT NULL, `fileName` TEXT, `hasEdited` INTEGER NOT NULL, FOREIGN KEY (`mealId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`identifier`) REFERENCES `AudioEdition` (`identifier`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mealId`, `identifier`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `savePoints` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemIndexPos` INTEGER NOT NULL, `title` TEXT NOT NULL, `autoType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, `savePointType` INTEGER NOT NULL, `bookScope` INTEGER NOT NULL, `parentName` TEXT NOT NULL, `parentKey` TEXT NOT NULL, FOREIGN KEY (`savePointType`) REFERENCES `savePointType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `topicSavePoint` (`id` INTEGER, `pos` INTEGER NOT NULL, `type` INTEGER NOT NULL, `parentKey` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CuzEntity` (`cuzNo` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`cuzNo`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SurahEntity` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `searchName` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `verseArabic` (`id` INTEGER, `mealId` INTEGER NOT NULL, `verse` TEXT NOT NULL, `verseNumber` TEXT NOT NULL, `verseNumberTr` INTEGER NOT NULL, FOREIGN KEY (`mealId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PrayerQuran` (`id` INTEGER, `arabicContent` TEXT NOT NULL, `meaningContent` TEXT NOT NULL, `source` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `hadith` (`content` TEXT NOT NULL, `source` TEXT NOT NULL, `contentSize` INTEGER NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER NOT NULL, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `savePoints` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemIndexPos` INTEGER NOT NULL, `title` TEXT NOT NULL, `autoType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, `savePointType` INTEGER NOT NULL, `bookScope` INTEGER NOT NULL, `parentName` TEXT NOT NULL, `parentKey` TEXT NOT NULL, FOREIGN KEY (`savePointType`) REFERENCES `savePointType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `list` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isRemovable` INTEGER NOT NULL, `sourceId` INTEGER NOT NULL, `isArchive` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`sourceId`) REFERENCES `sourceType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `listHadith` (`listId` INTEGER NOT NULL, `hadithId` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`listId`) REFERENCES `List<dynamic>` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`hadithId`) REFERENCES `hadith` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`listId`, `hadithId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `listVerse` (`listId` INTEGER NOT NULL, `verseId` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`listId`) REFERENCES `List<dynamic>` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`verseId`) REFERENCES `verse` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`listId`, `verseId`))');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListVerseView` AS   select L.id,L.name,L.isRemovable,L.isArchive,L.sourceId,count(LV.verseId)itemCounts,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n  from List L left join ListVerse LV on L.id=LV.listId where L.sourceId=2  group by L.id');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListHadithView` AS select L.id,L.name,L.isRemovable,count(LH.hadithId)itemCounts,L.isArchive,L.sourceId,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n  from List L left join ListHadith LH on  L.id=LH.listId where L.sourceId=1 group by L.id');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `cuzAudioView` AS   select E.name editionName, E.identifier,  V.cuzNo, \n  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded,\n  C.name cuzName\n  from  verse V, VerseAudio A, AudioEdition E, Cuz C\n  where  A.identifier = E.identifier and A.mealId=V.id and C.cuzNo = V.cuzNo\n  group by E.identifier, C.name, V.cuzNo\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `surahAudioView` AS select E.name editionName , E.identifier, V.surahId, S.name surahName,\n  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded\n  from  verse V, VerseAudio A, AudioEdition E, Surah S\n  where V.id=A.mealId and A.identifier = E.identifier and S.id = V.surahId\n  group by E.identifier,V.surahId, S.name\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListHadithView` AS select L.id,L.name,L.isRemovable,count(LH.hadithId)itemCounts,L.isArchive,L.sourceId,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n  from List L left join ListHadith LH on  L.id=LH.listId where L.sourceId=1 group by L.id');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListVerseView` AS select L.id,L.name,L.isRemovable,L.isArchive,L.sourceId,count(LV.verseId)itemCounts,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n  from List L left join ListVerse LV on L.id=LV.listId where L.sourceId=2  group by L.id');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `SectionTopicsView` AS     select S.id, S.name, S.bookId, count(T.id)topicCount from section S,Topic T \n    where S.id=T.sectionId  group by S.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `TopicHadithsView` AS     select T.id,T.name,T.sectionId, count(HT.hadithId)hadithCount from \n    topic T,HadithTopic HT where T.id=HT.topicId group by T.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `TopicVersesView` AS   select T.id,T.name,T.sectionId, count(VT.verseId)verseCount from \n  topic T,VerseTopic VT where T.id=VT.topicId group by T.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `VerseInfoListView` AS select V.id verseId,\n        (select exists(select * from ListVerse LV, list L\n          where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LV.verseId = V.id)) inAnyList,\n\t\t    (select exists(select * from ListVerse LV, list L\n          where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LV.verseId = V.id)) inAnyArchiveList,  \n        (select exists(select * from ListVerse LV, list L\n          where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite \n        from verse V');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `HadithInfoListView` AS select H.id hadithId,\n        (select exists(select * from ListHadith LH, list L\n          where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LH.hadithId = H.id)) inAnyList,\n\t\t    (select exists(select * from ListHadith LH, list L\n          where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LH.hadithId = H.id)) inAnyArchiveList,\n        (select exists(select * from ListHadith LH, list L\n          where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite \n        from Hadith H');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HadithDaoOld get hadithDao {
    return _hadithDaoInstance ??= _$HadithDaoOld(database, changeListener);
  }

  @override
  CuzDaoOld get cuzDaoOld {
    return _cuzDaoOldInstance ??= _$CuzDaoOld(database, changeListener);
  }

  @override
  ListDaoOld get listDaoOld {
    return _listDaoOldInstance ??= _$ListDaoOld(database, changeListener);
  }

  @override
  SurahDaoOld get surahDaoOld {
    return _surahDaoOldInstance ??= _$SurahDaoOld(database, changeListener);
  }

  @override
  VerseDaoOld get verseDaoOld {
    return _verseDaoOldInstance ??= _$VerseDaoOld(database, changeListener);
  }

  @override
  TopicDaoOld get topicDaoOld {
    return _topicDaoOldInstance ??= _$TopicDaoOld(database, changeListener);
  }

  @override
  SectionDao get sectionDao {
    return _sectionDaoInstance ??= _$SectionDao(database, changeListener);
  }

  @override
  SavePointDaoOld get savePointDaoOld {
    return _savePointDaoOldInstance ??=
        _$SavePointDaoOld(database, changeListener);
  }

  @override
  TopicSavePointDaoOld get topicSavePointDaoOld {
    return _topicSavePointDaoOldInstance ??=
        _$TopicSavePointDaoOld(database, changeListener);
  }

  @override
  HistoryDaoOld get historyDaoOld {
    return _historyDaoOldInstance ??= _$HistoryDaoOld(database, changeListener);
  }

  @override
  BackupMetaDao get backupMetaDao {
    return _backupMetaDaoInstance ??= _$BackupMetaDao(database, changeListener);
  }

  @override
  BackupDao get backupDao {
    return _backupDaoInstance ??= _$BackupDao(database, changeListener);
  }

  @override
  UserInfoDao get userInfoDao {
    return _userInfoDaoInstance ??= _$UserInfoDao(database, changeListener);
  }

  @override
  AudioEditionDaoOld get editionDaoOld {
    return _editionDaoOldInstance ??=
        _$AudioEditionDaoOld(database, changeListener);
  }

  @override
  VerseAudioDaoOld get verseAudioDaoOld {
    return _verseAudioDaoOldInstance ??=
        _$VerseAudioDaoOld(database, changeListener);
  }

  @override
  VerseArabicDaoOld get verseArabicDaoOld {
    return _verseArabicDaoOldInstance ??=
        _$VerseArabicDaoOld(database, changeListener);
  }

  @override
  VerseAudioStateDao get verseAudioStateDao {
    return _verseAudioStateDaoInstance ??=
        _$VerseAudioStateDao(database, changeListener);
  }

  @override
  CounterDao get counterDao {
    return _counterDaoInstance ??= _$CounterDao(database, changeListener);
  }

  @override
  EsmaulHusnaDaoOld get esmaulHusnaDaoOld {
    return _esmaulHusnaDaoOldInstance ??=
        _$EsmaulHusnaDaoOld(database, changeListener);
  }

  @override
  PrayerDaoOld get prayerDaoOld {
    return _prayerDaoOldInstance ??= _$PrayerDaoOld(database, changeListener);
  }

  @override
  IslamicInfoDao get islamicInfoDao {
    return _islamicInfoDaoInstance ??=
        _$IslamicInfoDao(database, changeListener);
  }

  @override
  QuranPrayerDao get quranPrayerDao {
    return _quranPrayerDaoInstance ??=
        _$QuranPrayerDao(database, changeListener);
  }

  @override
  HadithAllDao get hadithAllDao {
    return _hadithAllDaoInstance ??= _$HadithAllDao(database, changeListener);
  }

  @override
  ListDao get listDao {
    return _listDaoInstance ??= _$ListDao(database, changeListener);
  }

  @override
  ListHadithDao get listHadithDao {
    return _listHadithDaoInstance ??= _$ListHadithDao(database, changeListener);
  }

  @override
  ListHadithViewDao get listHadithViewDao {
    return _listHadithViewDaoInstance ??=
        _$ListHadithViewDao(database, changeListener);
  }

  @override
  ListVerseDao get listVerseDao {
    return _listVerseDaoInstance ??= _$ListVerseDao(database, changeListener);
  }

  @override
  ListVerseViewDao get listVerseViewDao {
    return _listVerseViewDaoInstance ??=
        _$ListVerseViewDao(database, changeListener);
  }

  @override
  SavePointDao get savePointDao {
    return _savePointDaoInstance ??= _$SavePointDao(database, changeListener);
  }

  @override
  HadithInfoListDao get hadithInfoListDao {
    return _hadithInfoListDaoInstance ??=
        _$HadithInfoListDao(database, changeListener);
  }

  @override
  VerseInfoListDao get verseInfoListDao {
    return _verseInfoListDaoInstance ??=
        _$VerseInfoListDao(database, changeListener);
  }

  @override
  TopicDao get topicDao {
    return _topicDaoInstance ??= _$TopicDao(database, changeListener);
  }

  @override
  TopicHadithViewDao get topicHadithsViewDao {
    return _topicHadithsViewDaoInstance ??=
        _$TopicHadithViewDao(database, changeListener);
  }

  @override
  TopicVersesViewDao get topicVersesViewDao {
    return _topicVersesViewDaoInstance ??=
        _$TopicVersesViewDao(database, changeListener);
  }

  @override
  SectionViewDao get sectionViewDao {
    return _sectionViewDaoInstance ??=
        _$SectionViewDao(database, changeListener);
  }

  @override
  TopicSavePointDao get topicSavePointDao {
    return _topicSavePointDaoInstance ??=
        _$TopicSavePointDao(database, changeListener);
  }

  @override
  CuzDao get cuzDao {
    return _cuzDaoInstance ??= _$CuzDao(database, changeListener);
  }

  @override
  SurahDao get surahDao {
    return _surahDaoInstance ??= _$SurahDao(database, changeListener);
  }

  @override
  VerseArabicDao get verseArabicDao {
    return _verseArabicDaoInstance ??=
        _$VerseArabicDao(database, changeListener);
  }

  @override
  VerseDao get verseDao {
    return _verseDaoInstance ??= _$VerseDao(database, changeListener);
  }

  @override
  TitleDao get titleDao {
    return _titleDaoInstance ??= _$TitleDao(database, changeListener);
  }

  @override
  SearchDao get searchDao {
    return _searchDaoInstance ??= _$SearchDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  AudioEditionDao get editionDao {
    return _editionDaoInstance ??= _$AudioEditionDao(database, changeListener);
  }

  @override
  VerseAudioDao get verseAudioDao {
    return _verseAudioDaoInstance ??= _$VerseAudioDao(database, changeListener);
  }

  @override
  AudioViewDao get audioViewDao {
    return _audioViewDaoInstance ??= _$AudioViewDao(database, changeListener);
  }

  @override
  PrayerDao get prayerDao {
    return _prayerDaoInstance ??= _$PrayerDao(database, changeListener);
  }

  @override
  EsmaulHusnaDao get esmaulHusnaDao {
    return _esmaulHusnaDaoInstance ??=
        _$EsmaulHusnaDao(database, changeListener);
  }
}

class _$HadithDaoOld extends HadithDaoOld {
  _$HadithDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<Hadith>> getStreamAllHadiths() {
    return _queryAdapter.queryListStream('select * from hadith',
        mapper: (Map<String, Object?> row) => Hadith(
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        queryableName: 'hadith',
        isView: false);
  }

  @override
  Stream<List<Hadith>> getStreamHadithsWithListId(int listId) {
    return _queryAdapter.queryListStream(
        'select H.* from Hadith H,ListHadith LH where LH.hadithId=H.id and LH.listId=?1',
        mapper: (Map<String, Object?> row) => Hadith(
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        arguments: [listId],
        queryableName: 'Hadith',
        isView: false);
  }

  @override
  Stream<List<Hadith>> getStreamHadithsWithTopicId(int topicId) {
    return _queryAdapter.queryListStream(
        'select H.* from Hadith H,HadithTopic HT where HT.hadithId=H.id and HT.topicId=?1',
        mapper: (Map<String, Object?> row) => Hadith(
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        arguments: [topicId],
        queryableName: 'Hadith',
        isView: false);
  }

  @override
  Future<IntData?> getAllHadithCount() async {
    return _queryAdapter.query('select count(*) data from hadith',
        mapper: (Map<String, Object?> row) =>
            IntData(data: row['data'] as int));
  }

  @override
  Future<List<Hadith>> getPagingAllHadiths(
    int limit,
    int page,
  ) async {
    return _queryAdapter.queryList(
        'select * from hadith limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        arguments: [limit, page]);
  }

  @override
  Future<IntData?> getHadithBookCount(int bookId) async {
    return _queryAdapter.query(
        'select count(*) data from hadith where bookId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [bookId]);
  }

  @override
  Future<List<Hadith>> getPagingBookHadiths(
    int limit,
    int page,
    int bookId,
  ) async {
    return _queryAdapter.queryList(
        'select * from hadith where bookId=?3  limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        arguments: [limit, page, bookId]);
  }

  @override
  Future<IntData?> getListWithHadithCount(int listId) async {
    return _queryAdapter.query(
        'select count(H.id) data from Hadith H,ListHadith LH      where LH.hadithId=H.id and LH.listId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<Hadith>> getPagingListHadiths(
    int limit,
    int page,
    int listId,
  ) async {
    return _queryAdapter.queryList(
        'select H.* from Hadith H,ListHadith LH      where LH.hadithId=H.id and LH.listId=?3 order by       LH.pos desc limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, listId]);
  }

  @override
  Future<List<Hadith>> getListHadiths(int listId) async {
    return _queryAdapter.queryList(
        'select H.* from Hadith H,ListHadith LH      where LH.hadithId=H.id and LH.listId=?1 order by       LH.pos desc',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [listId]);
  }

  @override
  Future<IntData?> getTopicWithHadithCount(int topicId) async {
    return _queryAdapter.query(
        'select count(H.id) data from Hadith H,HadithTopic HT      where HT.hadithId=H.id and HT.topicId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [topicId]);
  }

  @override
  Future<List<Hadith>> getPagingTopicHadiths(
    int limit,
    int page,
    int topicId,
  ) async {
    return _queryAdapter.queryList(
        'select H.* from Hadith H,HadithTopic HT      where HT.hadithId=H.id and HT.topicId=?3 limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, topicId]);
  }

  @override
  Future<IntData?> getSearchWithHadithCountWithRegEx(String regExp) async {
    return _queryAdapter.query(
        'select count(id) data from Hadith where lower(content) REGEXP lower(?1)',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [regExp]);
  }

  @override
  Future<List<Hadith>> getPagingSearchHadithsWithRegEx(
    int limit,
    int page,
    String regExp,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where lower(content) REGEXP lower(?3)       limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, regExp]);
  }

  @override
  Future<IntData?> getSearchHadithCountWithBookAndRegEx(
    String regExp,
    int bookId,
  ) async {
    return _queryAdapter.query(
        'select count(id) data from Hadith where bookId=?2 and lower(content)  REGEXP lower(?1)',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [regExp, bookId]);
  }

  @override
  Future<List<Hadith>> getPagingSearchHadithsWithBookAndRegEx(
    int limit,
    int page,
    int bookId,
    String regExp,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where bookId=?3 and       lower(content)  REGEXP lower(?4) limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, bookId, regExp]);
  }

  @override
  Future<IntData?> getSearchWithHadithCount(String query) async {
    return _queryAdapter.query(
        'select count(id) data from Hadith where lower(content) Like lower(?1)',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [query]);
  }

  @override
  Future<List<Hadith>> getPagingSearchHadiths(
    int limit,
    int page,
    String query,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where lower(content) Like lower(?3)       limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, query]);
  }

  @override
  Future<IntData?> getSearchHadithCountWithBook(
    String query,
    int bookId,
  ) async {
    return _queryAdapter.query(
        'select count(id) data from Hadith where bookId=?2 and lower(content)  Like lower(?1)',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [query, bookId]);
  }

  @override
  Future<List<Hadith>> getPagingSearchHadithsWithBook(
    int limit,
    int page,
    int bookId,
    String query,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where bookId=?3 and       lower(content) Like lower(?4) limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Hadith(content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, bookId, query]);
  }
}

class _$CuzDaoOld extends CuzDaoOld {
  _$CuzDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Cuz>> getAllCuz() async {
    return _queryAdapter.queryList('select * from cuz',
        mapper: (Map<String, Object?> row) =>
            Cuz(cuzNo: row['cuzNo'] as int, name: row['name'] as String));
  }

  @override
  Future<Cuz?> getCuz(int cuzNo) async {
    return _queryAdapter.query('select * from Cuz where cuzNo=?1',
        mapper: (Map<String, Object?> row) =>
            Cuz(cuzNo: row['cuzNo'] as int, name: row['name'] as String),
        arguments: [cuzNo]);
  }
}

class _$ListDaoOld extends ListDaoOld {
  _$ListDaoOld(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _listEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'list',
            (ListEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'listHadith',
            (ListHadithEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'listVerse',
            (ListVerseEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _listEntityOldUpdateAdapter = UpdateAdapter(
            database,
            'list',
            ['id'],
            (ListEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityOldUpdateAdapter = UpdateAdapter(
            database,
            'listHadith',
            ['listId', 'hadithId'],
            (ListHadithEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityOldUpdateAdapter = UpdateAdapter(
            database,
            'listVerse',
            ['listId', 'verseId'],
            (ListVerseEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _listEntityOldDeletionAdapter = DeletionAdapter(
            database,
            'list',
            ['id'],
            (ListEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityOldDeletionAdapter = DeletionAdapter(
            database,
            'listHadith',
            ['listId', 'hadithId'],
            (ListHadithEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityOldDeletionAdapter = DeletionAdapter(
            database,
            'listVerse',
            ['listId', 'verseId'],
            (ListVerseEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ListEntityOld> _listEntityOldInsertionAdapter;

  final InsertionAdapter<ListHadithEntityOld>
      _listHadithEntityOldInsertionAdapter;

  final InsertionAdapter<ListVerseEntityOld>
      _listVerseEntityOldInsertionAdapter;

  final UpdateAdapter<ListEntityOld> _listEntityOldUpdateAdapter;

  final UpdateAdapter<ListHadithEntityOld> _listHadithEntityOldUpdateAdapter;

  final UpdateAdapter<ListVerseEntityOld> _listVerseEntityOldUpdateAdapter;

  final DeletionAdapter<ListEntityOld> _listEntityOldDeletionAdapter;

  final DeletionAdapter<ListHadithEntityOld>
      _listHadithEntityOldDeletionAdapter;

  final DeletionAdapter<ListVerseEntityOld> _listVerseEntityOldDeletionAdapter;

  @override
  Stream<List<ListEntityOld>> getStreamList(int sourceId) {
    return _queryAdapter.queryListStream(
        'select * from list where sourceId=?1 order by isRemovable asc,pos desc',
        mapper: (Map<String, Object?> row) => ListEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int),
        arguments: [sourceId],
        queryableName: 'list',
        isView: false);
  }

  @override
  Stream<List<ListEntityOld>> getStreamListWithArchive(
    int sourceId,
    bool isArchive,
  ) {
    return _queryAdapter.queryListStream(
        'select * from list where sourceId=?1 and isArchive=?2 order by isRemovable asc,pos desc',
        mapper: (Map<String, Object?> row) => ListEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int),
        arguments: [sourceId, isArchive ? 1 : 0],
        queryableName: 'list',
        isView: false);
  }

  @override
  Stream<List<ListEntityOld>> getStreamRemovableList(int sourceId) {
    return _queryAdapter.queryListStream(
        'select * from list where sourceId=?1 and isRemovable=1 order by pos desc',
        mapper: (Map<String, Object?> row) => ListEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int),
        arguments: [sourceId],
        queryableName: 'list',
        isView: false);
  }

  @override
  Stream<List<ListEntityOld>> getStreamRemovableListWithArchive(
    int sourceId,
    bool isArchive,
  ) {
    return _queryAdapter.queryListStream(
        'select * from list where sourceId=?1 and isRemovable=1 and    isArchive=?2 order by pos desc',
        mapper: (Map<String, Object?> row) => ListEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int),
        arguments: [sourceId, isArchive ? 1 : 0],
        queryableName: 'list',
        isView: false);
  }

  @override
  Future<List<ListHadithEntityOld>> getHadithListWithListId(int listId) async {
    return _queryAdapter.queryList('select * from listHadith where listId=?1',
        mapper: (Map<String, Object?> row) => ListHadithEntityOld(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<ListHadithEntityOld>> getHadithListWithHadithId(
      int hadithId) async {
    return _queryAdapter.queryList('select * from listHadith where hadithId=?1',
        mapper: (Map<String, Object?> row) => ListHadithEntityOld(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [hadithId]);
  }

  @override
  Future<List<ListHadithEntityOld>> getHadithListWithHadithIdArchive(
    int hadithId,
    bool isArchive,
  ) async {
    return _queryAdapter.queryList(
        'select * from listHadith where hadithId=?1 and isArchive=?2',
        mapper: (Map<String, Object?> row) => ListHadithEntityOld(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [hadithId, isArchive ? 1 : 0]);
  }

  @override
  Future<List<ListHadithEntityOld>> getHadithListWithRemovable(
    int hadithId,
    bool isRemovable,
  ) async {
    return _queryAdapter.queryList(
        'select LH.* from listHadith LH,List L where      LH.listId=L.id and LH.hadithId=?1 and L.isRemovable=?2',
        mapper: (Map<String, Object?> row) => ListHadithEntityOld(listId: row['listId'] as int, hadithId: row['hadithId'] as int, pos: row['pos'] as int),
        arguments: [hadithId, isRemovable ? 1 : 0]);
  }

  @override
  Future<List<ListHadithEntityOld>> getHadithListWithRemovableArchive(
    int hadithId,
    bool isRemovable,
    bool isArchive,
  ) async {
    return _queryAdapter.queryList(
        'select LH.* from listHadith LH,List L where isArchive=?3 and     LH.listId=L.id and LH.hadithId=?1 and L.isRemovable=?2',
        mapper: (Map<String, Object?> row) => ListHadithEntityOld(listId: row['listId'] as int, hadithId: row['hadithId'] as int, pos: row['pos'] as int),
        arguments: [hadithId, isRemovable ? 1 : 0, isArchive ? 1 : 0]);
  }

  @override
  Future<List<ListVerseEntityOld>> getVerseListWithListId(int listId) async {
    return _queryAdapter.queryList('select * from listVerse where listId=?1',
        mapper: (Map<String, Object?> row) => ListVerseEntityOld(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<ListVerseEntityOld>> getVerseListWithVerseId(int verseId) async {
    return _queryAdapter.queryList('select * from listVerse where verseId=?1',
        mapper: (Map<String, Object?> row) => ListVerseEntityOld(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [verseId]);
  }

  @override
  Future<List<ListVerseEntityOld>> getVerseListWithVerseIdArchive(
    int verseId,
    bool isArchive,
  ) async {
    return _queryAdapter.queryList(
        'select * from listVerse where verseId=?1 and isArchive=?2',
        mapper: (Map<String, Object?> row) => ListVerseEntityOld(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [verseId, isArchive ? 1 : 0]);
  }

  @override
  Future<List<ListVerseEntityOld>> getVerseListWithRemovable(
    int verseId,
    bool isRemovable,
  ) async {
    return _queryAdapter.queryList(
        'select LV.* from listVerse LV,List L where     LV.listId=L.id and LV.verseId=?1 and L.isRemovable=?2',
        mapper: (Map<String, Object?> row) => ListVerseEntityOld(listId: row['listId'] as int, verseId: row['verseId'] as int, pos: row['pos'] as int),
        arguments: [verseId, isRemovable ? 1 : 0]);
  }

  @override
  Future<List<ListVerseEntityOld>> getVerseListWithRemovableArchive(
    int verseId,
    bool isRemovable,
    bool isArchive,
  ) async {
    return _queryAdapter.queryList(
        'select LV.* from listVerse LV,List L where isArchive=?3 and     LV.listId=L.id and LV.verseId=?1 and L.isRemovable=?2',
        mapper: (Map<String, Object?> row) => ListVerseEntityOld(listId: row['listId'] as int, verseId: row['verseId'] as int, pos: row['pos'] as int),
        arguments: [verseId, isRemovable ? 1 : 0, isArchive ? 1 : 0]);
  }

  @override
  Future<IntData?> verseIsAddedToList(
    int verseId,
    bool isRemovable,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from listVerse LV,List L where     LV.listId=L.id and LV.verseId=?1 and L.isRemovable=?2) data',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [verseId, isRemovable ? 1 : 0]);
  }

  @override
  Future<IntData?> verseIsAddedToListWithArchive(
    int verseId,
    bool isRemovable,
    bool isArchive,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from listVerse LV,List L where isArchive=?3 and     LV.listId=L.id and LV.verseId=?1 and L.isRemovable=?2) data',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [verseId, isRemovable ? 1 : 0, isArchive ? 1 : 0]);
  }

  @override
  Future<IntData?> getContentMaxPosFromListHadith(int listId) async {
    return _queryAdapter.query(
        'select contentMaxPos data from listHadithView where id=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [listId]);
  }

  @override
  Future<IntData?> getContentMaxPosFromListVerse(int listId) async {
    return _queryAdapter.query(
        'select contentMaxPos data from listVerseView where id=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [listId]);
  }

  @override
  Future<IntData?> getMaxPosListWithSourceId(int sourceId) async {
    return _queryAdapter.query(
        'select max(pos) data from list where sourceId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [sourceId]);
  }

  @override
  Future<IntData?> getMaxPosList() async {
    return _queryAdapter.query('select max(pos) data from list',
        mapper: (Map<String, Object?> row) =>
            IntData(data: row['data'] as int));
  }

  @override
  Stream<List<ListHadithViewOld>> getListHadithViews(bool isArchive) {
    return _queryAdapter.queryListStream(
        'select * from listHadithView where isArchive=?1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithViewOld(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            listPos: row['listPos'] as int),
        arguments: [isArchive ? 1 : 0],
        queryableName: 'listHadithView',
        isView: true);
  }

  @override
  Stream<List<ListHadithViewOld>> getSearchResultHadithViews(
    String name,
    String or1,
    String or2,
    String or3,
    bool isArchive,
  ) {
    return _queryAdapter.queryListStream(
        'select * from listHadithView where isArchive=?5 and      name like ?1 order by       (case when name=?2 then 1 when name like ?3 then 2 when name like ?4       then 3 else 4 end ),listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithViewOld(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            listPos: row['listPos'] as int),
        arguments: [name, or1, or2, or3, isArchive ? 1 : 0],
        queryableName: 'listHadithView',
        isView: true);
  }

  @override
  Stream<List<ListHadithViewOld>> getAllArchivedListViews() {
    return _queryAdapter.queryListStream(
        'select * from listHadithView  where isArchive=1 union        select * from listVerseView where isArchive=1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithViewOld(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            listPos: row['listPos'] as int),
        queryableName: 'listHadithView',
        isView: true);
  }

  @override
  Stream<List<ListVerseViewOld>> getListVerseViews(bool isArchive) {
    return _queryAdapter.queryListStream(
        'select * from listVerseView where isArchive=?1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListVerseViewOld(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            listPos: row['listPos'] as int),
        arguments: [isArchive ? 1 : 0],
        queryableName: 'listVerseView',
        isView: true);
  }

  @override
  Stream<List<ListVerseViewOld>> getSearchResultVerseViews(
    String name,
    String or1,
    String or2,
    String or3,
    bool isArchive,
  ) {
    return _queryAdapter.queryListStream(
        'select * from listVerseView where isArchive=?5 and      name like ?1 order by       (case when name=?2 then 1 when name like ?3 then 2 when name like ?4       then 3 else 4 end )',
        mapper: (Map<String, Object?> row) => ListVerseViewOld(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            listPos: row['listPos'] as int),
        arguments: [name, or1, or2, or3, isArchive ? 1 : 0],
        queryableName: 'listVerseView',
        isView: true);
  }

  @override
  Future<void> deleteListHadithWithQuery(int listId) async {
    await _queryAdapter.queryNoReturn('delete from listHadith where listId=?1',
        arguments: [listId]);
  }

  @override
  Future<void> deleteListVerseWithQuery(int listId) async {
    await _queryAdapter.queryNoReturn('delete from listVerse where listId=?1',
        arguments: [listId]);
  }

  @override
  Future<int> insertList(ListEntityOld listEntity) {
    return _listEntityOldInsertionAdapter.insertAndReturnId(
        listEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertHadithList(ListHadithEntityOld listHadithEntity) {
    return _listHadithEntityOldInsertionAdapter.insertAndReturnId(
        listHadithEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertHadithLists(
      List<ListHadithEntityOld> listHadithEntities) {
    return _listHadithEntityOldInsertionAdapter.insertListAndReturnIds(
        listHadithEntities, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertVerseList(ListVerseEntityOld listVerseEntity) {
    return _listVerseEntityOldInsertionAdapter.insertAndReturnId(
        listVerseEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertVerseLists(
      List<ListVerseEntityOld> listVerseEntities) {
    return _listVerseEntityOldInsertionAdapter.insertListAndReturnIds(
        listVerseEntities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateList(ListEntityOld listEntity) {
    return _listEntityOldUpdateAdapter.updateAndReturnChangedRows(
        listEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateHadithList(ListHadithEntityOld listHadithEntity) {
    return _listHadithEntityOldUpdateAdapter.updateAndReturnChangedRows(
        listHadithEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateVerseList(ListVerseEntityOld listVerseEntity) {
    return _listVerseEntityOldUpdateAdapter.updateAndReturnChangedRows(
        listVerseEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteList(ListEntityOld listEntity) {
    return _listEntityOldDeletionAdapter.deleteAndReturnChangedRows(listEntity);
  }

  @override
  Future<int> deleteHadithList(ListHadithEntityOld listHadithEntity) {
    return _listHadithEntityOldDeletionAdapter
        .deleteAndReturnChangedRows(listHadithEntity);
  }

  @override
  Future<int> deleteHadithLists(List<ListHadithEntityOld> listHadithEntities) {
    return _listHadithEntityOldDeletionAdapter
        .deleteListAndReturnChangedRows(listHadithEntities);
  }

  @override
  Future<int> deleteVerseList(ListVerseEntityOld listVerseEntity) {
    return _listVerseEntityOldDeletionAdapter
        .deleteAndReturnChangedRows(listVerseEntity);
  }

  @override
  Future<int> deleteVerseLists(List<ListVerseEntityOld> listVerseEntities) {
    return _listVerseEntityOldDeletionAdapter
        .deleteListAndReturnChangedRows(listVerseEntities);
  }
}

class _$SurahDaoOld extends SurahDaoOld {
  _$SurahDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Surah>> getAllSurah() async {
    return _queryAdapter.queryList('select * from surah',
        mapper: (Map<String, Object?> row) => Surah(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String));
  }

  @override
  Future<List<Surah>> getSearchedSurahes(
    String query,
    String or1,
    String or2,
    String or3,
  ) async {
    return _queryAdapter.queryList(
        'select * from surah where name like ?1 or searchName like ?1      order by (case when searchName=?2 then 1 when searchName like ?3 then 2      when searchName like ?4 then 3 else 4 end)',
        mapper: (Map<String, Object?> row) => Surah(id: row['id'] as int, name: row['name'] as String, searchName: row['searchName'] as String),
        arguments: [query, or1, or2, or3]);
  }

  @override
  Future<Surah?> getSurah(int surahId) async {
    return _queryAdapter.query('select * from Surah where id=?1',
        mapper: (Map<String, Object?> row) => Surah(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String),
        arguments: [surahId]);
  }
}

class _$VerseDaoOld extends VerseDaoOld {
  _$VerseDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Verse>> getVersesWithSurahId(int surahId) async {
    return _queryAdapter.queryList('select * from verse where surahId=?1',
        mapper: (Map<String, Object?> row) => Verse(
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            surahName: row['surahName'] as String?,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        arguments: [surahId]);
  }

  @override
  Future<List<Verse>> getVersesWithCuzNo(int cuzNo) async {
    return _queryAdapter.queryList('select * from verse where cuzNo=?1',
        mapper: (Map<String, Object?> row) => Verse(
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            surahName: row['surahName'] as String?,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            id: row['id'] as int?,
            bookId: row['bookId'] as int),
        arguments: [cuzNo]);
  }

  @override
  Future<List<Verse>> getPagingVerses(
    int limit,
    int page,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S        where V.surahId=S.id limit ?1 offset ?1*((?2)-1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page]);
  }

  @override
  Future<IntData?> getPagingCount() async {
    return _queryAdapter.query('select count(*) data from verse',
        mapper: (Map<String, Object?> row) =>
            IntData(data: row['data'] as int));
  }

  @override
  Future<List<Verse>> getPagingTopicVerses(
    int limit,
    int page,
    int topicId,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S,VerseTopic VT        where V.surahId=S.id and VT.verseId=V.id and VT.topicId=?3        limit ?1 offset ?1*((?2)-1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, topicId]);
  }

  @override
  Future<IntData?> getPagingTopicVersesCount(int topicId) async {
    return _queryAdapter.query(
        'select count(*) data from verse V,VerseTopic VT where VT.verseId=V.id and VT.topicId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [topicId]);
  }

  @override
  Future<List<Verse>> getPagingSurahVerses(
    int limit,
    int page,
    int surahId,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S        where V.surahId=S.id and S.id=?3 limit ?1 offset ?1*((?2)-1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, surahId]);
  }

  @override
  Future<IntData?> getPagingSurahVersesCount(int surahId) async {
    return _queryAdapter.query(
        'select count(*) data from verse V,Surah S where V.surahId=S.id and V.surahId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [surahId]);
  }

  @override
  Future<List<Verse>> getPagingCuzVerses(
    int limit,
    int page,
    int cuzNo,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S,Cuz C        where V.surahId=S.id and C.cuzNo=V.cuzNo and V.cuzNo=?3 limit ?1 offset ?1*((?2)-1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, cuzNo]);
  }

  @override
  Future<IntData?> getPagingCuzVersesCount(int cuzNo) async {
    return _queryAdapter.query(
        'select count(*) data from verse V,Cuz C where C.cuzNo=V.cuzNo and V.cuzNo=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [cuzNo]);
  }

  @override
  Future<List<Verse>> getPagingListVerses(
    int limit,
    int page,
    int listId,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S,ListVerse LV       where V.surahId=S.id and LV.verseId=V.id and LV.listId=?3 order by LV.pos desc limit ?1 offset ?1*((?2)-1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, listId]);
  }

  @override
  Future<IntData?> getPagingListVersesCount(int listId) async {
    return _queryAdapter.query(
        'select count(*) data from verse V,ListVerse LV where LV.verseId=V.id and LV.listId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<Verse>> getListVerses(int listId) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S,ListVerse LV       where V.surahId=S.id and LV.verseId=V.id and LV.listId=?1 order by LV.pos desc',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [listId]);
  }

  @override
  Future<IntData?> getSearchWithVerseCountWithRegEx(String regExp) async {
    return _queryAdapter.query(
        'select count(id) data from verse V where lower(content)  REGEXP lower(?1)',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [regExp]);
  }

  @override
  Future<List<Verse>> getPagingSearchVersesWithRegEx(
    int limit,
    int page,
    String regExp,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S       where V.surahId=S.id and  lower(content)  REGEXP lower(?3)       limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, regExp]);
  }

  @override
  Future<IntData?> getSearchWithVerseCount(String query) async {
    return _queryAdapter.query(
        'select count(id) data from verse V where lower(content) Like lower(?1)',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [query]);
  }

  @override
  Future<List<Verse>> getPagingSearchVerses(
    int limit,
    int page,
    String query,
  ) async {
    return _queryAdapter.queryList(
        'select V.*,S.name surahName from verse V,Surah S       where V.surahId=S.id and  lower(content)  Like lower(?3)       limit ?1 offset ?1 * ((?2) -1)',
        mapper: (Map<String, Object?> row) => Verse(surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, surahName: row['surahName'] as String?, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, id: row['id'] as int?, bookId: row['bookId'] as int),
        arguments: [limit, page, query]);
  }

  @override
  Future<List<VerseArabic>> getArabicVersesWithId(int mealId) async {
    return _queryAdapter.queryList('select * from verseArabic where mealId=?1',
        mapper: (Map<String, Object?> row) => VerseArabic(
            id: row['id'] as int?,
            mealId: row['mealId'] as int,
            verse: row['verse'] as String,
            verseNumber: row['verseNumber'] as String,
            verseNumberTr: row['verseNumberTr'] as int),
        arguments: [mealId]);
  }
}

class _$TopicDaoOld extends TopicDaoOld {
  _$TopicDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Topic>> getHadithTopics(int hadithId) async {
    return _queryAdapter.queryList(
        'select T.* from topic T,HadithTopic HT      where T.id=HT.topicId and HT.hadithId=?1',
        mapper: (Map<String, Object?> row) => Topic(id: row['id'] as int?, name: row['name'] as String, sectionId: row['sectionId'] as int),
        arguments: [hadithId]);
  }

  @override
  Future<List<Topic>> getTopicsWithSectionId(int sectionId) async {
    return _queryAdapter.queryList('select * from topic where sectionId=?1',
        mapper: (Map<String, Object?> row) => Topic(
            id: row['id'] as int?,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int),
        arguments: [sectionId]);
  }

  @override
  Future<List<ItemCountModel>> getHadithTopicWithSectionId(
      int sectionId) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(HT.hadithId)itemCount from      topic T,HadithTopic HT where T.id=HT.topicId and T.sectionId=?1 group by T.id',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [sectionId]);
  }

  @override
  Future<List<ItemCountModel>> getSearchHadithTopicWithSectionId(
    int sectionId,
    String query,
    String or1,
    String or2,
    String or3,
  ) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(HT.hadithId)itemCount from      topic T,HadithTopic HT where T.id=HT.topicId and T.sectionId=?1 and T.name like ?2      group by T.id order by (case when T.name=?3 then 1 when T.name like ?4 then 2 when T.name like ?5       then 3 else 4 end )',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [sectionId, query, or1, or2, or3]);
  }

  @override
  Future<List<ItemCountModel>> getHadithTopicWithBookId(int bookId) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(HT.hadithId)itemCount from      topic T,HadithTopic HT,section S where T.id=HT.topicId and S.id=T.sectionId      and S.bookId=?1 group by T.id',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId]);
  }

  @override
  Future<List<ItemCountModel>> getSearchHadithTopicWithBookId(
    int bookId,
    String query,
    String or1,
    String or2,
    String or3,
  ) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(HT.hadithId)itemCount from      topic T,HadithTopic HT,Section S where T.id=HT.topicId and S.id=T.sectionId and S.bookId=?1 and T.name like ?2      group by T.id order by (case when T.name=?3 then 1 when T.name like ?4 then 2 when T.name like ?5       then 3 else 4 end )',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId, query, or1, or2, or3]);
  }

  @override
  Future<List<ItemCountModel>> getVerseTopicWithSectionId(int sectionId) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(VT.verseId)itemCount from     topic T,VerseTopic VT where T.id=VT.topicId and T.sectionId=?1 group by T.id',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [sectionId]);
  }

  @override
  Future<List<ItemCountModel>> getSearchVerseTopicWithSectionId(
    int sectionId,
    String query,
    String or1,
    String or2,
    String or3,
  ) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(VT.verseId)itemCount from     topic T,VerseTopic VT where T.id=VT.topicId and T.sectionId=?1 and T.name like ?2      group by T.id order by (case when T.name=?3 then 1 when T.name like ?4 then 2 when T.name like ?5       then 3 else 4 end )',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [sectionId, query, or1, or2, or3]);
  }

  @override
  Future<List<ItemCountModel>> getVerseTopicWithBookId(int bookId) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(VT.verseId)itemCount from     topic T,VerseTopic VT,Section S where T.id=VT.topicId and      S.id=T.sectionId and S.bookId=?1 group by T.id',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId]);
  }

  @override
  Future<List<ItemCountModel>> getSearchVerseTopicWithBookId(
    int bookId,
    String query,
    String or1,
    String or2,
    String or3,
  ) async {
    return _queryAdapter.queryList(
        'select T.id,T.name,count(VT.verseId)itemCount from     topic T,VerseTopic VT,Section S where T.id=VT.topicId and S.id=T.sectionId and S.bookId=?1     and T.name like ?2      group by T.id order by (case when T.name=?3 then 1 when T.name like ?4 then 2 when T.name like ?5     then 3 else 4 end )',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId, query, or1, or2, or3]);
  }

  @override
  Future<List<ItemCountModel>> getSectionWithBookId(int bookId) async {
    return _queryAdapter.queryList(
        'select S.id,S.name,count(T.id)itemCount from section S,Topic T        where S.id=T.sectionId and S.bookId=?1 group by S.id',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId]);
  }

  @override
  Future<IntData?> getTopicCountsWithBookId(int bookId) async {
    return _queryAdapter.query(
        'select count(T.id) data from topic T,Section S where T.sectionId=S.id and S.bookId=?1',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [bookId]);
  }

  @override
  Future<List<ItemCountModel>> getSearchSectionWithBookId(
    int bookId,
    String query,
    String or1,
    String or2,
    String or3,
  ) async {
    return _queryAdapter.queryList(
        'select S.id,S.name,count(T.id)itemCount from section S,Topic T        where S.id=T.sectionId and S.bookId=?1 and S.name like ?2 group by S.id        order by (case when S.name=?3 then 1 when S.name like ?4 then 2 when S.name like ?5       then 3 else 4 end )',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId, query, or1, or2, or3]);
  }
}

class _$SectionDao extends SectionDao {
  _$SectionDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Section>> getSectionsWithBookId(int bookId) async {
    return _queryAdapter.queryList('select * from section where bookId=?1',
        mapper: (Map<String, Object?> row) => Section(
            id: row['id'] as int?,
            name: row['name'] as String,
            bookId: row['bookId'] as int),
        arguments: [bookId]);
  }

  @override
  Future<List<ItemCountModel>> getSectionCountWithBookId(int bookId) async {
    return _queryAdapter.queryList(
        'select S.id,S.name,count(T.id)itemCount from     section S, Topic T where S.id=T.sectionId and S.bookId=?1 group by S.id',
        mapper: (Map<String, Object?> row) => ItemCountModel(id: row['id'] as int, name: row['name'] as String, itemCount: row['itemCount'] as int),
        arguments: [bookId]);
  }
}

class _$SavePointDaoOld extends SavePointDaoOld {
  _$SavePointDaoOld(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _savePointEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'savePoints',
            (SavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener),
        _savePointEntityOldUpdateAdapter = UpdateAdapter(
            database,
            'savePoints',
            ['id'],
            (SavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener),
        _savePointEntityOldDeletionAdapter = DeletionAdapter(
            database,
            'savePoints',
            ['id'],
            (SavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SavePointEntityOld>
      _savePointEntityOldInsertionAdapter;

  final UpdateAdapter<SavePointEntityOld> _savePointEntityOldUpdateAdapter;

  final DeletionAdapter<SavePointEntityOld> _savePointEntityOldDeletionAdapter;

  @override
  Future<SavePointEntityOld?> getSavePoint(
    int savePointType,
    String parentKey,
    int autoType,
  ) async {
    return _queryAdapter.query(
        'select * from savePoints where savePointType=?1    and parentKey=?2 and autoType=?3 order by modifiedDate desc limit 1',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(id: row['id'] as int?, itemIndexPos: row['itemIndexPos'] as int, title: row['title'] as String, autoType: row['autoType'] as int, modifiedDate: row['modifiedDate'] as String?, savePointType: row['savePointType'] as int, bookScope: row['bookScope'] as int, parentKey: row['parentKey'] as String, parentName: row['parentName'] as String),
        arguments: [savePointType, parentKey, autoType]);
  }

  @override
  Future<SavePointEntityOld?> getSavePointWithId(int id) async {
    return _queryAdapter.query('select * from savePoints where id=?1',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String?,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [id]);
  }

  @override
  Stream<List<SavePointEntityOld>> getStreamSavePoints(
    int savePointType,
    String parentKey,
  ) {
    return _queryAdapter.queryListStream(
        'select * from savePoints where    savePointType=?1 and parentKey=?2    order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String?,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [savePointType, parentKey],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Stream<List<SavePointEntityOld>> getStreamSavePointsWithBookIdBinary(
    int savePointType,
    int bookScope,
  ) {
    return _queryAdapter.queryListStream(
        'select * from savePoints where    savePointType=?1 and bookScope=?2    order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String?,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [savePointType, bookScope],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Future<SavePointEntityOld?> getAutoSavePointWithBookIdBinary(
    int savePointType,
    int bookScope,
    int autoType,
  ) async {
    return _queryAdapter.query(
        'select * from savePoints where savePointType=?1    and bookScope=?2 and autoType=?3 order by modifiedDate desc limit 1',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(id: row['id'] as int?, itemIndexPos: row['itemIndexPos'] as int, title: row['title'] as String, autoType: row['autoType'] as int, modifiedDate: row['modifiedDate'] as String?, savePointType: row['savePointType'] as int, bookScope: row['bookScope'] as int, parentKey: row['parentKey'] as String, parentName: row['parentName'] as String),
        arguments: [savePointType, bookScope, autoType]);
  }

  @override
  Stream<List<SavePointEntityOld>> getStreamSavePointsWithBook(
      List<int> bookScopes) {
    const offset = 1;
    final _sqliteVariablesForBookScopes =
        Iterable<String>.generate(bookScopes.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'select * from savePoints where bookScope in(' +
            _sqliteVariablesForBookScopes +
            ')    order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String?,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [...bookScopes],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Stream<List<SavePointEntityOld>> getStreamSavePointsWithBookFilter(
    List<int> bookScopes,
    int savePointType,
  ) {
    const offset = 2;
    final _sqliteVariablesForBookScopes =
        Iterable<String>.generate(bookScopes.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'select * from savePoints where bookScope in(' +
            _sqliteVariablesForBookScopes +
            ')      and savePointType=?1 order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String?,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [savePointType, ...bookScopes],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Future<void> deleteSavePointWithQuery(
    int savePointType,
    String parentKey,
  ) async {
    await _queryAdapter.queryNoReturn(
        'delete from savePoints where savePointType=?1 and parentKey=?2',
        arguments: [savePointType, parentKey]);
  }

  @override
  Future<int> insertSavePoint(SavePointEntityOld savePoint) {
    return _savePointEntityOldInsertionAdapter.insertAndReturnId(
        savePoint, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateSavePoint(SavePointEntityOld savePoint) {
    return _savePointEntityOldUpdateAdapter.updateAndReturnChangedRows(
        savePoint, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteSavePoint(SavePointEntityOld savePoint) {
    return _savePointEntityOldDeletionAdapter
        .deleteAndReturnChangedRows(savePoint);
  }
}

class _$TopicSavePointDaoOld extends TopicSavePointDaoOld {
  _$TopicSavePointDaoOld(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _topicSavePointEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'topicSavePoint',
            (TopicSavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _topicSavePointEntityOldUpdateAdapter = UpdateAdapter(
            database,
            'topicSavePoint',
            ['id'],
            (TopicSavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _topicSavePointEntityOldDeletionAdapter = DeletionAdapter(
            database,
            'topicSavePoint',
            ['id'],
            (TopicSavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TopicSavePointEntityOld>
      _topicSavePointEntityOldInsertionAdapter;

  final UpdateAdapter<TopicSavePointEntityOld>
      _topicSavePointEntityOldUpdateAdapter;

  final DeletionAdapter<TopicSavePointEntityOld>
      _topicSavePointEntityOldDeletionAdapter;

  @override
  Stream<TopicSavePointEntityOld?> getStreamTopicSavePointEntity(
    int type,
    String parentKey,
  ) {
    return _queryAdapter.queryStream(
        'select * from topicSavePoint where type=?1 and parentKey=?2      order by id desc limit 1',
        mapper: (Map<String, Object?> row) => TopicSavePointEntityOld(
            id: row['id'] as int?,
            pos: row['pos'] as int,
            type: row['type'] as int,
            parentKey: row['parentKey'] as String),
        arguments: [type, parentKey],
        queryableName: 'topicSavePoint',
        isView: false);
  }

  @override
  Future<TopicSavePointEntityOld?> getTopicSavePointEntity(
    int type,
    String parentKey,
  ) async {
    return _queryAdapter.query(
        'select * from topicSavePoint where type=?1 and parentKey=?2      order by id desc limit 1',
        mapper: (Map<String, Object?> row) => TopicSavePointEntityOld(id: row['id'] as int?, pos: row['pos'] as int, type: row['type'] as int, parentKey: row['parentKey'] as String),
        arguments: [type, parentKey]);
  }

  @override
  Future<int> insertTopicSavePoint(
      TopicSavePointEntityOld topicSavePointEntity) {
    return _topicSavePointEntityOldInsertionAdapter.insertAndReturnId(
        topicSavePointEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateTopicSavePoint(
      TopicSavePointEntityOld topicSavePointEntity) {
    return _topicSavePointEntityOldUpdateAdapter.updateAndReturnChangedRows(
        topicSavePointEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTopicSavePoint(
      TopicSavePointEntityOld topicSavePointEntity) {
    return _topicSavePointEntityOldDeletionAdapter
        .deleteAndReturnChangedRows(topicSavePointEntity);
  }
}

class _$HistoryDaoOld extends HistoryDaoOld {
  _$HistoryDaoOld(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _historyEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (HistoryEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _historyEntityOldUpdateAdapter = UpdateAdapter(
            database,
            'History',
            ['id'],
            (HistoryEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _historyEntityOldDeletionAdapter = DeletionAdapter(
            database,
            'History',
            ['id'],
            (HistoryEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HistoryEntityOld> _historyEntityOldInsertionAdapter;

  final UpdateAdapter<HistoryEntityOld> _historyEntityOldUpdateAdapter;

  final DeletionAdapter<HistoryEntityOld> _historyEntityOldDeletionAdapter;

  @override
  Stream<List<HistoryEntityOld>> getStreamHistoryWithOrigin(int originId) {
    return _queryAdapter.queryListStream(
        'select * from history where originType=?1 order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => HistoryEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        arguments: [originId],
        queryableName: 'history',
        isView: false);
  }

  @override
  Future<HistoryEntityOld?> getHistoryEntity(
    int originId,
    String name,
  ) async {
    return _queryAdapter.query(
        'select * from history where originType=?1 and name=?2',
        mapper: (Map<String, Object?> row) => HistoryEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        arguments: [originId, name]);
  }

  @override
  Future<int> insertHistory(HistoryEntityOld historyEntity) {
    return _historyEntityOldInsertionAdapter.insertAndReturnId(
        historyEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateHistory(HistoryEntityOld historyEntity) {
    return _historyEntityOldUpdateAdapter.updateAndReturnChangedRows(
        historyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteHistory(HistoryEntityOld historyEntity) {
    return _historyEntityOldDeletionAdapter
        .deleteAndReturnChangedRows(historyEntity);
  }

  @override
  Future<int> deleteHistories(List<HistoryEntityOld> historyEntities) {
    return _historyEntityOldDeletionAdapter
        .deleteListAndReturnChangedRows(historyEntities);
  }
}

class _$BackupMetaDao extends BackupMetaDao {
  _$BackupMetaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _backupMetaInsertionAdapter = InsertionAdapter(
            database,
            'BackupMeta',
            (BackupMeta item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'updatedDate': item.updatedDate,
                  'isAuto': item.isAuto ? 1 : 0
                },
            changeListener),
        _backupMetaUpdateAdapter = UpdateAdapter(
            database,
            'BackupMeta',
            ['id'],
            (BackupMeta item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'updatedDate': item.updatedDate,
                  'isAuto': item.isAuto ? 1 : 0
                },
            changeListener),
        _backupMetaDeletionAdapter = DeletionAdapter(
            database,
            'BackupMeta',
            ['id'],
            (BackupMeta item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'updatedDate': item.updatedDate,
                  'isAuto': item.isAuto ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BackupMeta> _backupMetaInsertionAdapter;

  final UpdateAdapter<BackupMeta> _backupMetaUpdateAdapter;

  final DeletionAdapter<BackupMeta> _backupMetaDeletionAdapter;

  @override
  Future<List<BackupMeta>> getNonAutoBackupMetaWithOffset(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'select * from backupMeta where isAuto=0 order by updatedDate desc limit ?1 offset ?2',
        mapper: (Map<String, Object?> row) => BackupMeta(fileName: row['fileName'] as String, id: row['id'] as int?, updatedDate: row['updatedDate'] as String, isAuto: (row['isAuto'] as int) != 0),
        arguments: [limit, offset]);
  }

  @override
  Future<List<BackupMeta>> getAutoBackupMetaWithOffset(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'select * from backupMeta where isAuto=1 order by updatedDate desc limit ?1 offset ?2',
        mapper: (Map<String, Object?> row) => BackupMeta(fileName: row['fileName'] as String, id: row['id'] as int?, updatedDate: row['updatedDate'] as String, isAuto: (row['isAuto'] as int) != 0),
        arguments: [limit, offset]);
  }

  @override
  Future<IntData?> getNonAutoBackupMetaSize() async {
    return _queryAdapter.query(
        'select count(*) data from backupMeta where isAuto=0',
        mapper: (Map<String, Object?> row) =>
            IntData(data: row['data'] as int));
  }

  @override
  Future<IntData?> getAutoBackupMetaSize() async {
    return _queryAdapter.query(
        'select count(*) data from backupMeta where isAuto=1',
        mapper: (Map<String, Object?> row) =>
            IntData(data: row['data'] as int));
  }

  @override
  Future<BackupMeta?> getFirstUpdatedAutoBackupMeta() async {
    return _queryAdapter.query(
        'select * from backupMeta where isAuto=1 order by updatedDate limit 1',
        mapper: (Map<String, Object?> row) => BackupMeta(
            fileName: row['fileName'] as String,
            id: row['id'] as int?,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0));
  }

  @override
  Future<BackupMeta?> getFirstUpdatedNonAutoBackupMeta() async {
    return _queryAdapter.query(
        'select * from backupMeta where isAuto=0 order by updatedDate limit 1',
        mapper: (Map<String, Object?> row) => BackupMeta(
            fileName: row['fileName'] as String,
            id: row['id'] as int?,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0));
  }

  @override
  Stream<List<BackupMeta>> getStreamBackupMetas() {
    return _queryAdapter.queryListStream(
        'select * from backupMeta order by updatedDate desc',
        mapper: (Map<String, Object?> row) => BackupMeta(
            fileName: row['fileName'] as String,
            id: row['id'] as int?,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0),
        queryableName: 'backupMeta',
        isView: false);
  }

  @override
  Future<BackupMeta?> getLastBackupMeta() async {
    return _queryAdapter.query(
        'select * from backupMeta order by updatedDate desc limit 1',
        mapper: (Map<String, Object?> row) => BackupMeta(
            fileName: row['fileName'] as String,
            id: row['id'] as int?,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0));
  }

  @override
  Future<void> deleteBackupMetaWithQuery() async {
    await _queryAdapter.queryNoReturn('delete from backupMeta');
  }

  @override
  Future<List<int>> insertBackupMetas(List<BackupMeta> backupMetas) {
    return _backupMetaInsertionAdapter.insertListAndReturnIds(
        backupMetas, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertBackupMeta(BackupMeta backupMeta) {
    return _backupMetaInsertionAdapter.insertAndReturnId(
        backupMeta, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateBackupMetas(List<BackupMeta> backupMetas) {
    return _backupMetaUpdateAdapter.updateListAndReturnChangedRows(
        backupMetas, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateBackupMeta(BackupMeta backupMeta) {
    return _backupMetaUpdateAdapter.updateAndReturnChangedRows(
        backupMeta, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteBackupMeta(BackupMeta backupMeta) {
    return _backupMetaDeletionAdapter.deleteAndReturnChangedRows(backupMeta);
  }

  @override
  Future<int> deleteBackupMetas(List<BackupMeta> backupMetas) {
    return _backupMetaDeletionAdapter
        .deleteListAndReturnChangedRows(backupMetas);
  }
}

class _$BackupDao extends BackupDao {
  _$BackupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _historyEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (HistoryEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _listEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'list',
            (ListEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'listHadith',
            (ListHadithEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'listVerse',
            (ListVerseEntityOld item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _savePointEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'savePoints',
            (SavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener),
        _topicSavePointEntityOldInsertionAdapter = InsertionAdapter(
            database,
            'topicSavePoint',
            (TopicSavePointEntityOld item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _counterEntityInsertionAdapter = InsertionAdapter(
            database,
            'counters',
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'type': item.type,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener),
        _counterEntityDeletionAdapter = DeletionAdapter(
            database,
            'counters',
            ['id'],
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'type': item.type,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HistoryEntityOld> _historyEntityOldInsertionAdapter;

  final InsertionAdapter<ListEntityOld> _listEntityOldInsertionAdapter;

  final InsertionAdapter<ListHadithEntityOld>
      _listHadithEntityOldInsertionAdapter;

  final InsertionAdapter<ListVerseEntityOld>
      _listVerseEntityOldInsertionAdapter;

  final InsertionAdapter<SavePointEntityOld>
      _savePointEntityOldInsertionAdapter;

  final InsertionAdapter<TopicSavePointEntityOld>
      _topicSavePointEntityOldInsertionAdapter;

  final InsertionAdapter<CounterEntity> _counterEntityInsertionAdapter;

  final DeletionAdapter<CounterEntity> _counterEntityDeletionAdapter;

  @override
  Future<List<HistoryEntityOld>> getHistories() async {
    return _queryAdapter.queryList('select * from history',
        mapper: (Map<String, Object?> row) => HistoryEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String));
  }

  @override
  Future<List<ListEntityOld>> getLists() async {
    return _queryAdapter.queryList('select * from list where isRemovable=1',
        mapper: (Map<String, Object?> row) => ListEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int));
  }

  @override
  Future<List<ListHadithEntityOld>> getHadithListEntities() async {
    return _queryAdapter.queryList('select * from ListHadith',
        mapper: (Map<String, Object?> row) => ListHadithEntityOld(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int));
  }

  @override
  Future<List<ListVerseEntityOld>> getVerseListEntities() async {
    return _queryAdapter.queryList('select * from listVerse',
        mapper: (Map<String, Object?> row) => ListVerseEntityOld(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int));
  }

  @override
  Future<List<SavePointEntityOld>> getSavePoints() async {
    return _queryAdapter.queryList('select * from savepoint',
        mapper: (Map<String, Object?> row) => SavePointEntityOld(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String?,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String));
  }

  @override
  Future<List<TopicSavePointEntityOld>> getTopicSavePoints() async {
    return _queryAdapter.queryList('select * from topicSavePoint',
        mapper: (Map<String, Object?> row) => TopicSavePointEntityOld(
            id: row['id'] as int?,
            pos: row['pos'] as int,
            type: row['type'] as int,
            parentKey: row['parentKey'] as String));
  }

  @override
  Future<List<CounterEntity>> getCounterEntities() async {
    return _queryAdapter.queryList('select * from counters where isRemovable=1',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            orderItem: row['orderItem'] as int,
            goal: row['goal'] as int?,
            type: row['type'] as int,
            lastCounter: row['lastCounter'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            meaning: row['meaning'] as String?));
  }

  @override
  Future<void> deleteHistories() async {
    await _queryAdapter.queryNoReturn('delete from history');
  }

  @override
  Future<void> deleteLists() async {
    await _queryAdapter.queryNoReturn('delete from list where isRemovable=1');
  }

  @override
  Future<void> deleteHadithLists() async {
    await _queryAdapter.queryNoReturn('delete from ListHadith');
  }

  @override
  Future<void> deleteVerseLists() async {
    await _queryAdapter.queryNoReturn('delete from listVerse');
  }

  @override
  Future<void> deleteSavePoints() async {
    await _queryAdapter.queryNoReturn('delete from savepoint');
  }

  @override
  Future<void> deleteTopicSavePoints() async {
    await _queryAdapter.queryNoReturn('delete from topicSavePoint');
  }

  @override
  Future<void> deleteCounterEntitiesWithQuery() async {
    await _queryAdapter
        .queryNoReturn('delete from counters where isRemovable = 1');
  }

  @override
  Future<void> insertHistories(List<HistoryEntityOld> histories) async {
    await _historyEntityOldInsertionAdapter.insertList(
        histories, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertLists(List<ListEntityOld> lists) async {
    await _listEntityOldInsertionAdapter.insertList(
        lists, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHadithLists(List<ListHadithEntityOld> hadithLists) async {
    await _listHadithEntityOldInsertionAdapter.insertList(
        hadithLists, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertVerseLists(List<ListVerseEntityOld> verseLists) async {
    await _listVerseEntityOldInsertionAdapter.insertList(
        verseLists, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSavePoints(
      List<SavePointEntityOld> savePointEntities) async {
    await _savePointEntityOldInsertionAdapter.insertList(
        savePointEntities, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTopicSavePoints(
      List<TopicSavePointEntityOld> topicSavePoints) async {
    await _topicSavePointEntityOldInsertionAdapter.insertList(
        topicSavePoints, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertCounterEntities(
      List<CounterEntity> counterEntities) async {
    await _counterEntityInsertionAdapter.insertList(
        counterEntities, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHistory(HistoryEntityOld history) async {
    await _historyEntityOldInsertionAdapter.insert(
        history, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertList(ListEntityOld list) async {
    await _listEntityOldInsertionAdapter.insert(
        list, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHadithList(ListHadithEntityOld hadithList) async {
    await _listHadithEntityOldInsertionAdapter.insert(
        hadithList, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertVerseList(ListVerseEntityOld verseList) async {
    await _listVerseEntityOldInsertionAdapter.insert(
        verseList, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSavePoint(SavePointEntityOld savePoint) async {
    await _savePointEntityOldInsertionAdapter.insert(
        savePoint, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTopicSavePoint(
      TopicSavePointEntityOld topicSavePointEntity) async {
    await _topicSavePointEntityOldInsertionAdapter.insert(
        topicSavePointEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertCounterEntity(CounterEntity counterEntity) async {
    await _counterEntityInsertionAdapter.insert(
        counterEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteCounterEntities(List<CounterEntity> entities) async {
    await _counterEntityDeletionAdapter.deleteList(entities);
  }
}

class _$UserInfoDao extends UserInfoDao {
  _$UserInfoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInfoEntityInsertionAdapter = InsertionAdapter(
            database,
            'userInfo',
            (UserInfoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'img': item.img
                },
            changeListener),
        _userInfoEntityUpdateAdapter = UpdateAdapter(
            database,
            'userInfo',
            ['id'],
            (UserInfoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'img': item.img
                },
            changeListener),
        _userInfoEntityDeletionAdapter = DeletionAdapter(
            database,
            'userInfo',
            ['id'],
            (UserInfoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'img': item.img
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserInfoEntity> _userInfoEntityInsertionAdapter;

  final UpdateAdapter<UserInfoEntity> _userInfoEntityUpdateAdapter;

  final DeletionAdapter<UserInfoEntity> _userInfoEntityDeletionAdapter;

  @override
  Stream<UserInfoEntity?> getStreamUserInfoWithId(String userId) {
    return _queryAdapter.queryStream('select * from userInfo where userId=?1',
        mapper: (Map<String, Object?> row) => UserInfoEntity(
            userId: row['userId'] as String,
            img: row['img'] as Uint8List?,
            id: row['id'] as int?),
        arguments: [userId],
        queryableName: 'userInfo',
        isView: false);
  }

  @override
  Future<UserInfoEntity?> getUserInfoWithId(String userId) async {
    return _queryAdapter.query('select * from userInfo where userId=?1',
        mapper: (Map<String, Object?> row) => UserInfoEntity(
            userId: row['userId'] as String,
            img: row['img'] as Uint8List?,
            id: row['id'] as int?),
        arguments: [userId]);
  }

  @override
  Future<void> deleteAllDataWithQuery() async {
    await _queryAdapter.queryNoReturn('delete from userInfo');
  }

  @override
  Future<int> insertUserInfo(UserInfoEntity userInfoEntity) {
    return _userInfoEntityInsertionAdapter.insertAndReturnId(
        userInfoEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateUserInfo(UserInfoEntity userInfoEntity) {
    return _userInfoEntityUpdateAdapter.updateAndReturnChangedRows(
        userInfoEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteUserInfo(UserInfoEntity userInfoEntity) {
    return _userInfoEntityDeletionAdapter
        .deleteAndReturnChangedRows(userInfoEntity);
  }
}

class _$AudioEditionDaoOld extends AudioEditionDaoOld {
  _$AudioEditionDaoOld(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _audioEditionInsertionAdapter = InsertionAdapter(
            database,
            'AudioEdition',
            (AudioEdition item) => <String, Object?>{
                  'identifier': item.identifier,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0,
                  'fileName': item.fileName
                },
            changeListener),
        _audioEditionUpdateAdapter = UpdateAdapter(
            database,
            'AudioEdition',
            ['identifier'],
            (AudioEdition item) => <String, Object?>{
                  'identifier': item.identifier,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0,
                  'fileName': item.fileName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AudioEdition> _audioEditionInsertionAdapter;

  final UpdateAdapter<AudioEdition> _audioEditionUpdateAdapter;

  @override
  Stream<List<AudioEdition>> getStreamEditions() {
    return _queryAdapter.queryListStream('select * from audioEdition',
        mapper: (Map<String, Object?> row) => AudioEdition(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        queryableName: 'audioEdition',
        isView: false);
  }

  @override
  Stream<AudioEdition?> getSelectedStreamEdition() {
    return _queryAdapter.queryStream(
        'select * from audioEdition where isSelected = 1',
        mapper: (Map<String, Object?> row) => AudioEdition(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        queryableName: 'audioEdition',
        isView: false);
  }

  @override
  Future<List<AudioEdition>> getEditions() async {
    return _queryAdapter.queryList('select * from audioEdition',
        mapper: (Map<String, Object?> row) => AudioEdition(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?));
  }

  @override
  Future<IntData?> isEditionNotEmpty() async {
    return _queryAdapter.query(
        'select exists(select 1 from audioEdition) as data',
        mapper: (Map<String, Object?> row) =>
            IntData(data: row['data'] as int));
  }

  @override
  Future<AudioEdition?> getSelectedEdition() async {
    return _queryAdapter.query(
        'select * from audioEdition where isSelected = 1',
        mapper: (Map<String, Object?> row) => AudioEdition(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?));
  }

  @override
  Future<List<int>> insertEditions(List<AudioEdition> items) {
    return _audioEditionInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAudioEditions(List<AudioEdition> editions) {
    return _audioEditionUpdateAdapter.updateListAndReturnChangedRows(
        editions, OnConflictStrategy.replace);
  }
}

class _$VerseAudioDaoOld extends VerseAudioDaoOld {
  _$VerseAudioDaoOld(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _verseAudioInsertionAdapter = InsertionAdapter(
            database,
            'verseAudio',
            (VerseAudio item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener),
        _verseAudioUpdateAdapter = UpdateAdapter(
            database,
            'verseAudio',
            ['mealId', 'identifier'],
            (VerseAudio item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener),
        _verseAudioDeletionAdapter = DeletionAdapter(
            database,
            'verseAudio',
            ['mealId', 'identifier'],
            (VerseAudio item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VerseAudio> _verseAudioInsertionAdapter;

  final UpdateAdapter<VerseAudio> _verseAudioUpdateAdapter;

  final DeletionAdapter<VerseAudio> _verseAudioDeletionAdapter;

  @override
  Future<List<VerseAudio>> getVerseAudios(
    String identifier,
    List<int> mealIds,
  ) async {
    const offset = 2;
    final _sqliteVariablesForMealIds =
        Iterable<String>.generate(mealIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from verseAudio where identifier = ?1 and    mealId in (' +
            _sqliteVariablesForMealIds +
            ') order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudio(
            mealId: row['mealId'] as int,
            identifier: row['identifier'] as String,
            fileName: row['fileName'] as String?,
            hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [identifier, ...mealIds]);
  }

  @override
  Future<void> deleteVerseAudiosWithQuery(String identifier) async {
    await _queryAdapter.queryNoReturn(
        'delete from verseAudio where identifier = ?1',
        arguments: [identifier]);
  }

  @override
  Future<void> deleteVerseAudioWithQuery(
    String identifier,
    int mealId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'delete from verseAudio where identifier = ?1 and mealId=?2',
        arguments: [identifier, mealId]);
  }

  @override
  Future<List<VerseAudio>> getVerseAudiosWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudio VA, verse V where V.id = VA.mealId and      V.cuzNo=?1 and VA.identifier=?2 order by VA.mealId',
        mapper: (Map<String, Object?> row) => VerseAudio(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseAudio>> getVerseAudiosWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudio VA, verse V where V.id = VA.mealId and      V.surahId=?1 and VA.identifier=?2 order by VA.mealId',
        mapper: (Map<String, Object?> row) => VerseAudio(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier]);
  }

  @override
  Future<IntData?> isVerseAudiosExistsWithSurah(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from surahAudioView where surahId=?1 and identifier=?2 and isDownloaded=1) data',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [surahId, identifier]);
  }

  @override
  Future<IntData?> isVerseAudiosExistsWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from cuzAudioView where cuzNo=?1 and identifier=?2 and isDownloaded=1) data',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<IntData?> isVerseAudiosExistsWithPage(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 7 from Verse V, VerseAudio VA where V.id = VA.mealId and      VA.identifier = ?2 and V.pageNo=?1 group by V.pageNo      having count(id)=(select count(*)from Verse where pageNo=?1) ) data',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<IntData?> isVerseAudiosExistsWithMeal(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from VerseAudio    where  identifier = ?2 and mealId=?1) data',
        mapper: (Map<String, Object?> row) => IntData(data: row['data'] as int),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseAudio>> getUnEditedVerseAudiosWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA,Verse V where V.id = VA.mealId and VA.identifier=?2 and     VA.hasEdited=0 and V.cuzNo=?1',
        mapper: (Map<String, Object?> row) => VerseAudio(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseAudio>> getUnEditedVerseAudiosWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA,Verse V where V.id = VA.mealId and VA.identifier=?2 and     VA.hasEdited=0 and V.surahId=?1',
        mapper: (Map<String, Object?> row) => VerseAudio(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier]);
  }

  @override
  Future<int> insertVerseAudio(VerseAudio verseAudio) {
    return _verseAudioInsertionAdapter.insertAndReturnId(
        verseAudio, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertVerseAudios(List<VerseAudio> verseAudios) {
    return _verseAudioInsertionAdapter.insertListAndReturnIds(
        verseAudios, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateVerseAudios(List<VerseAudio> verseAudios) async {
    await _verseAudioUpdateAdapter.updateList(
        verseAudios, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteVerseAudios(List<VerseAudio> verseAudios) async {
    await _verseAudioDeletionAdapter.deleteList(verseAudios);
  }
}

class _$VerseArabicDaoOld extends VerseArabicDaoOld {
  _$VerseArabicDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<VerseArabic>> getNotDownloadedCuzVerses(
    String identifier,
    int cuzNo,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V where VA.mealId = V.id and V.cuzNo=?2 and          VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and          V.cuzNo=?2 and A.identifier = ?1)',
        mapper: (Map<String, Object?> row) => VerseArabic(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [identifier, cuzNo]);
  }

  @override
  Future<List<VerseArabic>> getNotDownloadedSurahVerses(
    String identifier,
    int surahId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V where VA.mealId = V.id and V.surahId=?2 and          VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and          V.surahId=?2 and A.identifier = ?1)',
        mapper: (Map<String, Object?> row) => VerseArabic(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [identifier, surahId]);
  }

  @override
  Future<List<VerseArabic>> getNotDownloadedPageVerses(
    String identifier,
    int pageNo,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V where VA.mealId = V.id and V.pageNo=?2 and          VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and          V.pageNo=?2 and A.identifier = ?1)',
        mapper: (Map<String, Object?> row) => VerseArabic(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [identifier, pageNo]);
  }

  @override
  Future<List<VerseArabic>> getNotDownloadedMealIdVerses(
    String identifier,
    int mealId,
  ) async {
    return _queryAdapter.queryList(
        'select * from VerseArabic where mealId=?2 and          mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and          V.id=?2 and A.identifier = ?1)',
        mapper: (Map<String, Object?> row) => VerseArabic(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [identifier, mealId]);
  }
}

class _$VerseAudioStateDao extends VerseAudioStateDao {
  _$VerseAudioStateDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<VerseAudioEntityOld>> getAudioStateWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,     V.pageNo,E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and     VA.mealId = V.id and S.id = V.surahId and cuzNo=?1 and VA.identifier=?2 order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntityOld(surahName: row['surahName'] as String, surahId: row['surahId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, mealId: row['mealId'] as int, editionName: row['editionName'] as String),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntityOld>> getAudioStateWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,V.pageNo,     E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and     VA.mealId = V.id and S.id = V.surahId and surahId=?1 and VA.identifier=?2 order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntityOld(surahName: row['surahName'] as String, surahId: row['surahId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, mealId: row['mealId'] as int, editionName: row['editionName'] as String),
        arguments: [surahId, identifier]);
  }

  @override
  Future<List<VerseAudioEntityOld>> getAudioStateWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,     V.pageNo,E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and     VA.mealId = V.id and S.id = V.surahId and pageNo=?1 and VA.identifier=?2 order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntityOld(surahName: row['surahName'] as String, surahId: row['surahId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, mealId: row['mealId'] as int, editionName: row['editionName'] as String),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntityOld>> getAudioStateWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,VA.fileName,VA.identifier,V.surahId,V.cuzNo,V.verseNumber,S.name surahName,     V.pageNo,E.name editionName from VerseAudio VA, Verse V,Surah S,AudioEdition E where E.identifier = VA.identifier and      VA.mealId = V.id and S.id = V.surahId and mealId=?1 and VA.identifier=?2 order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntityOld(surahName: row['surahName'] as String, surahId: row['surahId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, mealId: row['mealId'] as int, editionName: row['editionName'] as String),
        arguments: [mealId, identifier]);
  }

  @override
  Future<int?> getSurahVersePosition(
    int surahId,
    int mealId,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verse where surahId=?1 and id<=?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [surahId, mealId]);
  }

  @override
  Future<List<DownloadVoiceEntity>> getNotDownloadedMealIdVerses(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from      VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.id=?1 and      VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and      V.id=?1 and A.identifier = ?2) order by mealId',
        mapper: (Map<String, Object?> row) => DownloadVoiceEntity(surahId: row['surahId'] as int, verseId: row['verseId'] as int, verseNumber: row['verseNumber'] as int, cuzNo: row['cuzNo'] as int, surahName: row['surahName'] as String, mealId: row['mealId'] as int),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<DownloadVoiceEntity>> getNotDownloadedSurahVerses(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from      VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.surahId=?1 and      VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and      V.surahId=?1 and A.identifier = ?2) order by mealId',
        mapper: (Map<String, Object?> row) => DownloadVoiceEntity(surahId: row['surahId'] as int, verseId: row['verseId'] as int, verseNumber: row['verseNumber'] as int, cuzNo: row['cuzNo'] as int, surahName: row['surahName'] as String, mealId: row['mealId'] as int),
        arguments: [surahId, identifier]);
  }

  @override
  Future<List<DownloadVoiceEntity>> getNotDownloadedCuzVerses(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from      VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.cuzNo=?1 and      VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and      V.cuzNo=?1 and A.identifier = ?2) order by mealId',
        mapper: (Map<String, Object?> row) => DownloadVoiceEntity(surahId: row['surahId'] as int, verseId: row['verseId'] as int, verseNumber: row['verseNumber'] as int, cuzNo: row['cuzNo'] as int, surahName: row['surahName'] as String, mealId: row['mealId'] as int),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<DownloadVoiceEntity>> getNotDownloadedPageVerses(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.mealId,V.surahId,V.cuzNo,VA.verseNumberTr verseNumber,S.name surahName,VA.id verseId from      VerseArabic VA, Verse V,Surah S where VA.mealId = V.id and S.id = V.surahId and V.pageNo=?1 and      VA.mealId not in (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and      V.pageNo=?1 and A.identifier = ?2) order by mealId',
        mapper: (Map<String, Object?> row) => DownloadVoiceEntity(surahId: row['surahId'] as int, verseId: row['verseId'] as int, verseNumber: row['verseNumber'] as int, cuzNo: row['cuzNo'] as int, surahName: row['surahName'] as String, mealId: row['mealId'] as int),
        arguments: [pageNo, identifier]);
  }
}

class _$CounterDao extends CounterDao {
  _$CounterDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _counterEntityInsertionAdapter = InsertionAdapter(
            database,
            'counters',
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'type': item.type,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener),
        _counterEntityUpdateAdapter = UpdateAdapter(
            database,
            'counters',
            ['id'],
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'type': item.type,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener),
        _counterEntityDeletionAdapter = DeletionAdapter(
            database,
            'counters',
            ['id'],
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'type': item.type,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CounterEntity> _counterEntityInsertionAdapter;

  final UpdateAdapter<CounterEntity> _counterEntityUpdateAdapter;

  final DeletionAdapter<CounterEntity> _counterEntityDeletionAdapter;

  @override
  Stream<List<CounterEntity>> getStreamRemovableCounters() {
    return _queryAdapter.queryListStream(
        'select * from counters where isRemovable = 1 order by orderItem desc',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            orderItem: row['orderItem'] as int,
            goal: row['goal'] as int?,
            type: row['type'] as int,
            lastCounter: row['lastCounter'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            meaning: row['meaning'] as String?),
        queryableName: 'counters',
        isView: false);
  }

  @override
  Future<List<CounterEntity>> getNonRemovableCounters() async {
    return _queryAdapter.queryList(
        'select * from counters where isRemovable = 0 order by orderItem asc',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            orderItem: row['orderItem'] as int,
            goal: row['goal'] as int?,
            type: row['type'] as int,
            lastCounter: row['lastCounter'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            meaning: row['meaning'] as String?));
  }

  @override
  Future<CounterEntity?> getCounterById(int id) async {
    return _queryAdapter.query('select * from counters where id=?1',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            orderItem: row['orderItem'] as int,
            goal: row['goal'] as int?,
            type: row['type'] as int,
            lastCounter: row['lastCounter'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            meaning: row['meaning'] as String?),
        arguments: [id]);
  }

  @override
  Stream<CounterEntity?> getStreamCounterById(int id) {
    return _queryAdapter.queryStream('select * from counters where id=?1',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            orderItem: row['orderItem'] as int,
            goal: row['goal'] as int?,
            type: row['type'] as int,
            lastCounter: row['lastCounter'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            meaning: row['meaning'] as String?),
        arguments: [id],
        queryableName: 'counters',
        isView: false);
  }

  @override
  Future<int?> getMaxOrder() async {
    return _queryAdapter.query('select max(orderItem) from counters',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> insertCounterEntity(CounterEntity counterEntity) {
    return _counterEntityInsertionAdapter.insertAndReturnId(
        counterEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateCounterEntity(CounterEntity counterEntity) async {
    await _counterEntityUpdateAdapter.update(
        counterEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteCounterEntity(CounterEntity counterEntity) async {
    await _counterEntityDeletionAdapter.delete(counterEntity);
  }
}

class _$EsmaulHusnaDaoOld extends EsmaulHusnaDaoOld {
  _$EsmaulHusnaDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<EsmaulHusnaEntityOld>> getAllEsmaulHusna() async {
    return _queryAdapter.queryList('select * from esmaulHusna',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntityOld(
            id: row['id'] as int?,
            orderItem: row['orderItem'] as int,
            name: row['name'] as String,
            arabicName: row['arabicName'] as String,
            meaning: row['meaning'] as String,
            dhikr: row['dhikr'] as String,
            virtue: row['virtue'] as String));
  }

  @override
  Future<EsmaulHusnaEntityOld?> getEsmaulHusnaWithId(int id) async {
    return _queryAdapter.query('select * from esmaulHusna where id=?1',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntityOld(
            id: row['id'] as int?,
            orderItem: row['orderItem'] as int,
            name: row['name'] as String,
            arabicName: row['arabicName'] as String,
            meaning: row['meaning'] as String,
            dhikr: row['dhikr'] as String,
            virtue: row['virtue'] as String),
        arguments: [id]);
  }
}

class _$PrayerDaoOld extends PrayerDaoOld {
  _$PrayerDaoOld(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<PrayerEntityOld>> getPrayers() async {
    return _queryAdapter.queryList('select * from prayers',
        mapper: (Map<String, Object?> row) => PrayerEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            meaningContent: row['meaningContent'] as String,
            pronunciationContent: row['pronunciationContent'] as String?,
            arabicContent: row['arabicContent'] as String));
  }

  @override
  Future<PrayerEntityOld?> getPrayerWithId(int id) async {
    return _queryAdapter.query('select * from prayers where id=?1',
        mapper: (Map<String, Object?> row) => PrayerEntityOld(
            id: row['id'] as int?,
            name: row['name'] as String,
            meaningContent: row['meaningContent'] as String,
            pronunciationContent: row['pronunciationContent'] as String?,
            arabicContent: row['arabicContent'] as String),
        arguments: [id]);
  }
}

class _$IslamicInfoDao extends IslamicInfoDao {
  _$IslamicInfoDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<IslamicInfoTitleEntity>> getIslamicInfoTitlesByTypeId(
      int type) async {
    return _queryAdapter.queryList(
        'select * from islamicInfoTitle where type=?1',
        mapper: (Map<String, Object?> row) => IslamicInfoTitleEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            type: row['type'] as int,
            description: row['description'] as String?),
        arguments: [type]);
  }

  @override
  Future<List<IslamicInfoItemEntity>> getIslamicInfoItemsByTitleId(
      int titleId) async {
    return _queryAdapter.queryList(
        'select * from islamicInfoItem where titleId=?1',
        mapper: (Map<String, Object?> row) => IslamicInfoItemEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            titleId: row['titleId'] as int,
            description: row['description'] as String?),
        arguments: [titleId]);
  }
}

class _$QuranPrayerDao extends QuranPrayerDao {
  _$QuranPrayerDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<QuranPrayerEntity>> getQuranPrayers() async {
    return _queryAdapter.queryList('select * from prayerQuran',
        mapper: (Map<String, Object?> row) => QuranPrayerEntity(
            id: row['id'] as int?,
            arabicContent: row['arabicContent'] as String,
            source: row['source'] as String,
            meaningContent: row['meaningContent'] as String));
  }
}

class _$HadithAllDao extends HadithAllDao {
  _$HadithAllDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<int?> getHadithCountByBookId(int bookId) async {
    return _queryAdapter.query('select count(*) from hadith where bookId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [bookId]);
  }

  @override
  Future<List<HadithEntity>> getPagingHadithsByBookId(
    int bookId,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from hadith where bookId = ?1 limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(
            id: row['id'] as int?,
            bookId: row['bookId'] as int,
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String),
        arguments: [bookId, pageSize, startIndex]);
  }

  @override
  Future<bool?> getExistsHadithByBookId(
    int bookId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select * from hadith where bookId = ?1 and id = ?2 )',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [bookId, id]);
  }

  @override
  Future<int?> getHadithCountByTopicId(int topicId) async {
    return _queryAdapter.query(
        'select count(*) from Hadith H, HadithTopic HT where     HT.hadithId=H.id and HT.topicId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [topicId]);
  }

  @override
  Future<List<HadithEntity>> getPagingHadithsByTopicId(
    int topicId,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select H.* from Hadith H, HadithTopic HT      where HT.hadithId=H.id and HT.topicId=?1 limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [topicId, pageSize, startIndex]);
  }

  @override
  Future<bool?> getExistsHadithByTopicId(
    int topicId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select H.* from Hadith H, HadithTopic HT      where HT.hadithId=H.id and HT.topicId = ?1 and id = ?2 )',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [topicId, id]);
  }

  @override
  Future<String?> getTopicName(int topicId) async {
    return _queryAdapter.query('select name from topic where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [topicId]);
  }

  @override
  Future<int?> getHadithCountByListId(int listId) async {
    return _queryAdapter.query(
        'select count(*) from Hadith H,ListHadith LH     where LH.hadithId=H.id and LH.listId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [listId]);
  }

  @override
  Future<List<HadithEntity>> getPagingHadithsByListId(
    int listId,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select H.* from Hadith H,ListHadith LH     where LH.hadithId=H.id and LH.listId=?1 limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [listId, pageSize, startIndex]);
  }

  @override
  Future<bool?> getExistsHadithByListId(
    int listId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select H.* from Hadith H,ListHadith LH     where LH.hadithId=H.id and LH.listId=?1 and id = ?2 )',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [listId, id]);
  }

  @override
  Future<int?> getHadithCountByRegExp(String regExp) async {
    return _queryAdapter.query(
        'select count(*) from Hadith where lower(content) REGEXP lower(?1)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [regExp]);
  }

  @override
  Future<List<HadithEntity>> getPagingHadithsByRegExp(
    String regExp,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where lower(content) REGEXP lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [regExp, pageSize, startIndex]);
  }

  @override
  Future<HadithEntity?> getHadithById(int id) async {
    return _queryAdapter.query('select * from hadith where id=?1',
        mapper: (Map<String, Object?> row) => HadithEntity(
            id: row['id'] as int?,
            bookId: row['bookId'] as int,
            content: row['content'] as String,
            contentSize: row['contentSize'] as int,
            source: row['source'] as String),
        arguments: [id]);
  }

  @override
  Future<int?> getPosById(int id) async {
    return _queryAdapter.query('select count(*) from hadith where id<?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<List<HadithEntity>> getHadithsFromListId(int listId) async {
    return _queryAdapter.queryList(
        'select H.* from Hadith H,ListHadith LH      where LH.hadithId=H.id and LH.listId=?1 order by       LH.pos desc',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [listId]);
  }
}

class _$ListDao extends ListDao {
  _$ListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _listEntityInsertionAdapter = InsertionAdapter(
            database,
            'list',
            (ListEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listEntityUpdateAdapter = UpdateAdapter(
            database,
            'list',
            ['id'],
            (ListEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listEntityDeletionAdapter = DeletionAdapter(
            database,
            'list',
            ['id'],
            (ListEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ListEntity> _listEntityInsertionAdapter;

  final UpdateAdapter<ListEntity> _listEntityUpdateAdapter;

  final DeletionAdapter<ListEntity> _listEntityDeletionAdapter;

  @override
  Future<int?> getMaxPosListWithSourceId(int sourceId) async {
    return _queryAdapter.query(
        'select ifnull(max(pos),0) data from list where sourceId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [sourceId]);
  }

  @override
  Future<int?> getMaxPosList() async {
    return _queryAdapter.query('select ifnull(max(pos),0) data from list',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<ListEntity?> getFavoriteList(int sourceId) async {
    return _queryAdapter.query(
        'select * from list where isRemovable = 0 and sourceId = ?1',
        mapper: (Map<String, Object?> row) => ListEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int),
        arguments: [sourceId]);
  }

  @override
  Future<String?> getListName(int listId) async {
    return _queryAdapter.query('select name from list where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [listId]);
  }

  @override
  Future<int> insertList(ListEntity listEntity) {
    return _listEntityInsertionAdapter.insertAndReturnId(
        listEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateList(ListEntity listEntity) {
    return _listEntityUpdateAdapter.updateAndReturnChangedRows(
        listEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteList(ListEntity listEntity) {
    return _listEntityDeletionAdapter.deleteAndReturnChangedRows(listEntity);
  }
}

class _$ListHadithDao extends ListHadithDao {
  _$ListHadithDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _listHadithEntityInsertionAdapter = InsertionAdapter(
            database,
            'listHadith',
            (ListHadithEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityUpdateAdapter = UpdateAdapter(
            database,
            'listHadith',
            ['listId', 'hadithId'],
            (ListHadithEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityDeletionAdapter = DeletionAdapter(
            database,
            'listHadith',
            ['listId', 'hadithId'],
            (ListHadithEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ListHadithEntity> _listHadithEntityInsertionAdapter;

  final UpdateAdapter<ListHadithEntity> _listHadithEntityUpdateAdapter;

  final DeletionAdapter<ListHadithEntity> _listHadithEntityDeletionAdapter;

  @override
  Future<ListHadithEntity?> getListHadith(
    int hadithId,
    int listId,
  ) async {
    return _queryAdapter.query(
        'select * from listHadith where hadithId = ?1 and listId = ?2',
        mapper: (Map<String, Object?> row) => ListHadithEntity(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [hadithId, listId]);
  }

  @override
  Future<int?> getMaxPos() async {
    return _queryAdapter.query('select ifnull(max(pos),0) from listHadith',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<ListHadithEntity>> getListHadithsWithListId(int listId) async {
    return _queryAdapter.queryList('select * from listHadith where listId=?1',
        mapper: (Map<String, Object?> row) => ListHadithEntity(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [listId]);
  }

  @override
  Stream<List<int>> getStreamListIdsFromHadithId(int hadithId) {
    return _queryAdapter.queryListStream(
        'select listId from listHadith where hadithId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [hadithId],
        queryableName: 'listHadith',
        isView: false);
  }

  @override
  Future<List<int>> getListIdsFromHadithId(int hadithId) async {
    return _queryAdapter.queryList(
        'select listId from listHadith where hadithId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [hadithId]);
  }

  @override
  Future<int> insertListHadith(ListHadithEntity listHadithEntity) {
    return _listHadithEntityInsertionAdapter.insertAndReturnId(
        listHadithEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertListHadiths(
      List<ListHadithEntity> listHadithEntities) {
    return _listHadithEntityInsertionAdapter.insertListAndReturnIds(
        listHadithEntities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateListHadith(ListHadithEntity listHadithEntity) {
    return _listHadithEntityUpdateAdapter.updateAndReturnChangedRows(
        listHadithEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteListHadith(ListHadithEntity listHadithEntity) {
    return _listHadithEntityDeletionAdapter
        .deleteAndReturnChangedRows(listHadithEntity);
  }

  @override
  Future<int> deleteListHadiths(List<ListHadithEntity> listHadithEntities) {
    return _listHadithEntityDeletionAdapter
        .deleteListAndReturnChangedRows(listHadithEntities);
  }
}

class _$ListHadithViewDao extends ListHadithViewDao {
  _$ListHadithViewDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<ListHadithView>> getStreamListHadithViewsByIsArchive(
      bool isArchive) {
    return _queryAdapter.queryListStream(
        'select * from listHadithView where isArchive=?1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [isArchive ? 1 : 0],
        queryableName: 'listHadithView',
        isView: true);
  }

  @override
  Stream<List<ListHadithView>> getStreamRemovableListHadithViews() {
    return _queryAdapter.queryListStream(
        'select * from listHadithView where isRemovable=1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        queryableName: 'listHadithView',
        isView: true);
  }

  @override
  Stream<List<ListHadithView>> getStreamRemovableListHadithViewsByIsArchive(
      bool isArchive) {
    return _queryAdapter.queryListStream(
        'select * from listHadithView where isRemovable=1 and isArchive=?1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [isArchive ? 1 : 0],
        queryableName: 'listHadithView',
        isView: true);
  }

  @override
  Stream<List<ListHadithView>> getStreamListHadithByQueryAndIsArchive(
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
    bool isArchive,
  ) {
    return _queryAdapter.queryListStream(
        'select * from listHadithView where isArchive=?4 and      name like ?1 order by       (case when lower(name)=?3 then 1 when name like ?2 then 2 else 3 end ),isRemovable asc ,listPos desc',
        mapper: (Map<String, Object?> row) => ListHadithView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [
          querySearchFull,
          queryOrderForLike,
          queryRaw,
          isArchive ? 1 : 0
        ],
        queryableName: 'listHadithView',
        isView: true);
  }
}

class _$ListVerseDao extends ListVerseDao {
  _$ListVerseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _listVerseEntityInsertionAdapter = InsertionAdapter(
            database,
            'listVerse',
            (ListVerseEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityUpdateAdapter = UpdateAdapter(
            database,
            'listVerse',
            ['listId', 'verseId'],
            (ListVerseEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityDeletionAdapter = DeletionAdapter(
            database,
            'listVerse',
            ['listId', 'verseId'],
            (ListVerseEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ListVerseEntity> _listVerseEntityInsertionAdapter;

  final UpdateAdapter<ListVerseEntity> _listVerseEntityUpdateAdapter;

  final DeletionAdapter<ListVerseEntity> _listVerseEntityDeletionAdapter;

  @override
  Future<ListVerseEntity?> getListVerse(
    int verseId,
    int listId,
  ) async {
    return _queryAdapter.query(
        'select * from listVerse where verseId = ?1 and listId = ?2',
        mapper: (Map<String, Object?> row) => ListVerseEntity(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [verseId, listId]);
  }

  @override
  Future<int?> getMaxPos() async {
    return _queryAdapter.query('select ifnull(max(pos),0) from listVerse',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<ListVerseEntity>> getListVersesWithListId(int listId) async {
    return _queryAdapter.queryList('select * from listVerse where listId=?1',
        mapper: (Map<String, Object?> row) => ListVerseEntity(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<int>> getListIdsFromVerseId(int verseId) async {
    return _queryAdapter.queryList(
        'select listId from listVerse where verseId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [verseId]);
  }

  @override
  Future<int> insertListVerse(ListVerseEntity listVerseEntity) {
    return _listVerseEntityInsertionAdapter.insertAndReturnId(
        listVerseEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertListVerses(List<ListVerseEntity> listVerseEntities) {
    return _listVerseEntityInsertionAdapter.insertListAndReturnIds(
        listVerseEntities, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateListVerse(ListVerseEntity listVerseEntity) {
    return _listVerseEntityUpdateAdapter.updateAndReturnChangedRows(
        listVerseEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteListVerse(ListVerseEntity listVerseEntity) {
    return _listVerseEntityDeletionAdapter
        .deleteAndReturnChangedRows(listVerseEntity);
  }

  @override
  Future<int> deleteListVerses(List<ListVerseEntity> listVerseEntities) {
    return _listVerseEntityDeletionAdapter
        .deleteListAndReturnChangedRows(listVerseEntities);
  }
}

class _$ListVerseViewDao extends ListVerseViewDao {
  _$ListVerseViewDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<ListVerseView>> getStreamListVerseViewByIsArchive(
      bool isArchive) {
    return _queryAdapter.queryListStream(
        'select * from listVerseView where isArchive=?1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListVerseView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [isArchive ? 1 : 0],
        queryableName: 'listVerseView',
        isView: true);
  }

  @override
  Stream<List<ListVerseView>> getStreamRemovableListVerseView() {
    return _queryAdapter.queryListStream(
        'select * from listVerseView where isRemovable=1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListVerseView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        queryableName: 'listVerseView',
        isView: true);
  }

  @override
  Stream<List<ListVerseView>> getStreamRemovableListVerseViewByIsArchive(
      bool isArchive) {
    return _queryAdapter.queryListStream(
        'select * from listVerseView where isRemovable=1 and isArchive=?1 order by isRemovable asc,listPos desc',
        mapper: (Map<String, Object?> row) => ListVerseView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [isArchive ? 1 : 0],
        queryableName: 'listVerseView',
        isView: true);
  }

  @override
  Stream<List<ListVerseView>> getStreamListVersesViewByQueryAndIsArchive(
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
    bool isArchive,
  ) {
    return _queryAdapter.queryListStream(
        'select * from listVerseView where isArchive=?4 and      name like ?1 order by       (case when lower(name)=?3 then 1 when name like ?2 then 2 else 3 end ), isRemovable asc ,listPos desc',
        mapper: (Map<String, Object?> row) => ListVerseView(
            id: row['id'] as int,
            contentMaxPos: row['contentMaxPos'] as int,
            name: row['name'] as String,
            isArchive: (row['isArchive'] as int) != 0,
            sourceId: row['sourceId'] as int,
            listPos: row['listPos'] as int,
            itemCounts: row['itemCounts'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [
          querySearchFull,
          queryOrderForLike,
          queryRaw,
          isArchive ? 1 : 0
        ],
        queryableName: 'listVerseView',
        isView: true);
  }
}

class _$SavePointDao extends SavePointDao {
  _$SavePointDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _savePointEntityInsertionAdapter = InsertionAdapter(
            database,
            'savePoints',
            (SavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener),
        _savePointEntityUpdateAdapter = UpdateAdapter(
            database,
            'savePoints',
            ['id'],
            (SavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener),
        _savePointEntityDeletionAdapter = DeletionAdapter(
            database,
            'savePoints',
            ['id'],
            (SavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemIndexPos': item.itemIndexPos,
                  'title': item.title,
                  'autoType': item.autoType,
                  'modifiedDate': item.modifiedDate,
                  'savePointType': item.savePointType,
                  'bookScope': item.bookScope,
                  'parentName': item.parentName,
                  'parentKey': item.parentKey
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SavePointEntity> _savePointEntityInsertionAdapter;

  final UpdateAdapter<SavePointEntity> _savePointEntityUpdateAdapter;

  final DeletionAdapter<SavePointEntity> _savePointEntityDeletionAdapter;

  @override
  Future<SavePointEntity?> getSavePointById(int id) async {
    return _queryAdapter.query('select * from savePoints where id = ?1',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [id]);
  }

  @override
  Stream<SavePointEntity?> getStreamSavePointById(int id) {
    return _queryAdapter.queryStream('select * from savePoints where id = ?1',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [id],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Future<void> deleteSavePointsWithQuery(
    int savePointType,
    String parentKey,
  ) async {
    await _queryAdapter.queryNoReturn(
        'delete from savePoints where savePointType=?1 and parentKey=?2',
        arguments: [savePointType, parentKey]);
  }

  @override
  Future<SavePointEntity?> getLastSavePointByDestinationAndAutoType(
    int bookScope,
    int typeId,
    String parentKey,
    int autoType,
  ) async {
    return _queryAdapter.query(
        'select * from savePoints where bookScope = ?1 and savePointType = ?2 and     parentKey = ?3 and autoType = ?4 order by modifiedDate desc limit 1',
        mapper: (Map<String, Object?> row) => SavePointEntity(id: row['id'] as int?, itemIndexPos: row['itemIndexPos'] as int, title: row['title'] as String, autoType: row['autoType'] as int, modifiedDate: row['modifiedDate'] as String, savePointType: row['savePointType'] as int, bookScope: row['bookScope'] as int, parentKey: row['parentKey'] as String, parentName: row['parentName'] as String),
        arguments: [bookScope, typeId, parentKey, autoType]);
  }

  @override
  Future<SavePointEntity?> getLastSavePointByBookScopeAndType(
    int bookScope,
    int typeId,
    int autoType,
  ) async {
    return _queryAdapter.query(
        'select * from savePoints where bookScope = ?1 and savePointType = ?2 and     autoType = ?3 order by modifiedDate desc limit 1',
        mapper: (Map<String, Object?> row) => SavePointEntity(id: row['id'] as int?, itemIndexPos: row['itemIndexPos'] as int, title: row['title'] as String, autoType: row['autoType'] as int, modifiedDate: row['modifiedDate'] as String, savePointType: row['savePointType'] as int, bookScope: row['bookScope'] as int, parentKey: row['parentKey'] as String, parentName: row['parentName'] as String),
        arguments: [bookScope, typeId, autoType]);
  }

  @override
  Stream<List<SavePointEntity>> getStreamSavePointsWithScopes(
      List<int> bookScopes) {
    const offset = 1;
    final _sqliteVariablesForBookScopes =
        Iterable<String>.generate(bookScopes.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'select * from savePoints where bookScope in(' +
            _sqliteVariablesForBookScopes +
            ') order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [...bookScopes],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Stream<List<SavePointEntity>> getStreamSavePointsWithScopesAndTypeId(
    List<int> bookScopes,
    int typeId,
  ) {
    const offset = 2;
    final _sqliteVariablesForBookScopes =
        Iterable<String>.generate(bookScopes.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryListStream(
        'select * from savePoints where bookScope in(' +
            _sqliteVariablesForBookScopes +
            ') and savePointType=?1      order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [typeId, ...bookScopes],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Stream<List<SavePointEntity>> getStreamSavePointsWithTypeId(int typeId) {
    return _queryAdapter.queryListStream(
        'select * from savePoints where savePointType=?1 order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [typeId],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Stream<List<SavePointEntity>> getStreamSavePointsWithTypeIdAndParentKey(
    int typeId,
    String parentKey,
  ) {
    return _queryAdapter.queryListStream(
        'select * from savePoints where savePointType=?1 and parentKey=?2 order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String),
        arguments: [typeId, parentKey],
        queryableName: 'savePoints',
        isView: false);
  }

  @override
  Future<int> insertSavePoint(SavePointEntity savePoint) {
    return _savePointEntityInsertionAdapter.insertAndReturnId(
        savePoint, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateSavePoint(SavePointEntity savePoint) async {
    await _savePointEntityUpdateAdapter.update(
        savePoint, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSavePoint(SavePointEntity savePoint) async {
    await _savePointEntityDeletionAdapter.delete(savePoint);
  }
}

class _$HadithInfoListDao extends HadithInfoListDao {
  _$HadithInfoListDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<HadithInfoListView?> getHadithInfoList(int hadithId) async {
    return _queryAdapter.query(
        'select * from hadithInfoListView where hadithId = ?1',
        mapper: (Map<String, Object?> row) => HadithInfoListView(
            hadithId: row['hadithId'] as int,
            inAnyList: (row['inAnyList'] as int) != 0,
            inFavorite: (row['inFavorite'] as int) != 0,
            inAnyArchiveList: (row['inAnyArchiveList'] as int) != 0),
        arguments: [hadithId]);
  }
}

class _$VerseInfoListDao extends VerseInfoListDao {
  _$VerseInfoListDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<VerseInfoListView?> getVerseInfoList(int verseId) async {
    return _queryAdapter.query(
        'select * from verseInfoListView where verseId = ?1',
        mapper: (Map<String, Object?> row) => VerseInfoListView(
            verseId: row['verseId'] as int,
            inAnyList: (row['inAnyList'] as int) != 0,
            inFavorite: (row['inFavorite'] as int) != 0,
            inAnyArchiveList: (row['inAnyArchiveList'] as int) != 0),
        arguments: [verseId]);
  }
}

class _$TopicDao extends TopicDao {
  _$TopicDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<String>> getTopicNamesByHadithId(int hadithId) async {
    return _queryAdapter.queryList(
        'select T.name from topic T,HadithTopic HT      where T.id=HT.topicId and HT.hadithId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [hadithId]);
  }
}

class _$TopicHadithViewDao extends TopicHadithViewDao {
  _$TopicHadithViewDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<TopicHadithsView>> getStreamTopicHadithsBySectionId(
      int sectionId) {
    return _queryAdapter.queryListStream(
        'select * from topicHadithsView where sectionId = ?1',
        mapper: (Map<String, Object?> row) => TopicHadithsView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            hadithCount: row['hadithCount'] as int),
        arguments: [sectionId],
        queryableName: 'topicHadithsView',
        isView: true);
  }

  @override
  Stream<List<TopicHadithsView>> getStreamTopicHadithsBySectionIdAndQuery(
    int sectionId,
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) {
    return _queryAdapter.queryListStream(
        'select * from topicHadithsView where sectionId = ?1 and      name like ?2 order by       (case when lower(name)=?4 then 1 when name like ?3       then 2 else 3 end )',
        mapper: (Map<String, Object?> row) => TopicHadithsView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            hadithCount: row['hadithCount'] as int),
        arguments: [sectionId, querySearchFull, queryOrderForLike, queryRaw],
        queryableName: 'topicHadithsView',
        isView: true);
  }

  @override
  Stream<List<TopicHadithsView>> getStreamTopicHadithsByBookId(int bookId) {
    return _queryAdapter.queryListStream(
        'select TH.* from topicHadithsView TH, sectionTopicsView ST     where TH.sectionId = ST.id and ST.bookId = ?1 order by TH.id',
        mapper: (Map<String, Object?> row) => TopicHadithsView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            hadithCount: row['hadithCount'] as int),
        arguments: [bookId],
        queryableName: 'topicHadithsView',
        isView: true);
  }

  @override
  Stream<List<TopicHadithsView>> getStreamTopicHadithsByBookIdAndQuery(
    int bookId,
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) {
    return _queryAdapter.queryListStream(
        'select TH.* from topicHadithsView TH, sectionTopicsView ST     where TH.sectionId = ST.id and ST.bookId = ?1 and     TH.name like ?2 order by      (case when lower(TH.name)=?4 then 1 when TH.name like ?3      then 2 else 3 end ), TH.id',
        mapper: (Map<String, Object?> row) => TopicHadithsView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            hadithCount: row['hadithCount'] as int),
        arguments: [bookId, querySearchFull, queryOrderForLike, queryRaw],
        queryableName: 'topicHadithsView',
        isView: true);
  }
}

class _$TopicVersesViewDao extends TopicVersesViewDao {
  _$TopicVersesViewDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<TopicVersesView>> getStreamTopicVersesBySectionId(int sectionId) {
    return _queryAdapter.queryListStream(
        'select * from topicVersesView where sectionId = ?1',
        mapper: (Map<String, Object?> row) => TopicVersesView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            verseCount: row['verseCount'] as int),
        arguments: [sectionId],
        queryableName: 'topicVersesView',
        isView: true);
  }

  @override
  Stream<List<TopicVersesView>> getStreamTopicVersesBySectionIdAndQuery(
    int sectionId,
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) {
    return _queryAdapter.queryListStream(
        'select * from topicVersesView where sectionId = ?1 and      name like ?2 order by       (case when lower(name)=?4 then 1 when name like ?3       then 2 else 3 end )',
        mapper: (Map<String, Object?> row) => TopicVersesView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            verseCount: row['verseCount'] as int),
        arguments: [sectionId, querySearchFull, queryOrderForLike, queryRaw],
        queryableName: 'topicVersesView',
        isView: true);
  }

  @override
  Stream<List<TopicVersesView>> getStreamTopicVersesByBookId(int bookId) {
    return _queryAdapter.queryListStream(
        'select TV.* from topicVersesView TV, sectionTopicsView ST     where TV.sectionId = ST.id and ST.bookId = ?1 order by TV.id',
        mapper: (Map<String, Object?> row) => TopicVersesView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            verseCount: row['verseCount'] as int),
        arguments: [bookId],
        queryableName: 'topicVersesView',
        isView: true);
  }

  @override
  Stream<List<TopicVersesView>> getStreamTopicVersesByBookIdAndQuery(
    int bookId,
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) {
    return _queryAdapter.queryListStream(
        'select TV.* from topicVersesView TV, sectionTopicsView ST     where TV.sectionId = ST.id and ST.bookId = ?1 and     TV.name like ?2 order by      (case when lower(TV.name)=?4 then 1 when TV.name like ?3      then 2 else 3 end ), TV.id',
        mapper: (Map<String, Object?> row) => TopicVersesView(
            id: row['id'] as int,
            name: row['name'] as String,
            sectionId: row['sectionId'] as int,
            verseCount: row['verseCount'] as int),
        arguments: [bookId, querySearchFull, queryOrderForLike, queryRaw],
        queryableName: 'topicVersesView',
        isView: true);
  }
}

class _$SectionViewDao extends SectionViewDao {
  _$SectionViewDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<SectionTopicsView>> getSectionTopicsByBookId(int bookId) {
    return _queryAdapter.queryListStream(
        'select * from sectionTopicsView where bookId = ?1',
        mapper: (Map<String, Object?> row) => SectionTopicsView(
            id: row['id'] as int,
            name: row['name'] as String,
            bookId: row['bookId'] as int,
            topicCount: row['topicCount'] as int),
        arguments: [bookId],
        queryableName: 'sectionTopicsView',
        isView: true);
  }

  @override
  Stream<List<SectionTopicsView>> getSectionTopicsByBookIdAndQuery(
    int bookId,
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) {
    return _queryAdapter.queryListStream(
        'select * from sectionTopicsView where bookId = ?1 and      name like ?2 order by       (case when lower(name)=?4 then 1 when name like ?3       then 2 else 3 end )',
        mapper: (Map<String, Object?> row) => SectionTopicsView(
            id: row['id'] as int,
            name: row['name'] as String,
            bookId: row['bookId'] as int,
            topicCount: row['topicCount'] as int),
        arguments: [bookId, querySearchFull, queryOrderForLike, queryRaw],
        queryableName: 'sectionTopicsView',
        isView: true);
  }

  @override
  Future<int?> getTopicsCountByBookId(int bookId) async {
    return _queryAdapter.query(
        'select sum(topicCount) from sectionTopicsView where bookId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [bookId]);
  }
}

class _$TopicSavePointDao extends TopicSavePointDao {
  _$TopicSavePointDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _topicSavePointEntityInsertionAdapter = InsertionAdapter(
            database,
            'topicSavePoint',
            (TopicSavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _topicSavePointEntityUpdateAdapter = UpdateAdapter(
            database,
            'topicSavePoint',
            ['id'],
            (TopicSavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _topicSavePointEntityDeletionAdapter = DeletionAdapter(
            database,
            'topicSavePoint',
            ['id'],
            (TopicSavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TopicSavePointEntity>
      _topicSavePointEntityInsertionAdapter;

  final UpdateAdapter<TopicSavePointEntity> _topicSavePointEntityUpdateAdapter;

  final DeletionAdapter<TopicSavePointEntity>
      _topicSavePointEntityDeletionAdapter;

  @override
  Stream<TopicSavePointEntity?> getStreamTopicSavePointEntity(
    int type,
    String parentKey,
  ) {
    return _queryAdapter.queryStream(
        'select * from topicSavePoint where type=?1 and parentKey=?2      order by id desc limit 1',
        mapper: (Map<String, Object?> row) => TopicSavePointEntity(
            id: row['id'] as int?,
            pos: row['pos'] as int,
            type: row['type'] as int,
            parentKey: row['parentKey'] as String),
        arguments: [type, parentKey],
        queryableName: 'topicSavePoint',
        isView: false);
  }

  @override
  Future<TopicSavePointEntity?> getTopicSavePointEntity(
    int type,
    String parentKey,
  ) async {
    return _queryAdapter.query(
        'select * from topicSavePoint where type=?1 and parentKey=?2      order by id desc limit 1',
        mapper: (Map<String, Object?> row) => TopicSavePointEntity(id: row['id'] as int?, pos: row['pos'] as int, type: row['type'] as int, parentKey: row['parentKey'] as String),
        arguments: [type, parentKey]);
  }

  @override
  Future<int> insertTopicSavePoint(TopicSavePointEntity topicSavePointEntity) {
    return _topicSavePointEntityInsertionAdapter.insertAndReturnId(
        topicSavePointEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTopicSavePoint(
      TopicSavePointEntity topicSavePointEntity) async {
    await _topicSavePointEntityUpdateAdapter.update(
        topicSavePointEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTopicSavePoint(
      TopicSavePointEntity topicSavePointEntity) async {
    await _topicSavePointEntityDeletionAdapter.delete(topicSavePointEntity);
  }
}

class _$CuzDao extends CuzDao {
  _$CuzDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<CuzEntity>> getAllCuz() async {
    return _queryAdapter.queryList('select * from cuz',
        mapper: (Map<String, Object?> row) =>
            CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String));
  }

  @override
  Future<CuzEntity?> getCuz(int cuzNo) async {
    return _queryAdapter.query('select * from Cuz where cuzNo=?1',
        mapper: (Map<String, Object?> row) =>
            CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String),
        arguments: [cuzNo]);
  }
}

class _$SurahDao extends SurahDao {
  _$SurahDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<SurahEntity>> getAllSurah() async {
    return _queryAdapter.queryList('select * from surah',
        mapper: (Map<String, Object?> row) => SurahEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String));
  }

  @override
  Future<List<SurahEntity>> getSurahesWithQuery(
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) async {
    return _queryAdapter.queryList(
        'select * from surah where name like ?1 or searchName like ?1      order by (case when lower(searchName)=?3 then 1      when searchName like ?2 then 2      else 3 end)',
        mapper: (Map<String, Object?> row) => SurahEntity(id: row['id'] as int, name: row['name'] as String, searchName: row['searchName'] as String),
        arguments: [querySearchFull, queryOrderForLike, queryRaw]);
  }

  @override
  Future<SurahEntity?> getSurah(int surahId) async {
    return _queryAdapter.query('select * from Surah where id=?1',
        mapper: (Map<String, Object?> row) => SurahEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String),
        arguments: [surahId]);
  }

  @override
  Future<String?> getSurahNameById(int surahId) async {
    return _queryAdapter.query('select name from surah where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [surahId]);
  }
}

class _$VerseArabicDao extends VerseArabicDao {
  _$VerseArabicDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<VerseArabicEntity>> getArabicVersesByMealId(int mealId) async {
    return _queryAdapter.queryList('select * from verseArabic where mealId=?1',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(
            id: row['id'] as int?,
            mealId: row['mealId'] as int,
            verse: row['verse'] as String,
            verseNumber: row['verseNumber'] as String,
            verseNumberTr: row['verseNumberTr'] as int),
        arguments: [mealId]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.id=?1 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.id=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.surahId=?1 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.surahId=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [surahId, identifier]);
  }

  @override
  Future<List<VerseArabicEntity>> getNotDownloadedVerseArabicsWithSurahId(
    int surahId,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.surahId=?1 and V.id >= ?3 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.surahId=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [surahId, identifier, startVerseId]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.cuzNo=?1 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.cuzNo=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseArabicEntity>> getNotDownloadedVerseArabicsWithCuzNo(
    int cuzNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.cuzNo=?1 and V.id >= ?3 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.cuzNo=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [cuzNo, identifier, startVerseId]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.pageNo=?1 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.pageNo=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<List<VerseArabicEntity>> getNotDownloadedVerseArabicsWithPageNo(
    int pageNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseArabic VA, Verse V      where VA.mealId = V.id and V.pageNo=?1 and V.id >= ?3 and VA.mealId not in      (select A.mealId from Verse V, VerseAudio A where V.id=A.mealId and V.pageNo=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [pageNo, identifier, startVerseId]);
  }
}

class _$VerseDao extends VerseDao {
  _$VerseDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<VerseEntity>> getPagingVersesBySurahId(
    int surahId,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from verse where surahId=?1 limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(
            id: row['id'] as int?,
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            bookId: row['bookId'] as int),
        arguments: [surahId, pageSize, startIndex]);
  }

  @override
  Future<int?> getVerseCountBySurahId(int surahId) async {
    return _queryAdapter.query('select count(*) from verse where surahId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [surahId]);
  }

  @override
  Future<bool?> getExistsVerseBySurahId(
    int surahId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select * from verse where surahId = ?1 and id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [surahId, id]);
  }

  @override
  Future<int?> getSurahPosById(
    int id,
    int surahId,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verse where surahId = ?2 and id < ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id, surahId]);
  }

  @override
  Future<List<VerseEntity>> getPagingVersesByCuzNo(
    int cuzNo,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from verse where cuzNo=?1 limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(
            id: row['id'] as int?,
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            bookId: row['bookId'] as int),
        arguments: [cuzNo, pageSize, startIndex]);
  }

  @override
  Future<int?> getVerseCountByCuzNo(int cuzNo) async {
    return _queryAdapter.query('select count(*) from verse where cuzNo=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cuzNo]);
  }

  @override
  Future<bool?> getExistsVerseByCuzNo(
    int cuzNo,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select * from verse where cuzNo = ?1 and id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [cuzNo, id]);
  }

  @override
  Future<int?> getCuzPosById(
    int id,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verse where cuzNo = ?2 and id < ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id, cuzNo]);
  }

  @override
  Future<List<VerseEntity>> getPagingVersesByListId(
    int listId,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select V.* from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = ?1     order by LV.pos desc limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [listId, pageSize, startIndex]);
  }

  @override
  Future<int?> getVerseCountByListId(int listId) async {
    return _queryAdapter.query(
        'select count(*) from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [listId]);
  }

  @override
  Future<bool?> getExistsVerseByListId(
    int listId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(     select V.* from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = ?1     and V.id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [listId, id]);
  }

  @override
  Future<List<VerseEntity>> getPagingVersesByTopicId(
    int topicId,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select V.* from verse V, verseTopic VT where V.id = VT.verseId and VT.topicId = ?1     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [topicId, pageSize, startIndex]);
  }

  @override
  Future<int?> getVerseCountByTopicId(int topicId) async {
    return _queryAdapter.query(
        'select count(*) from verse V, verseTopic VT where V.id = VT.verseId and VT.topicId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [topicId]);
  }

  @override
  Future<bool?> getExistsVerseByTopicId(
    int topicId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(     select V.* from verse V, verseTopic VT where V.id = VT.verseId and VT.topicId = ?1     and V.id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [topicId, id]);
  }

  @override
  Future<VerseEntity?> getVerseById(int id) async {
    return _queryAdapter.query('select * from Verse where id = ?1',
        mapper: (Map<String, Object?> row) => VerseEntity(
            id: row['id'] as int?,
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            bookId: row['bookId'] as int),
        arguments: [id]);
  }

  @override
  Future<int?> getPosById(int id) async {
    return _queryAdapter.query('select count(*) from verse where id<?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<List<VerseEntity>> getVersesFromListId(int listId) async {
    return _queryAdapter.queryList(
        'select V.* from verse V, ListVerse LV where V.id = LV.verseId and LV.listId = ?1      order by LV.pos desc',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<VerseEntity>> getVersesByIds(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from verse where id in (' + _sqliteVariablesForIds + ')',
        mapper: (Map<String, Object?> row) => VerseEntity(
            id: row['id'] as int?,
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            bookId: row['bookId'] as int),
        arguments: [...ids]);
  }
}

class _$TitleDao extends TitleDao {
  _$TitleDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<String?> getTopicTitleById(int topicId) async {
    return _queryAdapter.query('select name from topic where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [topicId]);
  }

  @override
  Future<String?> getListTitleById(int listId) async {
    return _queryAdapter.query('select name from list where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [listId]);
  }

  @override
  Future<String?> getSurahTitleById(int surahId) async {
    return _queryAdapter.query('select name from surah where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [surahId]);
  }

  @override
  Future<String?> getCuzTitleById(int cuzNo) async {
    return _queryAdapter.query('select name from cuz where cuzNo = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [cuzNo]);
  }
}

class _$SearchDao extends SearchDao {
  _$SearchDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<int?> getCountAllHadithByRegex(String regExp) async {
    return _queryAdapter.query(
        'select count(id) from Hadith where lower(content) REGEXP lower(?1)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [regExp]);
  }

  @override
  Future<List<HadithEntity>> getAllHadithByRegex(
    String regExp,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where lower(content) REGEXP lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [regExp, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountAllHadithByLike(String query) async {
    return _queryAdapter.query(
        'select count(id) from Hadith where lower(content) Like lower(?1)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [query]);
  }

  @override
  Future<List<HadithEntity>> getAllHadithsByLike(
    String query,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where lower(content) Like lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [query, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountHadithByRegexAndBookId(
    int bookId,
    String regExp,
  ) async {
    return _queryAdapter.query(
        'select count(id) from Hadith where bookId=?1 and lower(content) REGEXP lower(?2)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [bookId, regExp]);
  }

  @override
  Future<List<HadithEntity>> getHadithsByRegexAndBookId(
    int bookId,
    String regExp,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where bookId=?1 and lower(content) REGEXP lower(?2)      limit ?3 offset ?4',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [bookId, regExp, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountHadithByLikeAndBookId(
    int bookId,
    String query,
  ) async {
    return _queryAdapter.query(
        'select count(id) from Hadith where bookId=?1 and lower(content) Like lower(?2)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [bookId, query]);
  }

  @override
  Future<List<HadithEntity>> getHadithsByLikeAndBookId(
    int bookId,
    String query,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from Hadith where bookId=?1 and lower(content) Like lower(?2)      limit ?3 offset ?4',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [bookId, query, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountVerseByRegex(String regExp) async {
    return _queryAdapter.query(
        'select count(id) data from verse V where lower(content)  REGEXP lower(?1)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [regExp]);
  }

  @override
  Future<List<VerseEntity>> getVersesByRegex(
    String regExp,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from verse where lower(content)  REGEXP lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [regExp, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountVerseByLike(String query) async {
    return _queryAdapter.query(
        'select count(id) data from verse V where lower(content) Like lower(?1)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [query]);
  }

  @override
  Future<List<VerseEntity>> getVersesByLike(
    String query,
    int pageSize,
    int startIndex,
  ) async {
    return _queryAdapter.queryList(
        'select * from verse where lower(content)  Like lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [query, pageSize, startIndex]);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _historyEntityInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _historyEntityUpdateAdapter = UpdateAdapter(
            database,
            'History',
            ['id'],
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _historyEntityDeletionAdapter = DeletionAdapter(
            database,
            'History',
            ['id'],
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HistoryEntity> _historyEntityInsertionAdapter;

  final UpdateAdapter<HistoryEntity> _historyEntityUpdateAdapter;

  final DeletionAdapter<HistoryEntity> _historyEntityDeletionAdapter;

  @override
  Stream<List<HistoryEntity>> getStreamHistories() {
    return _queryAdapter.queryListStream(
        'select * from history order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        queryableName: 'history',
        isView: false);
  }

  @override
  Future<HistoryEntity?> getHistoryEntity(String name) async {
    return _queryAdapter.query(
        'select * from history where lower(name) = lower(?1)',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        arguments: [name]);
  }

  @override
  Future<void> insertHistory(HistoryEntity historyEntity) async {
    await _historyEntityInsertionAdapter.insert(
        historyEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateHistory(HistoryEntity historyEntity) async {
    await _historyEntityUpdateAdapter.update(
        historyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteHistory(HistoryEntity historyEntity) async {
    await _historyEntityDeletionAdapter.delete(historyEntity);
  }

  @override
  Future<void> deleteHistories(List<HistoryEntity> historyEntities) async {
    await _historyEntityDeletionAdapter.deleteList(historyEntities);
  }
}

class _$AudioEditionDao extends AudioEditionDao {
  _$AudioEditionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _audioEditionEntityInsertionAdapter = InsertionAdapter(
            database,
            'AudioEdition',
            (AudioEditionEntity item) => <String, Object?>{
                  'identifier': item.identifier,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0,
                  'fileName': item.fileName
                },
            changeListener),
        _audioEditionEntityUpdateAdapter = UpdateAdapter(
            database,
            'AudioEdition',
            ['identifier'],
            (AudioEditionEntity item) => <String, Object?>{
                  'identifier': item.identifier,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0,
                  'fileName': item.fileName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AudioEditionEntity>
      _audioEditionEntityInsertionAdapter;

  final UpdateAdapter<AudioEditionEntity> _audioEditionEntityUpdateAdapter;

  @override
  Future<List<AudioEditionEntity>> getEditions() async {
    return _queryAdapter.queryList('select * from audioEdition',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?));
  }

  @override
  Stream<List<AudioEditionEntity>> getStreamEditions() {
    return _queryAdapter.queryListStream('select * from audioEdition',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        queryableName: 'audioEdition',
        isView: false);
  }

  @override
  Stream<AudioEditionEntity?> getSelectedStreamEdition() {
    return _queryAdapter.queryStream(
        'select * from audioEdition where isSelected = 1',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        queryableName: 'audioEdition',
        isView: false);
  }

  @override
  Future<AudioEditionEntity?> getSelectedEdition() async {
    return _queryAdapter.query(
        'select * from audioEdition where isSelected = 1',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?));
  }

  @override
  Future<bool?> isEditionNotEmpty() async {
    return _queryAdapter.query(
        'select exists(select 1 from audioEdition) as data',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0);
  }

  @override
  Future<AudioEditionEntity?> getEditionByIdentifier(String identifier) async {
    return _queryAdapter.query(
        'select * from audioEdition where identifier = ?1',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        arguments: [identifier]);
  }

  @override
  Future<String?> getEditionNameByIdentifier(String identifier) async {
    return _queryAdapter.query(
        'select name from audioEdition where identifier = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [identifier]);
  }

  @override
  Future<void> insertEditions(List<AudioEditionEntity> items) async {
    await _audioEditionEntityInsertionAdapter.insertList(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAudioEditions(List<AudioEditionEntity> editions) async {
    await _audioEditionEntityUpdateAdapter.updateList(
        editions, OnConflictStrategy.replace);
  }
}

class _$VerseAudioDao extends VerseAudioDao {
  _$VerseAudioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _verseAudioEntityInsertionAdapter = InsertionAdapter(
            database,
            'verseAudio',
            (VerseAudioEntity item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener),
        _verseAudioEntityUpdateAdapter = UpdateAdapter(
            database,
            'verseAudio',
            ['mealId', 'identifier'],
            (VerseAudioEntity item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener),
        _verseAudioEntityDeletionAdapter = DeletionAdapter(
            database,
            'verseAudio',
            ['mealId', 'identifier'],
            (VerseAudioEntity item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VerseAudioEntity> _verseAudioEntityInsertionAdapter;

  final UpdateAdapter<VerseAudioEntity> _verseAudioEntityUpdateAdapter;

  final DeletionAdapter<VerseAudioEntity> _verseAudioEntityDeletionAdapter;

  @override
  Future<void> deleteVerseAudioWithQuery(
    String identifier,
    int mealId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'delete from verseAudio where identifier = ?1 and mealId=?2',
        arguments: [identifier, mealId]);
  }

  @override
  Future<bool?> hasVerseAudiosWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from surahAudioView where surahId=?1 and identifier=?2 and isDownloaded=1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [surahId, identifier]);
  }

  @override
  Future<bool?> hasVerseAudiosWithSurahIdAndStartVerseId(
    int surahId,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from Verse V, VerseAudio VA      where V.id = VA.mealId and VA.identifier = ?2 and V.surahId=?1 and VA.mealId >= ?3     group by V.surahId      having count(id)=(select count(*)from Verse where surahId=?1 and id >= ?3))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [surahId, identifier, startVerseId]);
  }

  @override
  Future<bool?> hasVerseAudiosWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from cuzAudioView where cuzNo=?1 and identifier=?2 and isDownloaded=1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<bool?> hasVerseAudiosWithCuzNoAndStartVerseId(
    int cuzNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from Verse V, VerseAudio VA      where V.id = VA.mealId and VA.identifier = ?2 and V.cuzNo=?1 and VA.mealId >= ?3       group by V.cuzNo      having count(id)=(select count(*)from Verse where cuzNo=?1 and id >= ?3))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [cuzNo, identifier, startVerseId]);
  }

  @override
  Future<bool?> hasVerseAudiosWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from Verse V, VerseAudio VA      where V.id = VA.mealId and VA.identifier = ?2 and V.pageNo=?1      group by V.pageNo      having count(id)=(select count(*)from Verse where pageNo=?1))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, identifier]);
  }

  @override
  Future<bool?> hasVerseAudiosWithPageNoAndStartVerseId(
    int pageNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from Verse V, VerseAudio VA      where V.id = VA.mealId and VA.identifier = ?2 and V.pageNo=?1 and VA.mealId >= ?3     group by V.pageNo      having count(id) = (select count(*)from Verse where pageNo=?1 and id >= ?3))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, identifier, startVerseId]);
  }

  @override
  Future<bool?> hasVerseAudiosWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from VerseAudio     where  identifier = ?2 and mealId=?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.cuzNo=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.surahId=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.pageNo=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.id=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getVerseAudioWithCuzNo(
    int cuzNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where VA.mealId = V.id and V.cuzNo=?1 and VA.identifier=?2 and V.id >= ?3     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier, startVerseId]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where VA.mealId = V.id and V.cuzNo=?1 and VA.identifier=?2     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getVerseAudioWithSurahId(
    int surahId,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where VA.mealId = V.id and V.surahId=?1 and VA.identifier=?2 and V.id >= ?3     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier, startVerseId]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where VA.mealId = V.id and V.surahId=?1 and VA.identifier=?2     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getVerseAudioWithPageNo(
    int pageNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where VA.mealId = V.id  and VA.identifier=?2 and V.pageNo=?1 and V.id >= ?3     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [pageNo, identifier, startVerseId]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V      where VA.mealId = V.id and V.pageNo=?1 and VA.identifier=?2     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from VerseAudio VA, Verse V     where VA.mealId = V.id and VA.mealId=?1 and VA.identifier=?2     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [mealId, identifier]);
  }

  @override
  Future<void> insertVerseAudio(VerseAudioEntity verseAudio) async {
    await _verseAudioEntityInsertionAdapter.insert(
        verseAudio, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertVerseAudios(List<VerseAudioEntity> verseAudios) async {
    await _verseAudioEntityInsertionAdapter.insertList(
        verseAudios, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateVerseAudios(List<VerseAudioEntity> verseAudios) async {
    await _verseAudioEntityUpdateAdapter.updateList(
        verseAudios, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteVerseAudios(List<VerseAudioEntity> verseAudios) async {
    await _verseAudioEntityDeletionAdapter.deleteList(verseAudios);
  }
}

class _$AudioViewDao extends AudioViewDao {
  _$AudioViewDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<SurahAudioView>> getStreamSurahAudioViews() {
    return _queryAdapter.queryListStream(
        'select * from surahAudioView where isDownloaded=1 order by surahId',
        mapper: (Map<String, Object?> row) => SurahAudioView(
            editionName: row['editionName'] as String,
            identifier: row['identifier'] as String,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            surahName: row['surahName'] as String,
            surahId: row['surahId'] as int),
        queryableName: 'surahAudioView',
        isView: true);
  }

  @override
  Stream<List<SurahAudioView>> getStreamSurahAudioViewsWithIdentifier(
      String identifier) {
    return _queryAdapter.queryListStream(
        'select * from surahAudioView where isDownloaded=1 and identifier=?1 order by surahId',
        mapper: (Map<String, Object?> row) => SurahAudioView(
            editionName: row['editionName'] as String,
            identifier: row['identifier'] as String,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            surahName: row['surahName'] as String,
            surahId: row['surahId'] as int),
        arguments: [identifier],
        queryableName: 'surahAudioView',
        isView: true);
  }

  @override
  Stream<List<CuzAudioView>> getStreamCuzAudioViews() {
    return _queryAdapter.queryListStream(
        'select * from cuzAudioView where isDownloaded=1 order by cuzNo',
        mapper: (Map<String, Object?> row) => CuzAudioView(
            editionName: row['editionName'] as String,
            identifier: row['identifier'] as String,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            cuzNo: row['cuzNo'] as int,
            cuzName: row['cuzName'] as String),
        queryableName: 'cuzAudioView',
        isView: true);
  }

  @override
  Stream<List<CuzAudioView>> getStreamCuzAudioViewsWithIdentifier(
      String identifier) {
    return _queryAdapter.queryListStream(
        'select * from cuzAudioView where isDownloaded=1 and identifier=?1 order by cuzNo',
        mapper: (Map<String, Object?> row) => CuzAudioView(
            editionName: row['editionName'] as String,
            identifier: row['identifier'] as String,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            cuzNo: row['cuzNo'] as int,
            cuzName: row['cuzName'] as String),
        arguments: [identifier],
        queryableName: 'cuzAudioView',
        isView: true);
  }
}

class _$PrayerDao extends PrayerDao {
  _$PrayerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _prayerEntityInsertionAdapter = InsertionAdapter(
            database,
            'Prayers',
            (PrayerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'arabicContent': item.arabicContent,
                  'meaningContent': item.meaningContent,
                  'pronunciationContent': item.pronunciationContent,
                  'source': item.source,
                  'typeId': item.typeId,
                  'orderItem': item.orderItem,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener),
        _prayerEntityUpdateAdapter = UpdateAdapter(
            database,
            'Prayers',
            ['id'],
            (PrayerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'arabicContent': item.arabicContent,
                  'meaningContent': item.meaningContent,
                  'pronunciationContent': item.pronunciationContent,
                  'source': item.source,
                  'typeId': item.typeId,
                  'orderItem': item.orderItem,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener),
        _prayerEntityDeletionAdapter = DeletionAdapter(
            database,
            'Prayers',
            ['id'],
            (PrayerEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'arabicContent': item.arabicContent,
                  'meaningContent': item.meaningContent,
                  'pronunciationContent': item.pronunciationContent,
                  'source': item.source,
                  'typeId': item.typeId,
                  'orderItem': item.orderItem,
                  'isRemovable': item.isRemovable ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PrayerEntity> _prayerEntityInsertionAdapter;

  final UpdateAdapter<PrayerEntity> _prayerEntityUpdateAdapter;

  final DeletionAdapter<PrayerEntity> _prayerEntityDeletionAdapter;

  @override
  Future<List<PrayerEntity>> getPrayersWithTypeId(int typeId) async {
    return _queryAdapter.queryList('select * from prayers where typeId = ?1',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [typeId]);
  }

  @override
  Future<List<PrayerEntity>> getPrayersWithTypeIdAndIsRemovable(
    int typeId,
    bool isRemovable,
  ) async {
    return _queryAdapter.queryList(
        'select * from prayers where typeId = ?1 and isRemovable = ?2',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [typeId, isRemovable ? 1 : 0]);
  }

  @override
  Future<PrayerEntity?> getPrayersWithId(int id) async {
    return _queryAdapter.query('select * from prayers where id = ?1',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<int?> getMaxOrderWithTypeId(int typeId) async {
    return _queryAdapter.query(
        'select max(orderItem) from prayers where typeId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [typeId]);
  }

  @override
  Future<List<PrayerEntity>> getPrayersSearchedLikeWithTypeId(
    int typeId,
    String query,
  ) async {
    return _queryAdapter.queryList(
        'select * from prayers where typeId = ?1 and lower(meaningContent) Like lower(?2)',
        mapper: (Map<String, Object?> row) => PrayerEntity(id: row['id'] as int?, name: row['name'] as String?, arabicContent: row['arabicContent'] as String?, meaningContent: row['meaningContent'] as String?, pronunciationContent: row['pronunciationContent'] as String?, source: row['source'] as String?, typeId: row['typeId'] as int, orderItem: row['orderItem'] as int, isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [typeId, query]);
  }

  @override
  Future<List<PrayerEntity>> getPrayersSearchedRegExWithTypeId(
    int typeId,
    String regExp,
  ) async {
    return _queryAdapter.queryList(
        'select * from prayers where typeId = ?1 and lower(meaningContent) REGEXP lower(?2)',
        mapper: (Map<String, Object?> row) => PrayerEntity(id: row['id'] as int?, name: row['name'] as String?, arabicContent: row['arabicContent'] as String?, meaningContent: row['meaningContent'] as String?, pronunciationContent: row['pronunciationContent'] as String?, source: row['source'] as String?, typeId: row['typeId'] as int, orderItem: row['orderItem'] as int, isRemovable: (row['isRemovable'] as int) != 0),
        arguments: [typeId, regExp]);
  }

  @override
  Future<void> insertPrayer(PrayerEntity prayer) async {
    await _prayerEntityInsertionAdapter.insert(
        prayer, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePrayer(PrayerEntity prayer) async {
    await _prayerEntityUpdateAdapter.update(prayer, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePrayer(PrayerEntity prayer) async {
    await _prayerEntityDeletionAdapter.delete(prayer);
  }
}

class _$EsmaulHusnaDao extends EsmaulHusnaDao {
  _$EsmaulHusnaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _esmaulHusnaEntityUpdateAdapter = UpdateAdapter(
            database,
            'EsmaulHusna',
            ['id'],
            (EsmaulHusnaEntity item) => <String, Object?>{
                  'id': item.id,
                  'orderItem': item.orderItem,
                  'name': item.name,
                  'arabicName': item.arabicName,
                  'searchName': item.searchName,
                  'meaning': item.meaning,
                  'dhikr': item.dhikr,
                  'virtue': item.virtue,
                  'counterId': item.counterId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<EsmaulHusnaEntity> _esmaulHusnaEntityUpdateAdapter;

  @override
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnas() async {
    return _queryAdapter.queryList(
        'select * from esmaulHusna order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(
            id: row['id'] as int?,
            orderItem: row['orderItem'] as int,
            name: row['name'] as String,
            arabicName: row['arabicName'] as String,
            meaning: row['meaning'] as String,
            dhikr: row['dhikr'] as String,
            virtue: row['virtue'] as String,
            counterId: row['counterId'] as int?,
            searchName: row['searchName'] as String));
  }

  @override
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnas() {
    return _queryAdapter.queryListStream(
        'select * from esmaulHusna order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(
            id: row['id'] as int?,
            orderItem: row['orderItem'] as int,
            name: row['name'] as String,
            arabicName: row['arabicName'] as String,
            meaning: row['meaning'] as String,
            dhikr: row['dhikr'] as String,
            virtue: row['virtue'] as String,
            counterId: row['counterId'] as int?,
            searchName: row['searchName'] as String),
        queryableName: 'esmaulHusna',
        isView: false);
  }

  @override
  Future<EsmaulHusnaEntity?> getEsmaulHusnaWithId(int id) async {
    return _queryAdapter.query(
        'select * from esmaulHusna where id=?1 order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(
            id: row['id'] as int?,
            orderItem: row['orderItem'] as int,
            name: row['name'] as String,
            arabicName: row['arabicName'] as String,
            meaning: row['meaning'] as String,
            dhikr: row['dhikr'] as String,
            virtue: row['virtue'] as String,
            counterId: row['counterId'] as int?,
            searchName: row['searchName'] as String),
        arguments: [id]);
  }

  @override
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedLike(
      String query) async {
    return _queryAdapter.queryList(
        'select * from esmaulHusna where      lower(name) Like lower(?1) or      lower(searchName) Like lower(?1) or      lower(meaning) Like lower(?1) or     lower(virtue) Like lower(?1)     order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(id: row['id'] as int?, orderItem: row['orderItem'] as int, name: row['name'] as String, arabicName: row['arabicName'] as String, meaning: row['meaning'] as String, dhikr: row['dhikr'] as String, virtue: row['virtue'] as String, counterId: row['counterId'] as int?, searchName: row['searchName'] as String),
        arguments: [query]);
  }

  @override
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedRegEx(
      String regExp) async {
    return _queryAdapter.queryList(
        'select * from esmaulHusna where       lower(name) REGEXP lower(?1) or      lower(searchName) REGEXP lower(?1) or      lower(meaning) REGEXP lower(?1) or      lower(virtue) REGEXP lower(?1)      order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(id: row['id'] as int?, orderItem: row['orderItem'] as int, name: row['name'] as String, arabicName: row['arabicName'] as String, meaning: row['meaning'] as String, dhikr: row['dhikr'] as String, virtue: row['virtue'] as String, counterId: row['counterId'] as int?, searchName: row['searchName'] as String),
        arguments: [regExp]);
  }

  @override
  Future<void> updateEsmaulHusna(EsmaulHusnaEntity esmaulHusna) async {
    await _esmaulHusnaEntityUpdateAdapter.update(
        esmaulHusna, OnConflictStrategy.replace);
  }
}
