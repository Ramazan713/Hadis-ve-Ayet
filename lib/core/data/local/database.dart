
import 'dart:async';
import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/audio_edition_entity.dart';
import 'package:hadith/core/data/local/entities/backup_meta.dart';
import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/cuz_entity.dart';
import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';
import 'package:hadith/core/data/local/entities/hadith_entity.dart';
import 'package:hadith/core/data/local/entities/history_entity.dart';
import 'package:hadith/core/data/local/entities/islamic_info/islamic_info_item_entity.dart';
import 'package:hadith/core/data/local/entities/islamic_info/islamic_info_title_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_verse_entity.dart';
import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/data/local/entities/savepoint_type_entity.dart';
import 'package:hadith/core/data/local/entities/surah_entity.dart';
import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';
import 'package:hadith/core/data/local/entities/user_info_entity.dart';
import 'package:hadith/core/data/local/entities/verse_arabic_entity.dart';
import 'package:hadith/core/data/local/entities/verse_audio_entity.dart';
import 'package:hadith/core/data/local/views/cuz_audio_view.dart';
import 'package:hadith/core/data/local/views/hadith_info_list_view.dart';
import 'package:hadith/core/data/local/views/list_hadith_view.dart';
import 'package:hadith/core/data/local/views/list_verse_view.dart';
import 'package:hadith/core/data/local/views/section_topics_view.dart';
import 'package:hadith/core/data/local/views/surah_audio_view.dart';
import 'package:hadith/core/data/local/views/topic_hadiths_view.dart';
import 'package:hadith/core/data/local/views/topic_verses_view.dart';
import 'package:hadith/core/data/local/views/verse_info_list_view.dart';
import 'package:hadith/core/data/local/services/audio_edition_dao.dart';
import 'package:hadith/core/data/local/services/audio_view_dao.dart';
import 'package:hadith/core/data/local/services/backup_dao.dart';
import 'package:hadith/core/data/local/services/backup_meta_dao.dart';
import 'package:hadith/core/data/local/services/counter_dao.dart';
import 'package:hadith/core/data/local/services/cuz_dao.dart';
import 'package:hadith/core/data/local/services/esmaul_husna_dao.dart';
import 'package:hadith/core/data/local/services/history_dao.dart';
import 'package:hadith/core/data/local/services/islamic_info_dao.dart';
import 'package:hadith/core/data/local/services/item_pos_dao.dart';
import 'package:hadith/core/data/local/services/list/list_dao.dart';
import 'package:hadith/core/data/local/services/list/list_hadith_dao.dart';
import 'package:hadith/core/data/local/services/list/list_hadith_view_dao.dart';
import 'package:hadith/core/data/local/services/list/list_verse_dao.dart';
import 'package:hadith/core/data/local/services/list/list_verse_view_dao.dart';
import 'package:hadith/core/data/local/services/prayer_dao.dart';
import 'package:hadith/core/data/local/services/save_point_dao.dart';
import 'package:hadith/core/data/local/services/search_dao.dart';
import 'package:hadith/core/data/local/services/select_verse_page_dao.dart';
import 'package:hadith/core/data/local/services/surah_dao.dart';
import 'package:hadith/core/data/local/services/title_dao.dart';
import 'package:hadith/core/data/local/services/topic/section_view_dao.dart';
import 'package:hadith/core/data/local/services/topic/topic_hadiths_view_dao.dart';
import 'package:hadith/core/data/local/services/topic/topic_verses_view_dao.dart';
import 'package:hadith/core/data/local/services/topic_save_point_dao.dart';
import 'package:hadith/core/data/local/services/user_info_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_arabic_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_audio_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_dao.dart';
import 'package:hadith/core/data/local/services/hadith_all_dao.dart';
import 'package:hadith/core/data/remote/backup_dtos/counter_backup_dto/counter_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/esmaul_husna_info_dto/esmaul_husna_info_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_non_removable_dto.dart';
import 'entities/verse_entity.dart';
import 'services/hadith_info_list_dao.dart';
import 'services/topic_dao.dart';
import 'services/verse/verse_info_list_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';

@Database(
    version: 6,
    entities: [
      HadithEntity,ListHadithEntity, ListVerseEntity, ListEntity,
      PrayerEntity, EsmaulHusnaEntity, CounterEntity, SavePointTypeEntity,
      VerseEntity, HistoryEntity, AudioEditionEntity, VerseAudioEntity,
      IslamicInfoTitleEntity, IslamicInfoItemEntity, UserInfoEntity,
      BackupMetaEntity, PrayerVerseEntity, TopicSavePointEntity,
      CuzEntity, SurahEntity, VerseArabicEntity, SavePointEntity
    ],
    views: [
      ListVerseView,ListHadithView,CuzAudioView,SurahAudioView, SectionTopicsView,
      TopicHadithsView, TopicVersesView, VerseInfoListView,HadithInfoListView
    ])
abstract class AppDatabase extends FloorDatabase{
  HadithAllDao get hadithAllDao;
  ListDao get listDao;
  ListHadithDao get listHadithDao;
  ListHadithViewDao get listHadithViewDao;
  ListVerseDao get listVerseDao;
  ListVerseViewDao get listVerseViewDao;
  SavePointDao get savePointDao;
  HadithInfoListDao get hadithInfoListDao;
  VerseInfoListDao get verseInfoListDao;
  TopicDao get topicDao;
  TopicHadithViewDao get topicHadithsViewDao;
  TopicVersesViewDao get topicVersesViewDao;
  SectionViewDao get sectionViewDao;
  TopicSavePointDao get topicSavePointDao;
  CuzDao get cuzDao;
  SurahDao get surahDao;
  VerseArabicDao get verseArabicDao;
  VerseDao get verseDao;
  TitleDao get titleDao;
  SearchDao get searchDao;
  HistoryDao get historyDao;
  AudioEditionDao get editionDao;
  VerseAudioDao get verseAudioDao;
  AudioViewDao get audioViewDao;
  PrayerDao get prayerDao;
  EsmaulHusnaDao get esmaulHusnaDao;
  CounterDao get counterDao;
  IslamicInfoDao get islamicInfoDao;
  UserInfoDao get userInfoDao;
  BackupMetaDao get backupMetaDao;
  BackupDao get backupDao;
  SelectVersePageDao get selectVersePageDao;
  ItemPositionDao get itemPositionDao;
}
