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

  CounterDao? _counterDaoInstance;

  IslamicInfoDao? _islamicInfoDaoInstance;

  UserInfoDao? _userInfoDaoInstance;

  BackupMetaDao? _backupMetaDaoInstance;

  BackupDao? _backupDaoInstance;

  SelectVersePageDao? _selectVersePageDaoInstance;

  ItemPositionDao? _itemPositionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 6,
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
            'CREATE TABLE IF NOT EXISTS `Hadiths` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER NOT NULL, `content` TEXT NOT NULL, `source` TEXT NOT NULL, `contentSize` INTEGER NOT NULL, FOREIGN KEY (`bookId`) REFERENCES `Books` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ListHadiths` (`listId` INTEGER NOT NULL, `hadithId` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`listId`) REFERENCES `List<dynamic>` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`hadithId`) REFERENCES `Hadiths` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`listId`, `hadithId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ListVerses` (`listId` INTEGER NOT NULL, `verseId` INTEGER NOT NULL, `pos` INTEGER NOT NULL, FOREIGN KEY (`listId`) REFERENCES `List<dynamic>` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`verseId`) REFERENCES `Verses` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`listId`, `verseId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Lists` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isRemovable` INTEGER NOT NULL, `sourceId` INTEGER NOT NULL, `isArchive` INTEGER NOT NULL, `pos` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Prayers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `arabicContent` TEXT, `meaningContent` TEXT, `pronunciationContent` TEXT, `source` TEXT, `typeId` INTEGER NOT NULL, `orderItem` INTEGER NOT NULL, `isRemovable` INTEGER NOT NULL, `counterId` INTEGER, `parentPrayerId` INTEGER, `updateCounter` INTEGER NOT NULL, FOREIGN KEY (`counterId`) REFERENCES `Counters` (`id`) ON UPDATE CASCADE ON DELETE SET NULL, FOREIGN KEY (`parentPrayerId`) REFERENCES `Prayers` (`id`) ON UPDATE CASCADE ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EsmaulHusnas` (`id` INTEGER, `orderItem` INTEGER NOT NULL, `name` TEXT NOT NULL, `arabicName` TEXT NOT NULL, `searchName` TEXT NOT NULL, `meaning` TEXT NOT NULL, `dhikr` TEXT NOT NULL, `virtue` TEXT NOT NULL, `counterId` INTEGER, FOREIGN KEY (`counterId`) REFERENCES `Counters` (`id`) ON UPDATE NO ACTION ON DELETE SET NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Counters` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `content` TEXT, `arabicContent` TEXT, `meaning` TEXT, `description` TEXT, `orderItem` INTEGER NOT NULL, `lastCounter` INTEGER NOT NULL, `goal` INTEGER, `typeId` INTEGER NOT NULL, `prayerId` INTEGER, FOREIGN KEY (`prayerId`) REFERENCES `Prayers` (`id`) ON UPDATE CASCADE ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SavePointTypes` (`id` INTEGER, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Verses` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `bookId` INTEGER NOT NULL, `surahId` INTEGER NOT NULL, `cuzNo` INTEGER NOT NULL, `pageNo` INTEGER NOT NULL, `verseNumber` TEXT NOT NULL, `content` TEXT NOT NULL, `isProstrationVerse` INTEGER NOT NULL, FOREIGN KEY (`cuzNo`) REFERENCES `Cuzs` (`cuzNo`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`surahId`) REFERENCES `Surahs` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bookId`) REFERENCES `Books` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Histories` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `originType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, FOREIGN KEY (`originType`) REFERENCES `SourceTypes` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AudioEditions` (`identifier` TEXT NOT NULL, `name` TEXT NOT NULL, `isSelected` INTEGER NOT NULL, `fileName` TEXT, PRIMARY KEY (`identifier`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VerseAudios` (`mealId` INTEGER NOT NULL, `identifier` TEXT NOT NULL, `fileName` TEXT, `hasEdited` INTEGER NOT NULL, FOREIGN KEY (`mealId`) REFERENCES `Verses` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`identifier`) REFERENCES `AudioEditions` (`identifier`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mealId`, `identifier`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IslamicInfoTitles` (`id` INTEGER, `title` TEXT NOT NULL, `description` TEXT, `type` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IslamicInfoItems` (`id` INTEGER, `titleId` INTEGER NOT NULL, `name` TEXT, `description` TEXT, FOREIGN KEY (`titleId`) REFERENCES `IslamicInfoTitles` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserInfos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT NOT NULL, `img` BLOB)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BackupMetas` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fileName` TEXT NOT NULL, `updatedDate` TEXT NOT NULL, `isAuto` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PrayerVerses` (`id` INTEGER, `verseId` INTEGER NOT NULL, `prayerId` INTEGER NOT NULL, `orderItem` INTEGER NOT NULL, FOREIGN KEY (`verseId`) REFERENCES `Verses` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`prayerId`) REFERENCES `Prayers` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TopicSavePoints` (`id` INTEGER, `pos` INTEGER NOT NULL, `type` INTEGER NOT NULL, `parentKey` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cuzs` (`cuzNo` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`cuzNo`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Surahs` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `searchName` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VerseArabics` (`id` INTEGER, `mealId` INTEGER NOT NULL, `verse` TEXT NOT NULL, `verseNumber` TEXT NOT NULL, `verseNumberTr` INTEGER NOT NULL, FOREIGN KEY (`mealId`) REFERENCES `Verses` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SavePoints` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemIndexPos` INTEGER NOT NULL, `title` TEXT NOT NULL, `autoType` INTEGER NOT NULL, `modifiedDate` TEXT NOT NULL, `savePointType` INTEGER NOT NULL, `bookScope` INTEGER NOT NULL, `parentName` TEXT NOT NULL, `parentKey` TEXT NOT NULL)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListVerseView` AS     select L.id, L.name, L.isRemovable, L.isArchive, L.sourceId, count(LV.verseId)itemCounts,\n    ifnull(max(LV.pos),0)contentMaxPos,L.pos listPos \n    from lists L left join listVerses LV on L.id=LV.listId where L.sourceId=2 group by L.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ListHadithView` AS     select L.id, L.name, L.isRemovable, count(LH.hadithId)itemCounts, L.isArchive, L.sourceId,\n    ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos \n    from lists L left join listHadiths LH on L.id=LH.listId where L.sourceId=1 group by L.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `CuzAudioView` AS     select E.name editionName, E.identifier,  V.cuzNo, \n    case when count(A.mealId) = (select count(VX.id) from verses VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded,\n    C.name cuzName\n    from  verses V, verseAudios A, audioEditions E, cuzs C\n    where  A.identifier = E.identifier and A.mealId=V.id and C.cuzNo = V.cuzNo\n    group by E.identifier, C.name, V.cuzNo\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `SurahAudioView` AS     select E.name editionName , E.identifier, V.surahId, S.name surahName,\n    case when count(A.mealId) = (select count(VX.id) from verses VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded\n    from  verses V, verseAudios A, audioEditions E, surahs S\n    where V.id = A.mealId and A.identifier = E.identifier and S.id = V.surahId\n    group by E.identifier,V.surahId, S.name\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `SectionTopicsView` AS     select S.id, S.name, S.searchName, S.bookId, count(T.id)topicCount from sections S, topics T \n    where S.id = T.sectionId group by S.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `TopicHadithsView` AS     select T.id,T.name, T.searchName, T.sectionId, count(HT.hadithId)hadithCount from \n    topics T, hadithTopics HT where T.id = HT.topicId group by T.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `TopicVersesView` AS   select T.id,T.name, T.searchName, T.sectionId, count(VT.verseId)verseCount \n  from topics T, verseTopics VT where T.id=VT.topicId group by T.id\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `VerseInfoListView` AS     select V.id verseId,\n    (select exists(select * from listVerses LV, lists L\n      where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LV.verseId = V.id)) inAnyList,\n    (select exists(select * from listVerses LV, lists L\n      where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LV.verseId = V.id)) inAnyArchiveList,  \n    (select exists(select * from listVerses LV, lists L\n      where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite \n    from verses V\n  ');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `HadithInfoListView` AS     select H.id hadithId,\n    (select exists(select * from listHadiths LH, lists L\n      where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LH.hadithId = H.id)) inAnyList,\n    (select exists(select * from listHadiths LH, lists L\n      where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LH.hadithId = H.id)) inAnyArchiveList,\n    (select exists(select * from listHadiths LH, lists L\n      where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite \n    from hadiths H\n  ');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
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

  @override
  CounterDao get counterDao {
    return _counterDaoInstance ??= _$CounterDao(database, changeListener);
  }

  @override
  IslamicInfoDao get islamicInfoDao {
    return _islamicInfoDaoInstance ??=
        _$IslamicInfoDao(database, changeListener);
  }

  @override
  UserInfoDao get userInfoDao {
    return _userInfoDaoInstance ??= _$UserInfoDao(database, changeListener);
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
  SelectVersePageDao get selectVersePageDao {
    return _selectVersePageDaoInstance ??=
        _$SelectVersePageDao(database, changeListener);
  }

  @override
  ItemPositionDao get itemPositionDao {
    return _itemPositionDaoInstance ??=
        _$ItemPositionDao(database, changeListener);
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
    return _queryAdapter.query('select count(*) from hadiths where bookId = ?1',
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
        'select * from hadiths where bookId = ?1 limit ?2 offset ?3',
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
        'select exists(select * from hadiths where bookId = ?1 and id = ?2 )',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [bookId, id]);
  }

  @override
  Future<int?> getHadithCountByTopicId(int topicId) async {
    return _queryAdapter.query(
        'select count(*) from hadiths H, hadithTopics HT where     HT.hadithId=H.id and HT.topicId=?1',
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
        'select H.* from hadiths H, hadithTopics HT      where HT.hadithId=H.id and HT.topicId=?1 limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [topicId, pageSize, startIndex]);
  }

  @override
  Future<bool?> getExistsHadithByTopicId(
    int topicId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select H.* from hadiths H, hadithTopics HT      where HT.hadithId=H.id and HT.topicId = ?1 and id = ?2 )',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [topicId, id]);
  }

  @override
  Future<String?> getTopicName(int topicId) async {
    return _queryAdapter.query('select name from topics where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [topicId]);
  }

  @override
  Future<int?> getHadithCountByListId(int listId) async {
    return _queryAdapter.query(
        'select count(*) from hadiths H, listHadiths LH     where LH.hadithId=H.id and LH.listId=?1',
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
        'select H.* from hadiths H, listHadiths LH     where LH.hadithId=H.id and LH.listId=?1 order by LH.pos desc limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [listId, pageSize, startIndex]);
  }

  @override
  Future<bool?> getExistsHadithByListId(
    int listId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select H.* from hadiths H, listHadiths LH     where LH.hadithId=H.id and LH.listId=?1 and id = ?2 )',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [listId, id]);
  }

  @override
  Future<int?> getHadithCountByRegExp(String regExp) async {
    return _queryAdapter.query(
        'select count(*) from hadiths where lower(content) REGEXP lower(?1)',
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
        'select * from hadiths where lower(content) REGEXP lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [regExp, pageSize, startIndex]);
  }

  @override
  Future<HadithEntity?> getHadithById(int id) async {
    return _queryAdapter.query('select * from hadiths where id=?1',
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
    return _queryAdapter.query('select count(*) from hadiths where id<?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<List<HadithEntity>> getHadithsFromListId(int listId) async {
    return _queryAdapter.queryList(
        'select H.* from hadiths H, listHadiths LH     where LH.hadithId=H.id and LH.listId=?1 order by     LH.pos desc',
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
            'Lists',
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
            'Lists',
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
            'Lists',
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
        'select ifnull(max(pos),0) data from lists where sourceId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [sourceId]);
  }

  @override
  Future<int?> getMaxPosList() async {
    return _queryAdapter.query('select ifnull(max(pos),0) data from lists',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<ListEntity?> getFavoriteList(int sourceId) async {
    return _queryAdapter.query(
        'select * from lists where isRemovable = 0 and sourceId = ?1',
        mapper: (Map<String, Object?> row) => ListEntity(
            id: row['id'] as int?,
            isArchive: (row['isArchive'] as int) != 0,
            name: row['name'] as String,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int),
        arguments: [sourceId]);
  }

  @override
  Future<String?> getListName(int listId) async {
    return _queryAdapter.query('select name from lists where id = ?1',
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
            'ListHadiths',
            (ListHadithEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityUpdateAdapter = UpdateAdapter(
            database,
            'ListHadiths',
            ['listId', 'hadithId'],
            (ListHadithEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityDeletionAdapter = DeletionAdapter(
            database,
            'ListHadiths',
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
        'select * from listHadiths where hadithId = ?1 and listId = ?2',
        mapper: (Map<String, Object?> row) => ListHadithEntity(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [hadithId, listId]);
  }

  @override
  Future<int?> getMaxPos() async {
    return _queryAdapter.query('select ifnull(max(pos),0) from listHadiths',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<ListHadithEntity>> getListHadithsWithListId(int listId) async {
    return _queryAdapter.queryList('select * from listHadiths where listId=?1',
        mapper: (Map<String, Object?> row) => ListHadithEntity(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int),
        arguments: [listId]);
  }

  @override
  Stream<List<int>> getStreamListIdsFromHadithId(int hadithId) {
    return _queryAdapter.queryListStream(
        'select listId from listHadiths where hadithId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [hadithId],
        queryableName: 'listHadiths',
        isView: false);
  }

  @override
  Future<List<int>> getListIdsFromHadithId(int hadithId) async {
    return _queryAdapter.queryList(
        'select listId from listHadiths where hadithId = ?1',
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
            'ListVerses',
            (ListVerseEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityUpdateAdapter = UpdateAdapter(
            database,
            'ListVerses',
            ['listId', 'verseId'],
            (ListVerseEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityDeletionAdapter = DeletionAdapter(
            database,
            'ListVerses',
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
        'select * from listVerses where verseId = ?1 and listId = ?2',
        mapper: (Map<String, Object?> row) => ListVerseEntity(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [verseId, listId]);
  }

  @override
  Future<int?> getMaxPos() async {
    return _queryAdapter.query('select ifnull(max(pos),0) from listVerses',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<ListVerseEntity>> getListVersesWithListId(int listId) async {
    return _queryAdapter.queryList('select * from listVerses where listId=?1',
        mapper: (Map<String, Object?> row) => ListVerseEntity(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int),
        arguments: [listId]);
  }

  @override
  Future<List<int>> getListIdsFromVerseId(int verseId) async {
    return _queryAdapter.queryList(
        'select listId from listVerses where verseId = ?1',
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
            'SavePoints',
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
            'SavePoints',
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
            'SavePoints',
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
        'select T.name from topics T, hadithTopics HT     where T.id=HT.topicId and HT.hadithId=?1',
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
            searchName: row['searchName'] as String,
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
        'select * from topicHadithsView where sectionId = ?1 and      (name like ?2 or searchName like ?2)      order by (case when lower(name)=?4 then 1       when name like ?3 then 2       when searchName like ?3 then 3 else 4 end)',
        mapper: (Map<String, Object?> row) => TopicHadithsView(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String,
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
            searchName: row['searchName'] as String,
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
        'select TH.* from topicHadithsView TH, sectionTopicsView ST     where TH.sectionId = ST.id and ST.bookId = ?1 and     (TH.name like ?2 or TH.searchName like ?2)     order by (case when lower(TH.name)=?4 then 1      when TH.name like ?3 then 2      when TH.searchName like ?3 then 3 else 4 end ), TH.id',
        mapper: (Map<String, Object?> row) => TopicHadithsView(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String,
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
            searchName: row['searchName'] as String,
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
        'select * from topicVersesView where sectionId = ?1 and      (name like ?2 or searchName like ?2)      order by       (case when lower(name)=?4 then 1       when name like ?3 then 2       when searchName like ?3 then 3      else 4 end )',
        mapper: (Map<String, Object?> row) => TopicVersesView(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String,
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
            searchName: row['searchName'] as String,
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
        'select TV.* from topicVersesView TV, sectionTopicsView ST     where TV.sectionId = ST.id and ST.bookId = ?1 and     (TV.name like ?2 or TV.searchName like ?2)     order by (case when lower(TV.name)=?4 then 1      when TV.name like ?3 then 2      when TV.searchName like ?3 then 3     else 4 end ), TV.id',
        mapper: (Map<String, Object?> row) => TopicVersesView(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String,
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
            searchName: row['searchName'] as String,
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
        'select * from sectionTopicsView where bookId = ?1 and      (name like ?2 or searchName like ?2)      order by       (case when lower(name)=?4 then 1       when name like ?3 then 2       when searchName like ?3 then 3      else 4 end)',
        mapper: (Map<String, Object?> row) => SectionTopicsView(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String,
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
            'TopicSavePoints',
            (TopicSavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _topicSavePointEntityUpdateAdapter = UpdateAdapter(
            database,
            'TopicSavePoints',
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
            'TopicSavePoints',
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
        'select * from topicSavePoints where type=?1 and parentKey=?2      order by id desc limit 1',
        mapper: (Map<String, Object?> row) => TopicSavePointEntity(
            id: row['id'] as int?,
            pos: row['pos'] as int,
            type: row['type'] as int,
            parentKey: row['parentKey'] as String),
        arguments: [type, parentKey],
        queryableName: 'topicSavePoints',
        isView: false);
  }

  @override
  Future<TopicSavePointEntity?> getTopicSavePointEntity(
    int type,
    String parentKey,
  ) async {
    return _queryAdapter.query(
        'select * from topicSavePoints where type=?1 and parentKey=?2      order by id desc limit 1',
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
    return _queryAdapter.queryList('select * from cuzs',
        mapper: (Map<String, Object?> row) =>
            CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String));
  }

  @override
  Future<CuzEntity?> getCuz(int cuzNo) async {
    return _queryAdapter.query('select * from cuzs where cuzNo=?1',
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
    return _queryAdapter.queryList('select * from surahs',
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
        'select * from surahs where name like ?1 or searchName like ?1      order by (case when lower(searchName)=?3 then 1      when searchName like ?2 then 2      else 3 end)',
        mapper: (Map<String, Object?> row) => SurahEntity(id: row['id'] as int, name: row['name'] as String, searchName: row['searchName'] as String),
        arguments: [querySearchFull, queryOrderForLike, queryRaw]);
  }

  @override
  Future<SurahEntity?> getSurah(int surahId) async {
    return _queryAdapter.query('select * from surahs where id=?1',
        mapper: (Map<String, Object?> row) => SurahEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String),
        arguments: [surahId]);
  }

  @override
  Future<SurahEntity?> getSurahFromMealId(int mealId) async {
    return _queryAdapter.query(
        'select S.* from Surahs S, Verses V where V.surahId = S.id and V.id = ?1',
        mapper: (Map<String, Object?> row) => SurahEntity(id: row['id'] as int, name: row['name'] as String, searchName: row['searchName'] as String),
        arguments: [mealId]);
  }

  @override
  Future<String?> getSurahNameById(int surahId) async {
    return _queryAdapter.query('select name from surahs where id = ?1',
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
    return _queryAdapter.queryList('select * from verseArabics where mealId=?1',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(
            id: row['id'] as int?,
            mealId: row['mealId'] as int,
            verse: row['verse'] as String,
            verseNumber: row['verseNumber'] as String,
            verseNumberTr: row['verseNumberTr'] as int),
        arguments: [mealId]);
  }

  @override
  Future<List<VerseArabicEntity>> getArabicVersesByMealIds(
      List<int> mealIds) async {
    const offset = 1;
    final _sqliteVariablesForMealIds =
        Iterable<String>.generate(mealIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from verseArabics where mealId in (' +
            _sqliteVariablesForMealIds +
            ') order by id',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(
            id: row['id'] as int?,
            mealId: row['mealId'] as int,
            verse: row['verse'] as String,
            verseNumber: row['verseNumber'] as String,
            verseNumberTr: row['verseNumberTr'] as int),
        arguments: [...mealIds]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.id=?1 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.id=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithMealIdList(
    List<int> mealIds,
    String identifier,
  ) async {
    const offset = 2;
    final _sqliteVariablesForMealIds =
        Iterable<String>.generate(mealIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.id in (' +
            _sqliteVariablesForMealIds +
            ') and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.id in (' +
            _sqliteVariablesForMealIds +
            ') and A.identifier = ?1)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [identifier, ...mealIds]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.surahId=?1 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.surahId=?1 and A.identifier = ?2)     order by mealId',
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
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.surahId=?1 and V.id >= ?3 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.surahId=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [surahId, identifier, startVerseId]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.cuzNo=?1 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.cuzNo=?1 and A.identifier = ?2)     order by mealId',
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
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.cuzNo=?1 and V.id >= ?3 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.cuzNo=?1 and A.identifier = ?2)     order by mealId',
        mapper: (Map<String, Object?> row) => VerseArabicEntity(id: row['id'] as int?, mealId: row['mealId'] as int, verse: row['verse'] as String, verseNumber: row['verseNumber'] as String, verseNumberTr: row['verseNumberTr'] as int),
        arguments: [cuzNo, identifier, startVerseId]);
  }

  @override
  Future<List<VerseArabicEntity>> getAllNotDownloadedVerseArabicsWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.pageNo=?1 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.pageNo=?1 and A.identifier = ?2)     order by mealId',
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
        'select VA.* from verseArabics VA, verses V      where VA.mealId = V.id and V.pageNo=?1 and V.id >= ?3 and VA.mealId not in      (select A.mealId from verses V, verseAudios A where V.id=A.mealId and V.pageNo=?1 and A.identifier = ?2)     order by mealId',
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
        'select * from verses where surahId=?1 limit ?2 offset ?3',
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
    return _queryAdapter.query('select count(*) from verses where surahId=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [surahId]);
  }

  @override
  Future<bool?> getExistsVerseBySurahId(
    int surahId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select * from verses where surahId = ?1 and id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [surahId, id]);
  }

  @override
  Future<int?> getSurahPosById(
    int id,
    int surahId,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verses where surahId = ?2 and id < ?1',
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
        'select * from verses where cuzNo=?1 limit ?2 offset ?3',
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
    return _queryAdapter.query('select count(*) from verses where cuzNo=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cuzNo]);
  }

  @override
  Future<bool?> getExistsVerseByCuzNo(
    int cuzNo,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select * from verses where cuzNo = ?1 and id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [cuzNo, id]);
  }

  @override
  Future<int?> getCuzPosById(
    int id,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verses where cuzNo = ?2 and id < ?1',
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
        'select V.* from verses V, ListVerses LV where V.id = LV.verseId and LV.listId = ?1     order by LV.pos desc limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [listId, pageSize, startIndex]);
  }

  @override
  Future<int?> getVerseCountByListId(int listId) async {
    return _queryAdapter.query(
        'select count(*) from verses V, listVerses LV where V.id = LV.verseId and LV.listId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [listId]);
  }

  @override
  Future<bool?> getExistsVerseByListId(
    int listId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(     select V.* from verses V, ListVerses LV where V.id = LV.verseId and LV.listId = ?1     and V.id = ?2)',
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
        'select V.* from verses V, verseTopics VT where V.id = VT.verseId and VT.topicId = ?1     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [topicId, pageSize, startIndex]);
  }

  @override
  Future<int?> getVerseCountByTopicId(int topicId) async {
    return _queryAdapter.query(
        'select count(*) from verses V, verseTopics VT where V.id = VT.verseId and VT.topicId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [topicId]);
  }

  @override
  Future<bool?> getExistsVerseByTopicId(
    int topicId,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(     select V.* from verses V, verseTopics VT where V.id = VT.verseId and VT.topicId = ?1     and V.id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [topicId, id]);
  }

  @override
  Future<List<VerseEntity>> getPagingVersesByPageNo(int pageNo) async {
    return _queryAdapter.queryList('select * from verses where pageNo = ?1',
        mapper: (Map<String, Object?> row) => VerseEntity(
            id: row['id'] as int?,
            surahId: row['surahId'] as int,
            cuzNo: row['cuzNo'] as int,
            pageNo: row['pageNo'] as int,
            verseNumber: row['verseNumber'] as String,
            content: row['content'] as String,
            isProstrationVerse: (row['isProstrationVerse'] as int) != 0,
            bookId: row['bookId'] as int),
        arguments: [pageNo]);
  }

  @override
  Future<int?> getVerseCountByPageNo() async {
    return _queryAdapter.query('select count(distinct pageNo) from verses',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<bool?> getExistsVerseByPageNo(
    int pageNo,
    int id,
  ) async {
    return _queryAdapter.query(
        'select exists(select * from verses where pageNo = ?1 and id = ?2)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, id]);
  }

  @override
  Future<VerseEntity?> getVerseById(int id) async {
    return _queryAdapter.query('select * from verses where id = ?1',
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
    return _queryAdapter.query('select count(*) from verses where id<?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<List<VerseEntity>> getVersesFromListId(int listId) async {
    return _queryAdapter.queryList(
        'select V.* from verses V, ListVerses LV where V.id = LV.verseId and LV.listId = ?1      order by LV.pos desc',
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
        'select * from verses where id in (' + _sqliteVariablesForIds + ')',
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

  @override
  Future<List<VerseEntity>> getVersesByOffsetAndSurah(
    int surahId,
    int surahSize,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'select * from verses where surahId = ?1 order by id limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [surahId, surahSize, offset]);
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
    return _queryAdapter.query('select name from topics where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [topicId]);
  }

  @override
  Future<String?> getCounterTitleById(int id) async {
    return _queryAdapter.query('select name from counters where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<String?> getListTitleById(int listId) async {
    return _queryAdapter.query('select name from lists where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [listId]);
  }

  @override
  Future<String?> getSurahTitleById(int surahId) async {
    return _queryAdapter.query('select name from surahs where id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [surahId]);
  }

  @override
  Future<String?> getCuzTitleById(int cuzNo) async {
    return _queryAdapter.query('select name from cuzs where cuzNo = ?1',
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
        'select count(id) from hadiths where lower(content) REGEXP lower(?1)',
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
        'select * from hadiths where lower(content) REGEXP lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [regExp, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountAllHadithByLike(String query) async {
    return _queryAdapter.query(
        'select count(id) from hadiths where lower(content) Like lower(?1)',
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
        'select * from hadiths where lower(content) Like lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [query, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountHadithByRegexAndBookId(
    int bookId,
    String regExp,
  ) async {
    return _queryAdapter.query(
        'select count(id) from hadiths where bookId=?1 and lower(content) REGEXP lower(?2)',
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
        'select * from hadiths where bookId=?1 and lower(content) REGEXP lower(?2)      limit ?3 offset ?4',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [bookId, regExp, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountHadithByLikeAndBookId(
    int bookId,
    String query,
  ) async {
    return _queryAdapter.query(
        'select count(id) from hadiths where bookId=?1 and lower(content) Like lower(?2)',
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
        'select * from hadiths where bookId=?1 and lower(content) Like lower(?2)      limit ?3 offset ?4',
        mapper: (Map<String, Object?> row) => HadithEntity(id: row['id'] as int?, bookId: row['bookId'] as int, content: row['content'] as String, contentSize: row['contentSize'] as int, source: row['source'] as String),
        arguments: [bookId, query, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountVerseByRegex(String regExp) async {
    return _queryAdapter.query(
        'select count(id) data from verses V where lower(content)  REGEXP lower(?1)',
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
        'select * from verses where lower(content)  REGEXP lower(?1)     limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => VerseEntity(id: row['id'] as int?, surahId: row['surahId'] as int, cuzNo: row['cuzNo'] as int, pageNo: row['pageNo'] as int, verseNumber: row['verseNumber'] as String, content: row['content'] as String, isProstrationVerse: (row['isProstrationVerse'] as int) != 0, bookId: row['bookId'] as int),
        arguments: [regExp, pageSize, startIndex]);
  }

  @override
  Future<int?> getCountVerseByLike(String query) async {
    return _queryAdapter.query(
        'select count(id) data from verses V where lower(content) Like lower(?1)',
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
        'select * from verses where lower(content)  Like lower(?1)     limit ?2 offset ?3',
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
            'Histories',
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _historyEntityUpdateAdapter = UpdateAdapter(
            database,
            'Histories',
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
            'Histories',
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
        'select * from histories order by modifiedDate desc',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String),
        queryableName: 'histories',
        isView: false);
  }

  @override
  Future<HistoryEntity?> getHistoryEntity(String name) async {
    return _queryAdapter.query(
        'select * from histories where lower(name) = lower(?1)',
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
            'AudioEditions',
            (AudioEditionEntity item) => <String, Object?>{
                  'identifier': item.identifier,
                  'name': item.name,
                  'isSelected': item.isSelected ? 1 : 0,
                  'fileName': item.fileName
                },
            changeListener),
        _audioEditionEntityUpdateAdapter = UpdateAdapter(
            database,
            'AudioEditions',
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
    return _queryAdapter.queryList('select * from audioEditions',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?));
  }

  @override
  Stream<List<AudioEditionEntity>> getStreamEditions() {
    return _queryAdapter.queryListStream('select * from audioEditions',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        queryableName: 'audioEditions',
        isView: false);
  }

  @override
  Stream<AudioEditionEntity?> getSelectedStreamEdition() {
    return _queryAdapter.queryStream(
        'select * from audioEditions where isSelected = 1',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?),
        queryableName: 'audioEditions',
        isView: false);
  }

  @override
  Future<AudioEditionEntity?> getSelectedEdition() async {
    return _queryAdapter.query(
        'select * from audioEditions where isSelected = 1',
        mapper: (Map<String, Object?> row) => AudioEditionEntity(
            identifier: row['identifier'] as String,
            name: row['name'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            fileName: row['fileName'] as String?));
  }

  @override
  Future<bool?> isEditionNotEmpty() async {
    return _queryAdapter.query(
        'select exists(select 1 from audioEditions) as data',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0);
  }

  @override
  Future<AudioEditionEntity?> getEditionByIdentifier(String identifier) async {
    return _queryAdapter.query(
        'select * from audioEditions where identifier = ?1',
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
        'select name from audioEditions where identifier = ?1',
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
            'VerseAudios',
            (VerseAudioEntity item) => <String, Object?>{
                  'mealId': item.mealId,
                  'identifier': item.identifier,
                  'fileName': item.fileName,
                  'hasEdited': item.hasEdited ? 1 : 0
                },
            changeListener),
        _verseAudioEntityUpdateAdapter = UpdateAdapter(
            database,
            'VerseAudios',
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
            'VerseAudios',
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
        'delete from verseAudios where identifier = ?1 and mealId=?2',
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
        'select exists(select 1 from verses V, verseAudios VA      where V.id = VA.mealId and VA.identifier = ?2 and V.surahId=?1 and VA.mealId >= ?3     group by V.surahId      having count(id)=(select count(*)from verses where surahId=?1 and id >= ?3))',
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
        'select exists(select 1 from verses V, verseAudios VA      where V.id = VA.mealId and VA.identifier = ?2 and V.cuzNo=?1 and VA.mealId >= ?3       group by V.cuzNo      having count(id)=(select count(*)from verses where cuzNo=?1 and id >= ?3))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [cuzNo, identifier, startVerseId]);
  }

  @override
  Future<bool?> hasVerseAudiosWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from verses V, verseAudios VA      where V.id = VA.mealId and VA.identifier = ?2 and V.pageNo=?1      group by V.pageNo      having count(id)=(select count(*)from verses where pageNo=?1))',
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
        'select exists(select 1 from verses V, verseAudios VA      where V.id = VA.mealId and VA.identifier = ?2 and V.pageNo=?1 and VA.mealId >= ?3     group by V.pageNo      having count(id) = (select count(*)from verses where pageNo=?1 and id >= ?3))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, identifier, startVerseId]);
  }

  @override
  Future<bool?> hasVerseAudiosWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.query(
        'select exists(select 1 from verseAudios     where  identifier = ?2 and mealId=?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [mealId, identifier]);
  }

  @override
  Future<bool?> hasVerseAudiosWithMealIdList(
    List<int> mealIds,
    String identifier,
  ) async {
    const offset = 2;
    final _sqliteVariablesForMealIds =
        Iterable<String>.generate(mealIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.query(
        'select exists(select 1 from verseAudios     where identifier = ?1 and mealId in (' +
            _sqliteVariablesForMealIds +
            ')     group by identifier      having count(*) = (select count(*)from verses where id in (' +
            _sqliteVariablesForMealIds +
            ')))',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [identifier, ...mealIds]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.cuzNo=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.surahId=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.pageNo=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where V.id = VA.mealId and VA.identifier=?2 and VA.hasEdited=0 and V.id=?1',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithMealIdList(
    List<int> mealIds,
    String identifier,
  ) async {
    const offset = 2;
    final _sqliteVariablesForMealIds =
        Iterable<String>.generate(mealIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where V.id = VA.mealId and VA.identifier=?1 and VA.hasEdited=0 and V.id in (' +
            _sqliteVariablesForMealIds +
            ')',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [identifier, ...mealIds]);
  }

  @override
  Future<List<VerseAudioEntity>> getVerseAudioWithCuzNo(
    int cuzNo,
    String identifier,
    int startVerseId,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where VA.mealId = V.id and V.cuzNo=?1 and VA.identifier=?2 and V.id >= ?3     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [cuzNo, identifier, startVerseId]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithCuzNo(
    int cuzNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where VA.mealId = V.id and V.cuzNo=?1 and VA.identifier=?2     order by mealId',
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
        'select VA.* from verseAudios VA, verses V      where VA.mealId = V.id and V.surahId=?1 and VA.identifier=?2 and V.id >= ?3     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [surahId, identifier, startVerseId]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithSurahId(
    int surahId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where VA.mealId = V.id and V.surahId=?1 and VA.identifier=?2     order by mealId',
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
        'select VA.* from verseAudios VA, verses V      where VA.mealId = V.id  and VA.identifier=?2 and V.pageNo=?1 and V.id >= ?3     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [pageNo, identifier, startVerseId]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithPageNo(
    int pageNo,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V      where VA.mealId = V.id and V.pageNo=?1 and VA.identifier=?2     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [pageNo, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithMealId(
    int mealId,
    String identifier,
  ) async {
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V     where VA.mealId = V.id and VA.mealId=?1 and VA.identifier=?2     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [mealId, identifier]);
  }

  @override
  Future<List<VerseAudioEntity>> getAllVerseAudioWithMealIdList(
    List<int> mealIds,
    String identifier,
  ) async {
    const offset = 2;
    final _sqliteVariablesForMealIds =
        Iterable<String>.generate(mealIds.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select VA.* from verseAudios VA, verses V     where VA.mealId = V.id and VA.mealId in (' +
            _sqliteVariablesForMealIds +
            ') and VA.identifier=?1     order by mealId',
        mapper: (Map<String, Object?> row) => VerseAudioEntity(mealId: row['mealId'] as int, identifier: row['identifier'] as String, fileName: row['fileName'] as String?, hasEdited: (row['hasEdited'] as int) != 0),
        arguments: [identifier, ...mealIds]);
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
  )   : _queryAdapter = QueryAdapter(database, changeListener),
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
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'counterId': item.counterId,
                  'parentPrayerId': item.parentPrayerId,
                  'updateCounter': item.updateCounter ? 1 : 0
                },
            changeListener),
        _prayerVerseEntityInsertionAdapter = InsertionAdapter(
            database,
            'PrayerVerses',
            (PrayerVerseEntity item) => <String, Object?>{
                  'id': item.id,
                  'verseId': item.verseId,
                  'prayerId': item.prayerId,
                  'orderItem': item.orderItem
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
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'counterId': item.counterId,
                  'parentPrayerId': item.parentPrayerId,
                  'updateCounter': item.updateCounter ? 1 : 0
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
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'counterId': item.counterId,
                  'parentPrayerId': item.parentPrayerId,
                  'updateCounter': item.updateCounter ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PrayerEntity> _prayerEntityInsertionAdapter;

  final InsertionAdapter<PrayerVerseEntity> _prayerVerseEntityInsertionAdapter;

  final UpdateAdapter<PrayerEntity> _prayerEntityUpdateAdapter;

  final DeletionAdapter<PrayerEntity> _prayerEntityDeletionAdapter;

  @override
  Future<List<PrayerVerseEntity>> getPrayerVerseByPrayerId(int prayerId) async {
    return _queryAdapter.queryList(
        'select * from prayerVerses where prayerId = ?1 order by orderItem asc',
        mapper: (Map<String, Object?> row) => PrayerVerseEntity(
            id: row['id'] as int?,
            verseId: row['verseId'] as int,
            prayerId: row['prayerId'] as int,
            orderItem: row['orderItem'] as int),
        arguments: [prayerId]);
  }

  @override
  Future<List<PrayerEntity>> getPrayersWithTypeId(int typeId) async {
    return _queryAdapter.queryList(
        'select * from prayers where typeId = ?1 order by orderItem desc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId]);
  }

  @override
  Stream<List<PrayerEntity>> getStreamPrayersWithTypeId(int typeId) {
    return _queryAdapter.queryListStream(
        'select * from prayers where typeId = ?1 order by orderItem desc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId],
        queryableName: 'prayers',
        isView: false);
  }

  @override
  Future<List<PrayerEntity>> getPrayersWithTypeIdOrderByAsc(int typeId) async {
    return _queryAdapter.queryList(
        'select * from prayers where typeId = ?1 order by orderItem asc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId]);
  }

  @override
  Stream<List<PrayerEntity>> getStreamPrayersWithTypeIdOrderByAsc(int typeId) {
    return _queryAdapter.queryListStream(
        'select * from prayers where typeId = ?1 order by orderItem asc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId],
        queryableName: 'prayers',
        isView: false);
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
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [id]);
  }

  @override
  Stream<PrayerEntity?> getStreamPrayersWithId(int id) {
    return _queryAdapter.queryStream('select * from prayers where id = ?1',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [id],
        queryableName: 'prayers',
        isView: false);
  }

  @override
  Future<int?> getMaxOrderWithTypeId(int typeId) async {
    return _queryAdapter.query(
        'select ifnull(max(orderItem),0) from prayers where typeId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [typeId]);
  }

  @override
  Stream<List<PrayerEntity>> getStreamPrayersSearchedLikeWithTypeId(
    int typeId,
    String query,
  ) {
    return _queryAdapter.queryListStream(
        'select * from prayers where typeId = ?1 and lower(meaningContent) Like lower(?2)     order by orderItem desc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId, query],
        queryableName: 'prayers',
        isView: false);
  }

  @override
  Stream<List<PrayerEntity>> getStreamPrayersSearchedRegExWithTypeId(
    int typeId,
    String regExp,
  ) {
    return _queryAdapter.queryListStream(
        'select * from prayers where typeId = ?1 and lower(meaningContent) REGEXP lower(?2)      order by orderItem desc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId, regExp],
        queryableName: 'prayers',
        isView: false);
  }

  @override
  Stream<List<PrayerEntity>> getPrayersSearchedWithTypeIdAndTitle(
    int typeId,
    String querySearchFull,
    String queryOrderForLike,
    String queryRaw,
  ) {
    return _queryAdapter.queryListStream(
        'select * from prayers where typeId = ?1 and      lower(meaningContent) Like lower(?2) or lower(name) Like lower(?2)     or lower(pronunciationContent) Like lower(?2)     order by (case when lower(name)=?4 then 1 when name like ?3 then 2 else 3 end),     (case when lower(pronunciationContent)=?4 then 1 when pronunciationContent like ?3 then 2 else 3 end),     orderItem desc',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId, querySearchFull, queryOrderForLike, queryRaw],
        queryableName: 'prayers',
        isView: false);
  }

  @override
  Future<int> insertPrayer(PrayerEntity prayer) {
    return _prayerEntityInsertionAdapter.insertAndReturnId(
        prayer, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPrayerVerses(
      List<PrayerVerseEntity> prayerVerseEntities) async {
    await _prayerVerseEntityInsertionAdapter.insertList(
        prayerVerseEntities, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePrayer(PrayerEntity prayer) async {
    await _prayerEntityUpdateAdapter.update(prayer, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePrayer(PrayerEntity prayer) async {
    await _prayerEntityDeletionAdapter.delete(prayer);
  }

  @override
  Future<int> insertPrayerWithOrder(PrayerEntity prayer) async {
    if (database is sqflite.Transaction) {
      return super.insertPrayerWithOrder(prayer);
    } else {
      return (database as sqflite.Database)
          .transaction<int>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.prayerDao.insertPrayerWithOrder(prayer);
      });
    }
  }

  @override
  Future<void> insertPrayerWithRelation(
    PrayerEntity childPrayer,
    PrayerEntity unAddedParentPrayer,
    List<int> prayerVerseIds,
  ) async {
    if (database is sqflite.Transaction) {
      await super.insertPrayerWithRelation(
          childPrayer, unAddedParentPrayer, prayerVerseIds);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.prayerDao.insertPrayerWithRelation(
            childPrayer, unAddedParentPrayer, prayerVerseIds);
      });
    }
  }
}

class _$EsmaulHusnaDao extends EsmaulHusnaDao {
  _$EsmaulHusnaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _esmaulHusnaEntityUpdateAdapter = UpdateAdapter(
            database,
            'EsmaulHusnas',
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
        'select * from esmaulHusnas order by orderItem',
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
  Future<EsmaulHusnaEntity?> getEsmaulHusnaByOrderItem(int orderItem) async {
    return _queryAdapter.query(
        'select * from esmaulHusnas where orderItem = ?1',
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
        arguments: [orderItem]);
  }

  @override
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnas() {
    return _queryAdapter.queryListStream(
        'select * from esmaulHusnas order by orderItem',
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
        queryableName: 'esmaulHusnas',
        isView: false);
  }

  @override
  Future<EsmaulHusnaEntity?> getEsmaulHusnaWithId(int id) async {
    return _queryAdapter.query(
        'select * from esmaulHusnas where id=?1 order by orderItem',
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
        'select * from esmaulHusnas where      lower(name) Like lower(?1) or      lower(searchName) Like lower(?1) or      lower(meaning) Like lower(?1) or     lower(virtue) Like lower(?1)     order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(id: row['id'] as int?, orderItem: row['orderItem'] as int, name: row['name'] as String, arabicName: row['arabicName'] as String, meaning: row['meaning'] as String, dhikr: row['dhikr'] as String, virtue: row['virtue'] as String, counterId: row['counterId'] as int?, searchName: row['searchName'] as String),
        arguments: [query]);
  }

  @override
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnasSearchedLike(
      String query) {
    return _queryAdapter.queryListStream(
        'select * from esmaulHusnas where      lower(name) Like lower(?1) or      lower(searchName) Like lower(?1) or      lower(meaning) Like lower(?1) or     lower(virtue) Like lower(?1)     order by orderItem',
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
        arguments: [query],
        queryableName: 'esmaulHusnas',
        isView: false);
  }

  @override
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnasSearchedRegEx(
      String regExp) async {
    return _queryAdapter.queryList(
        'select * from esmaulHusnas where       lower(name) REGEXP lower(?1) or      lower(searchName) REGEXP lower(?1) or      lower(meaning) REGEXP lower(?1) or      lower(virtue) REGEXP lower(?1)      order by orderItem',
        mapper: (Map<String, Object?> row) => EsmaulHusnaEntity(id: row['id'] as int?, orderItem: row['orderItem'] as int, name: row['name'] as String, arabicName: row['arabicName'] as String, meaning: row['meaning'] as String, dhikr: row['dhikr'] as String, virtue: row['virtue'] as String, counterId: row['counterId'] as int?, searchName: row['searchName'] as String),
        arguments: [regExp]);
  }

  @override
  Stream<List<EsmaulHusnaEntity>> getStreamEsmaulHusnasSearchedRegEx(
      String regExp) {
    return _queryAdapter.queryListStream(
        'select * from esmaulHusnas where       lower(name) REGEXP lower(?1) or      lower(searchName) REGEXP lower(?1) or      lower(meaning) REGEXP lower(?1) or      lower(virtue) REGEXP lower(?1)      order by orderItem',
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
        arguments: [regExp],
        queryableName: 'esmaulHusnas',
        isView: false);
  }

  @override
  Future<void> updateEsmaulHusna(EsmaulHusnaEntity esmaulHusna) async {
    await _esmaulHusnaEntityUpdateAdapter.update(
        esmaulHusna, OnConflictStrategy.replace);
  }
}

class _$CounterDao extends CounterDao {
  _$CounterDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _counterEntityInsertionAdapter = InsertionAdapter(
            database,
            'Counters',
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'description': item.description,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'typeId': item.typeId,
                  'prayerId': item.prayerId
                },
            changeListener),
        _counterEntityUpdateAdapter = UpdateAdapter(
            database,
            'Counters',
            ['id'],
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'description': item.description,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'typeId': item.typeId,
                  'prayerId': item.prayerId
                },
            changeListener),
        _counterEntityDeletionAdapter = DeletionAdapter(
            database,
            'Counters',
            ['id'],
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'description': item.description,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'typeId': item.typeId,
                  'prayerId': item.prayerId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CounterEntity> _counterEntityInsertionAdapter;

  final UpdateAdapter<CounterEntity> _counterEntityUpdateAdapter;

  final DeletionAdapter<CounterEntity> _counterEntityDeletionAdapter;

  @override
  Stream<List<CounterEntity>> getStreamCounters() {
    return _queryAdapter.queryListStream(
        'select * from counters order by orderItem desc',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            typeId: row['typeId'] as int,
            lastCounter: row['lastCounter'] as int,
            orderItem: row['orderItem'] as int,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            description: row['description'] as String?,
            goal: row['goal'] as int?,
            meaning: row['meaning'] as String?,
            prayerId: row['prayerId'] as int?),
        queryableName: 'counters',
        isView: false);
  }

  @override
  Future<List<CounterEntity>> getCounters() async {
    return _queryAdapter.queryList(
        'select * from counters order by orderItem desc',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            typeId: row['typeId'] as int,
            lastCounter: row['lastCounter'] as int,
            orderItem: row['orderItem'] as int,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            description: row['description'] as String?,
            goal: row['goal'] as int?,
            meaning: row['meaning'] as String?,
            prayerId: row['prayerId'] as int?));
  }

  @override
  Future<CounterEntity?> getCounterById(int id) async {
    return _queryAdapter.query('select * from counters where id=?1',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            typeId: row['typeId'] as int,
            lastCounter: row['lastCounter'] as int,
            orderItem: row['orderItem'] as int,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            description: row['description'] as String?,
            goal: row['goal'] as int?,
            meaning: row['meaning'] as String?,
            prayerId: row['prayerId'] as int?),
        arguments: [id]);
  }

  @override
  Stream<CounterEntity?> getStreamCounterById(int id) {
    return _queryAdapter.queryStream('select * from counters where id=?1',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            typeId: row['typeId'] as int,
            lastCounter: row['lastCounter'] as int,
            orderItem: row['orderItem'] as int,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            description: row['description'] as String?,
            goal: row['goal'] as int?,
            meaning: row['meaning'] as String?,
            prayerId: row['prayerId'] as int?),
        arguments: [id],
        queryableName: 'counters',
        isView: false);
  }

  @override
  Future<int?> getMaxOrder() async {
    return _queryAdapter.query('select ifnull(max(orderItem),0) from counters',
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
        'select * from islamicInfoTitles where type=?1',
        mapper: (Map<String, Object?> row) => IslamicInfoTitleEntity(
            id: row['id'] as int?,
            description: row['description'] as String?,
            title: row['title'] as String,
            type: row['type'] as int),
        arguments: [type]);
  }

  @override
  Future<List<IslamicInfoItemEntity>> getIslamicInfoItemsByTitleId(
      int titleId) async {
    return _queryAdapter.queryList(
        'select * from islamicInfoItems where titleId=?1',
        mapper: (Map<String, Object?> row) => IslamicInfoItemEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            titleId: row['titleId'] as int),
        arguments: [titleId]);
  }
}

class _$UserInfoDao extends UserInfoDao {
  _$UserInfoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInfoEntityInsertionAdapter = InsertionAdapter(
            database,
            'UserInfos',
            (UserInfoEntity item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'img': item.img
                },
            changeListener),
        _userInfoEntityDeletionAdapter = DeletionAdapter(
            database,
            'UserInfos',
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

  final DeletionAdapter<UserInfoEntity> _userInfoEntityDeletionAdapter;

  @override
  Stream<UserInfoEntity?> getStreamUserInfoWithId(String userId) {
    return _queryAdapter.queryStream(
        'select * from userInfos where userId=?1 limit 1',
        mapper: (Map<String, Object?> row) => UserInfoEntity(
            id: row['id'] as int?,
            userId: row['userId'] as String,
            img: row['img'] as Uint8List?),
        arguments: [userId],
        queryableName: 'userInfos',
        isView: false);
  }

  @override
  Future<UserInfoEntity?> getUserInfoWithId(String userId) async {
    return _queryAdapter.query(
        'select * from userInfos where userId=?1 limit 1',
        mapper: (Map<String, Object?> row) => UserInfoEntity(
            id: row['id'] as int?,
            userId: row['userId'] as String,
            img: row['img'] as Uint8List?),
        arguments: [userId]);
  }

  @override
  Future<void> insertUserInfo(UserInfoEntity userInfo) async {
    await _userInfoEntityInsertionAdapter.insert(
        userInfo, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteUserInfo(UserInfoEntity userInfo) {
    return _userInfoEntityDeletionAdapter.deleteAndReturnChangedRows(userInfo);
  }
}

class _$BackupMetaDao extends BackupMetaDao {
  _$BackupMetaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _backupMetaEntityInsertionAdapter = InsertionAdapter(
            database,
            'BackupMetas',
            (BackupMetaEntity item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'updatedDate': item.updatedDate,
                  'isAuto': item.isAuto ? 1 : 0
                },
            changeListener),
        _backupMetaEntityUpdateAdapter = UpdateAdapter(
            database,
            'BackupMetas',
            ['id'],
            (BackupMetaEntity item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'updatedDate': item.updatedDate,
                  'isAuto': item.isAuto ? 1 : 0
                },
            changeListener),
        _backupMetaEntityDeletionAdapter = DeletionAdapter(
            database,
            'BackupMetas',
            ['id'],
            (BackupMetaEntity item) => <String, Object?>{
                  'id': item.id,
                  'fileName': item.fileName,
                  'updatedDate': item.updatedDate,
                  'isAuto': item.isAuto ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BackupMetaEntity> _backupMetaEntityInsertionAdapter;

  final UpdateAdapter<BackupMetaEntity> _backupMetaEntityUpdateAdapter;

  final DeletionAdapter<BackupMetaEntity> _backupMetaEntityDeletionAdapter;

  @override
  Future<List<BackupMetaEntity>> getBackupMetaWithAutoAndOffset(
    bool isAuto,
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'select * from backupMetas where isAuto = ?1 order by updatedDate desc limit ?2 offset ?3',
        mapper: (Map<String, Object?> row) => BackupMetaEntity(id: row['id'] as int?, fileName: row['fileName'] as String, updatedDate: row['updatedDate'] as String, isAuto: (row['isAuto'] as int) != 0),
        arguments: [isAuto ? 1 : 0, limit, offset]);
  }

  @override
  Stream<List<BackupMetaEntity>> getStreamBackupMetas() {
    return _queryAdapter.queryListStream(
        'select * from backupMetas order by updatedDate desc',
        mapper: (Map<String, Object?> row) => BackupMetaEntity(
            id: row['id'] as int?,
            fileName: row['fileName'] as String,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0),
        queryableName: 'backupMetas',
        isView: false);
  }

  @override
  Future<List<BackupMetaEntity>> getBackupMetas() async {
    return _queryAdapter.queryList(
        'select * from backupMetas order by updatedDate desc',
        mapper: (Map<String, Object?> row) => BackupMetaEntity(
            id: row['id'] as int?,
            fileName: row['fileName'] as String,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0));
  }

  @override
  Future<BackupMetaEntity?> getLastBackupMeta() async {
    return _queryAdapter.query(
        'select * from backupMetas order by updatedDate desc limit 1',
        mapper: (Map<String, Object?> row) => BackupMetaEntity(
            id: row['id'] as int?,
            fileName: row['fileName'] as String,
            updatedDate: row['updatedDate'] as String,
            isAuto: (row['isAuto'] as int) != 0));
  }

  @override
  Future<BackupMetaEntity?> getFirstBackupMeta(bool isAuto) async {
    return _queryAdapter.query(
        'select * from backupMetas where isAuto = ?1 order by updatedDate limit 1',
        mapper: (Map<String, Object?> row) => BackupMetaEntity(id: row['id'] as int?, fileName: row['fileName'] as String, updatedDate: row['updatedDate'] as String, isAuto: (row['isAuto'] as int) != 0),
        arguments: [isAuto ? 1 : 0]);
  }

  @override
  Future<int?> getBackupMetaSizeWithAuto(bool isAuto) async {
    return _queryAdapter.query(
        'select count(*) data from backupMetas where isAuto = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [isAuto ? 1 : 0]);
  }

  @override
  Future<void> insertBackupMetas(List<BackupMetaEntity> backupMetas) async {
    await _backupMetaEntityInsertionAdapter.insertList(
        backupMetas, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertBackupMeta(BackupMetaEntity backupMeta) async {
    await _backupMetaEntityInsertionAdapter.insert(
        backupMeta, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBackupMeta(BackupMetaEntity backupMeta) async {
    await _backupMetaEntityUpdateAdapter.update(
        backupMeta, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteBackupMetas(List<BackupMetaEntity> backupMetas) async {
    await _backupMetaEntityDeletionAdapter.deleteList(backupMetas);
  }
}

class _$BackupDao extends BackupDao {
  _$BackupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _historyEntityInsertionAdapter = InsertionAdapter(
            database,
            'Histories',
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'originType': item.originType,
                  'modifiedDate': item.modifiedDate
                },
            changeListener),
        _listEntityInsertionAdapter = InsertionAdapter(
            database,
            'Lists',
            (ListEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'sourceId': item.sourceId,
                  'isArchive': item.isArchive ? 1 : 0,
                  'pos': item.pos
                },
            changeListener),
        _listHadithEntityInsertionAdapter = InsertionAdapter(
            database,
            'ListHadiths',
            (ListHadithEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'hadithId': item.hadithId,
                  'pos': item.pos
                },
            changeListener),
        _listVerseEntityInsertionAdapter = InsertionAdapter(
            database,
            'ListVerses',
            (ListVerseEntity item) => <String, Object?>{
                  'listId': item.listId,
                  'verseId': item.verseId,
                  'pos': item.pos
                },
            changeListener),
        _savePointEntityInsertionAdapter = InsertionAdapter(
            database,
            'SavePoints',
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
        _topicSavePointEntityInsertionAdapter = InsertionAdapter(
            database,
            'TopicSavePoints',
            (TopicSavePointEntity item) => <String, Object?>{
                  'id': item.id,
                  'pos': item.pos,
                  'type': item.type,
                  'parentKey': item.parentKey
                },
            changeListener),
        _counterEntityInsertionAdapter = InsertionAdapter(
            database,
            'Counters',
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'description': item.description,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'typeId': item.typeId,
                  'prayerId': item.prayerId
                },
            changeListener),
        _prayerVerseEntityInsertionAdapter = InsertionAdapter(
            database,
            'PrayerVerses',
            (PrayerVerseEntity item) => <String, Object?>{
                  'id': item.id,
                  'verseId': item.verseId,
                  'prayerId': item.prayerId,
                  'orderItem': item.orderItem
                },
            changeListener),
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
                  'isRemovable': item.isRemovable ? 1 : 0,
                  'counterId': item.counterId,
                  'parentPrayerId': item.parentPrayerId,
                  'updateCounter': item.updateCounter ? 1 : 0
                },
            changeListener),
        _counterEntityDeletionAdapter = DeletionAdapter(
            database,
            'Counters',
            ['id'],
            (CounterEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'content': item.content,
                  'arabicContent': item.arabicContent,
                  'meaning': item.meaning,
                  'description': item.description,
                  'orderItem': item.orderItem,
                  'lastCounter': item.lastCounter,
                  'goal': item.goal,
                  'typeId': item.typeId,
                  'prayerId': item.prayerId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HistoryEntity> _historyEntityInsertionAdapter;

  final InsertionAdapter<ListEntity> _listEntityInsertionAdapter;

  final InsertionAdapter<ListHadithEntity> _listHadithEntityInsertionAdapter;

  final InsertionAdapter<ListVerseEntity> _listVerseEntityInsertionAdapter;

  final InsertionAdapter<SavePointEntity> _savePointEntityInsertionAdapter;

  final InsertionAdapter<TopicSavePointEntity>
      _topicSavePointEntityInsertionAdapter;

  final InsertionAdapter<CounterEntity> _counterEntityInsertionAdapter;

  final InsertionAdapter<PrayerVerseEntity> _prayerVerseEntityInsertionAdapter;

  final InsertionAdapter<PrayerEntity> _prayerEntityInsertionAdapter;

  final DeletionAdapter<CounterEntity> _counterEntityDeletionAdapter;

  @override
  Future<List<HistoryEntity>> getHistories() async {
    return _queryAdapter.queryList('select * from histories',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            originType: row['originType'] as int,
            modifiedDate: row['modifiedDate'] as String));
  }

  @override
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnas() async {
    return _queryAdapter.queryList(
        'select * from esmaulHusnas where counterId is not null',
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
  Future<List<ListEntity>> getLists() async {
    return _queryAdapter.queryList('select * from lists',
        mapper: (Map<String, Object?> row) => ListEntity(
            id: row['id'] as int?,
            isArchive: (row['isArchive'] as int) != 0,
            name: row['name'] as String,
            isRemovable: (row['isRemovable'] as int) != 0,
            sourceId: row['sourceId'] as int,
            pos: row['pos'] as int));
  }

  @override
  Future<List<ListHadithEntity>> getHadithListEntities() async {
    return _queryAdapter.queryList('select * from listHadiths',
        mapper: (Map<String, Object?> row) => ListHadithEntity(
            listId: row['listId'] as int,
            hadithId: row['hadithId'] as int,
            pos: row['pos'] as int));
  }

  @override
  Future<List<ListVerseEntity>> getVerseListEntities() async {
    return _queryAdapter.queryList('select * from listVerses',
        mapper: (Map<String, Object?> row) => ListVerseEntity(
            listId: row['listId'] as int,
            verseId: row['verseId'] as int,
            pos: row['pos'] as int));
  }

  @override
  Future<List<SavePointEntity>> getSavePoints() async {
    return _queryAdapter.queryList('select * from savePoints',
        mapper: (Map<String, Object?> row) => SavePointEntity(
            id: row['id'] as int?,
            itemIndexPos: row['itemIndexPos'] as int,
            title: row['title'] as String,
            autoType: row['autoType'] as int,
            modifiedDate: row['modifiedDate'] as String,
            savePointType: row['savePointType'] as int,
            bookScope: row['bookScope'] as int,
            parentKey: row['parentKey'] as String,
            parentName: row['parentName'] as String));
  }

  @override
  Future<List<TopicSavePointEntity>> getTopicSavePoints() async {
    return _queryAdapter.queryList('select * from topicSavePoints',
        mapper: (Map<String, Object?> row) => TopicSavePointEntity(
            id: row['id'] as int?,
            pos: row['pos'] as int,
            type: row['type'] as int,
            parentKey: row['parentKey'] as String));
  }

  @override
  Future<List<CounterEntity>> getCounterEntities() async {
    return _queryAdapter.queryList('select * from counters',
        mapper: (Map<String, Object?> row) => CounterEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            typeId: row['typeId'] as int,
            lastCounter: row['lastCounter'] as int,
            orderItem: row['orderItem'] as int,
            content: row['content'] as String?,
            arabicContent: row['arabicContent'] as String?,
            description: row['description'] as String?,
            goal: row['goal'] as int?,
            meaning: row['meaning'] as String?,
            prayerId: row['prayerId'] as int?));
  }

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
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?),
        arguments: [typeId]);
  }

  @override
  Future<List<PrayerEntity>> getPrayersNonRemovable() async {
    return _queryAdapter.queryList(
        'select * from prayers where isRemovable = 0',
        mapper: (Map<String, Object?> row) => PrayerEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            arabicContent: row['arabicContent'] as String?,
            meaningContent: row['meaningContent'] as String?,
            pronunciationContent: row['pronunciationContent'] as String?,
            source: row['source'] as String?,
            typeId: row['typeId'] as int,
            orderItem: row['orderItem'] as int,
            isRemovable: (row['isRemovable'] as int) != 0,
            counterId: row['counterId'] as int?,
            updateCounter: (row['updateCounter'] as int) != 0,
            parentPrayerId: row['parentPrayerId'] as int?));
  }

  @override
  Future<List<PrayerVerseEntity>> getPrayerVersesByPrayerId(
      int prayerId) async {
    return _queryAdapter.queryList(
        'select * from prayerVerses where prayerId = ?1',
        mapper: (Map<String, Object?> row) => PrayerVerseEntity(
            id: row['id'] as int?,
            verseId: row['verseId'] as int,
            prayerId: row['prayerId'] as int,
            orderItem: row['orderItem'] as int),
        arguments: [prayerId]);
  }

  @override
  Future<void> updateEsmaulHusnaCounterId(
    int orderItem,
    int counterId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update esmaulHusnas set counterId = ?2 where orderItem = ?1',
        arguments: [orderItem, counterId]);
  }

  @override
  Future<void> updateNonRemovablePrayers(
    int orderItem,
    int typeId,
    int parentPrayerId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update prayers set parentPrayerId = ?3 where orderItem = ?1 and typeId = ?2',
        arguments: [orderItem, typeId, parentPrayerId]);
  }

  @override
  Future<void> updatePrayerCounterId(
    int counterId,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update prayers set counterId = ?1 where id = ?2',
        arguments: [counterId, id]);
  }

  @override
  Future<void> deleteHistories() async {
    await _queryAdapter.queryNoReturn('delete from histories');
  }

  @override
  Future<void> deleteLists() async {
    await _queryAdapter.queryNoReturn('delete from lists where isRemovable=1');
  }

  @override
  Future<void> deleteHadithLists() async {
    await _queryAdapter.queryNoReturn('delete from listHadiths');
  }

  @override
  Future<void> deleteVerseLists() async {
    await _queryAdapter.queryNoReturn('delete from listVerses');
  }

  @override
  Future<void> deleteSavePoints() async {
    await _queryAdapter.queryNoReturn('delete from savePoints');
  }

  @override
  Future<void> deleteTopicSavePoints() async {
    await _queryAdapter.queryNoReturn('delete from topicSavePoints');
  }

  @override
  Future<void> deleteCounterEntitiesWithQuery() async {
    await _queryAdapter.queryNoReturn('delete from counters');
  }

  @override
  Future<void> deletePrayersWithTypeId(int typeId) async {
    await _queryAdapter.queryNoReturn('delete from prayers where typeId = ?1',
        arguments: [typeId]);
  }

  @override
  Future<void> insertHistories(List<HistoryEntity> histories) async {
    await _historyEntityInsertionAdapter.insertList(
        histories, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertLists(List<ListEntity> lists) async {
    await _listEntityInsertionAdapter.insertList(
        lists, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHadithLists(List<ListHadithEntity> hadithLists) async {
    await _listHadithEntityInsertionAdapter.insertList(
        hadithLists, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertVerseLists(List<ListVerseEntity> verseLists) async {
    await _listVerseEntityInsertionAdapter.insertList(
        verseLists, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSavePoints(List<SavePointEntity> savePointEntities) async {
    await _savePointEntityInsertionAdapter.insertList(
        savePointEntities, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTopicSavePoints(
      List<TopicSavePointEntity> topicSavePoints) async {
    await _topicSavePointEntityInsertionAdapter.insertList(
        topicSavePoints, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertCounterEntities(
      List<CounterEntity> counterEntities) async {
    await _counterEntityInsertionAdapter.insertList(
        counterEntities, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPrayerVerseEntities(
      List<PrayerVerseEntity> prayerVerseEntities) async {
    await _prayerVerseEntityInsertionAdapter.insertList(
        prayerVerseEntities, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHistory(HistoryEntity history) async {
    await _historyEntityInsertionAdapter.insert(
        history, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertList(ListEntity list) async {
    await _listEntityInsertionAdapter.insert(list, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertHadithList(ListHadithEntity hadithList) async {
    await _listHadithEntityInsertionAdapter.insert(
        hadithList, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertVerseList(ListVerseEntity verseList) async {
    await _listVerseEntityInsertionAdapter.insert(
        verseList, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSavePoint(SavePointEntity savePoint) async {
    await _savePointEntityInsertionAdapter.insert(
        savePoint, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTopicSavePoint(
      TopicSavePointEntity topicSavePointEntity) async {
    await _topicSavePointEntityInsertionAdapter.insert(
        topicSavePointEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertCounterEntity(CounterEntity counterEntity) {
    return _counterEntityInsertionAdapter.insertAndReturnId(
        counterEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> insertPrayerEntity(PrayerEntity prayer) {
    return _prayerEntityInsertionAdapter.insertAndReturnId(
        prayer, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteCounterEntities(List<CounterEntity> entities) async {
    await _counterEntityDeletionAdapter.deleteList(entities);
  }

  @override
  Future<List<PrayerBackupDto>> getPrayersBackupDto() async {
    if (database is sqflite.Transaction) {
      return super.getPrayersBackupDto();
    } else {
      return (database as sqflite.Database)
          .transaction<List<PrayerBackupDto>>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.backupDao.getPrayersBackupDto();
      });
    }
  }

  @override
  Future<void> deletePrayers() async {
    if (database is sqflite.Transaction) {
      await super.deletePrayers();
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.backupDao.deletePrayers();
      });
    }
  }
}

class _$SelectVersePageDao extends SelectVersePageDao {
  _$SelectVersePageDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<SurahEntity>> getSurahes() async {
    return _queryAdapter.queryList('select * from surahs',
        mapper: (Map<String, Object?> row) => SurahEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            searchName: row['searchName'] as String));
  }

  @override
  Future<List<CuzEntity>> getCuzs() async {
    return _queryAdapter.queryList('select * from cuzs',
        mapper: (Map<String, Object?> row) =>
            CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String));
  }

  @override
  Future<List<String>> getVerseNumbers(int surahId) async {
    return _queryAdapter.queryList(
        'select verseNumber from verses where surahId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [surahId]);
  }

  @override
  Future<int?> getMaxPage() async {
    return _queryAdapter.query('select ifnull(max(pageNo),0) from verses',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getVerseId(
    int surahId,
    int cuzNo,
    String verseNumber,
  ) async {
    return _queryAdapter.query(
        'select id from verses      where surahId = ?1 and cuzNo = ?2 and verseNumber = ?3',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [surahId, cuzNo, verseNumber]);
  }

  @override
  Future<int?> getPagePosition(
    int id,
    int pageNo,
    int surahId,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verses s     where pageNo = ?2 and surahId = ?3 and cuzNo = ?4 and id <= ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id, pageNo, surahId, cuzNo]);
  }

  @override
  Future<bool?> existsSurahByCuzNo(
    int surahId,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from surahs S, verses V      where V.surahId = S.id and V.cuzNo = ?2 and S.id = ?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [surahId, cuzNo]);
  }

  @override
  Future<bool?> existsCuzBySurah(
    int cuzNo,
    int surahId,
    String verseNumber,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from surahs S, verses V      where V.surahId = S.id and V.cuzNo = ?1 and S.id = ?2 and verseNumber = ?3)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [cuzNo, surahId, verseNumber]);
  }

  @override
  Future<bool?> existsPageByCuzNo(
    int pageNo,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from verses     where cuzNo = ?2 and pageNo = ?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, cuzNo]);
  }

  @override
  Future<bool?> existsPageBySurahId(
    int pageNo,
    int surahId,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from verses     where surahId = ?2 and pageNo = ?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, surahId]);
  }

  @override
  Future<bool?> existsPageBySurah(
    int pageNo,
    int surahId,
    String verseNumber,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from verses     where surahId = ?2 and pageNo = ?1 and verseNumber = ?3)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [pageNo, surahId, verseNumber]);
  }

  @override
  Future<bool?> existsVerseNumber(
    String verseNumber,
    int surahId,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from verses     where surahId = ?2 and cuzNo = ?3 and verseNumber = ?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [verseNumber, surahId, cuzNo]);
  }

  @override
  Future<bool?> existsVerseNumberWithPageNo(
    String verseNumber,
    int surahId,
    int cuzNo,
    int pageNo,
  ) async {
    return _queryAdapter.query(
        'select exists(     select 1 from verses     where surahId = ?2 and cuzNo = ?3 and verseNumber = ?1 and pageNo = ?4)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [verseNumber, surahId, cuzNo, pageNo]);
  }

  @override
  Future<SurahEntity?> getFirstSurahByCuzNo(int cuzNo) async {
    return _queryAdapter.query(
        'select S.* from surahs S, verses V      where V.surahId = S.id and V.cuzNo = ?1 limit 1',
        mapper: (Map<String, Object?> row) => SurahEntity(id: row['id'] as int, name: row['name'] as String, searchName: row['searchName'] as String),
        arguments: [cuzNo]);
  }

  @override
  Future<SurahEntity?> getFirstSurahByPageNo(int pageNo) async {
    return _queryAdapter.query(
        'select S.* from surahs S, verses V      where V.surahId = S.id and V.pageNo = ?1 limit 1',
        mapper: (Map<String, Object?> row) => SurahEntity(id: row['id'] as int, name: row['name'] as String, searchName: row['searchName'] as String),
        arguments: [pageNo]);
  }

  @override
  Future<CuzEntity?> getFirstCuzBySurah(
    int surahId,
    String verseNumber,
  ) async {
    return _queryAdapter.query(
        'select C.* from cuzs C, verses V      where V.cuzNo = C.cuzNo and V.surahId = ?1 and V.verseNumber = ?2 limit 1',
        mapper: (Map<String, Object?> row) => CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String),
        arguments: [surahId, verseNumber]);
  }

  @override
  Future<CuzEntity?> getFirstCuzBySurahId(int surahId) async {
    return _queryAdapter.query(
        'select C.* from cuzs C, verses V      where V.cuzNo = C.cuzNo and V.surahId = ?1 limit 1',
        mapper: (Map<String, Object?> row) => CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String),
        arguments: [surahId]);
  }

  @override
  Future<CuzEntity?> getFirstCuzByPageNo(int pageNo) async {
    return _queryAdapter.query(
        'select C.* from cuzs C, verses V      where V.cuzNo = C.cuzNo and V.pageNo = ?1 limit 1',
        mapper: (Map<String, Object?> row) => CuzEntity(cuzNo: row['cuzNo'] as int, name: row['name'] as String),
        arguments: [pageNo]);
  }

  @override
  Future<int?> getFirstPageByCuzNo(int cuzNo) async {
    return _queryAdapter.query(
        'select pageNo from verses V      where V.cuzNo = ?1 limit 1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cuzNo]);
  }

  @override
  Future<int?> getFirstPageBySurah(
    int surahId,
    String verseNumber,
  ) async {
    return _queryAdapter.query(
        'select pageNo from verses V      where V.surahId = ?1 and verseNumber = ?2 limit 1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [surahId, verseNumber]);
  }

  @override
  Future<String?> getFirstVerseNumber(
    int surahId,
    int cuzNo,
  ) async {
    return _queryAdapter.query(
        'select verseNumber from verses     where surahId = ?1 and cuzNo = ?2 limit 1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [surahId, cuzNo]);
  }

  @override
  Future<String?> getFirstVerseNumberWithPageNo(
    int surahId,
    int cuzNo,
    int pageNo,
  ) async {
    return _queryAdapter.query(
        'select verseNumber from verses     where surahId = ?1 and cuzNo = ?2 and pageNo = ?3 limit 1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [surahId, cuzNo, pageNo]);
  }
}

class _$ItemPositionDao extends ItemPositionDao {
  _$ItemPositionDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<int?> getSurahPos(
    int surahId,
    int mealId,
  ) async {
    return _queryAdapter.query(
        'select count(*) from verses where surahId = ?1 and id < ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [surahId, mealId]);
  }
}
