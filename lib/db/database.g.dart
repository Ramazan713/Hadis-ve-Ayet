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

  CuzDao? _cuzDaoInstance;

  ListDaoOld? _listDaoOldInstance;

  SurahDao? _surahDaoInstance;

  VerseDao? _verseDaoInstance;

  TopicDaoOld? _topicDaoOldInstance;

  SectionDao? _sectionDaoInstance;

  TopicSavePointDao? _topicSavePointDaoInstance;

  HistoryDao? _historyDaoInstance;

  UserInfoDao? _userInfoDaoInstance;

  ManageAudioDao? _manageAudioDaoInstance;

  CounterDao? _counterDaoInstance;

  EsmaulHusnaDao? _esmaulHusnaDaoInstance;

  PrayerDao? _prayerDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `EsmaulHusna` (`id` INTEGER, `orderItem` INTEGER NOT NULL, `name` TEXT NOT NULL, `arabicName` TEXT NOT NULL, `meaning` TEXT NOT NULL, `dhikr` TEXT NOT NULL, `virtue` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Prayers` (`id` INTEGER, `name` TEXT NOT NULL, `meaningContent` TEXT NOT NULL, `arabicContent` TEXT NOT NULL, `pronunciationContent` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IslamicInfoItem` (`id` INTEGER, `titleId` INTEGER NOT NULL, `name` TEXT, `description` TEXT, FOREIGN KEY (`titleId`) REFERENCES `IslamicInfoTitle` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IslamicInfoTitle` (`id` INTEGER, `title` TEXT NOT NULL, `description` TEXT, `type` INTEGER NOT NULL, PRIMARY KEY (`id`))');
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
            'CREATE VIEW IF NOT EXISTS `cuzAudioView` AS select E.name editionName , E.identifier, V.cuzNo,\n  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded\n  from  verse V, VerseAudio A, AudioEdition E\n  where  A.identifier = E.identifier and A.mealId=V.id group by E.identifier,V.cuzNo');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `surahAudioView` AS select E.name editionName , E.identifier, V.surahId,\n  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded\n  from  verse V, VerseAudio A, AudioEdition E\n  where V.id=A.mealId and A.identifier = E.identifier group by E.identifier,V.surahId');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListHadithView` AS select L.id,L.name,L.isRemovable,count(LH.hadithId)itemCounts,L.isArchive,L.sourceId,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n  from List L left join ListHadith LH on  L.id=LH.listId where L.sourceId=1 group by L.id');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListVerseView` AS select L.id,L.name,L.isRemovable,L.isArchive,L.sourceId,count(LV.verseId)itemCounts,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n  from List L left join ListVerse LV on L.id=LV.listId where L.sourceId=2  group by L.id');
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
  CuzDao get cuzDao {
    return _cuzDaoInstance ??= _$CuzDao(database, changeListener);
  }

  @override
  ListDaoOld get listDaoOld {
    return _listDaoOldInstance ??= _$ListDaoOld(database, changeListener);
  }

  @override
  SurahDao get surahDao {
    return _surahDaoInstance ??= _$SurahDao(database, changeListener);
  }

  @override
  VerseDao get verseDao {
    return _verseDaoInstance ??= _$VerseDao(database, changeListener);
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
  TopicSavePointDao get topicSavePointDao {
    return _topicSavePointDaoInstance ??=
        _$TopicSavePointDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  UserInfoDao get userInfoDao {
    return _userInfoDaoInstance ??= _$UserInfoDao(database, changeListener);
  }

  @override
  ManageAudioDao get manageAudioDao {
    return _manageAudioDaoInstance ??=
        _$ManageAudioDao(database, changeListener);
  }

  @override
  CounterDao get counterDao {
    return _counterDaoInstance ??= _$CounterDao(database, changeListener);
  }

  @override
  EsmaulHusnaDao get esmaulHusnaDao {
    return _esmaulHusnaDaoInstance ??=
        _$EsmaulHusnaDao(database, changeListener);
  }

  @override
  PrayerDao get prayerDao {
    return _prayerDaoInstance ??= _$PrayerDao(database, changeListener);
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
        'select count(id) data from Hadith where lower(content)  REGEXP lower(?1)',
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
        'select * from Hadith where lower(content)  REGEXP lower(?3)       limit ?1 offset ?1 * ((?2) -1)',
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

class _$CuzDao extends CuzDao {
  _$CuzDao(
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

class _$SurahDao extends SurahDao {
  _$SurahDao(
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

class _$VerseDao extends VerseDao {
  _$VerseDao(
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
  Future<int> updateTopicSavePoint(TopicSavePointEntity topicSavePointEntity) {
    return _topicSavePointEntityUpdateAdapter.updateAndReturnChangedRows(
        topicSavePointEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTopicSavePoint(TopicSavePointEntity topicSavePointEntity) {
    return _topicSavePointEntityDeletionAdapter
        .deleteAndReturnChangedRows(topicSavePointEntity);
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
  Stream<List<HistoryEntity>> getStreamHistoryWithOrigin(int originId) {
    return _queryAdapter.queryListStream(
        'select * from history where originType=?1 order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        arguments: [originId],
        queryableName: 'history',
        isView: false);
  }

  @override
  Future<HistoryEntity?> getHistoryEntity(
    int originId,
    String name,
  ) async {
    return _queryAdapter.query(
        'select * from history where originType=?1 and name=?2',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        arguments: [originId, name]);
  }

  @override
  Future<int> insertHistory(HistoryEntity historyEntity) {
    return _historyEntityInsertionAdapter.insertAndReturnId(
        historyEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateHistory(HistoryEntity historyEntity) {
    return _historyEntityUpdateAdapter.updateAndReturnChangedRows(
        historyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteHistory(HistoryEntity historyEntity) {
    return _historyEntityDeletionAdapter
        .deleteAndReturnChangedRows(historyEntity);
  }

  @override
  Future<int> deleteHistories(List<HistoryEntity> historyEntities) {
    return _historyEntityDeletionAdapter
        .deleteListAndReturnChangedRows(historyEntities);
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

class _$ManageAudioDao extends ManageAudioDao {
  _$ManageAudioDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Stream<List<SurahAudioView>> getStreamSurahAudioViews(String identifier) {
    return _queryAdapter.queryListStream(
        'select * from surahAudioView where isDownloaded=1 and identifier=?1 order by surahId',
        mapper: (Map<String, Object?> row) => SurahAudioView(
            editionName: row['editionName'] as String,
            identifier: row['identifier'] as String,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            surahId: row['surahId'] as int),
        arguments: [identifier],
        queryableName: 'surahAudioView',
        isView: true);
  }

  @override
  Stream<List<CuzAudioView>> getStreamCuzAudioViews(String identifier) {
    return _queryAdapter.queryListStream(
        'select * from cuzAudioView where isDownloaded=1 and identifier=?1 order by cuzNo',
        mapper: (Map<String, Object?> row) => CuzAudioView(
            editionName: row['editionName'] as String,
            identifier: row['identifier'] as String,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            cuzNo: row['cuzNo'] as int),
        arguments: [identifier],
        queryableName: 'cuzAudioView',
        isView: true);
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

class _$EsmaulHusnaDao extends EsmaulHusnaDao {
  _$EsmaulHusnaDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<EsmaulHusnaEntity>> getAllEsmaulHusna() async {
    return _queryAdapter.queryList('select * from esmaulHusna',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(
            id: row['id'] as int?,
            orderItem: row['orderItem'] as int,
            name: row['name'] as String,
            arabicName: row['arabicName'] as String,
            meaning: row['meaning'] as String,
            dhikr: row['dhikr'] as String,
            virtue: row['virtue'] as String));
  }

  @override
  Future<EsmaulHusnaEntity?> getEsmaulHusnaWithId(int id) async {
    return _queryAdapter.query('select * from esmaulHusna where id=?1',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(
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

class _$PrayerDao extends PrayerDao {
  _$PrayerDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<PrayerEntity>> getPrayers() async {
    return _queryAdapter.queryList('select * from prayers',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            meaningContent: row['meaningContent'] as String,
            pronunciationContent: row['pronunciationContent'] as String?,
            arabicContent: row['arabicContent'] as String));
  }

  @override
  Future<PrayerEntity?> getPrayerWithId(int id) async {
    return _queryAdapter.query('select * from prayers where id=?1',
        mapper: (Map<String, Object?> row) => PrayerEntity(
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
  Future<void> deleteSavePointsWithQuery(
    int savePointType,
    String parentKey,
  ) async {
    await _queryAdapter.queryNoReturn(
        'delete from savePoints where savePointType=?1 and parentKey=?2',
        arguments: [savePointType, parentKey]);
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
            ') and savePointType=?1 order by modifiedDate desc',
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
