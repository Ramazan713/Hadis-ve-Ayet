
import 'dart:async';
import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/cuz_entity.dart';
import 'package:hadith/core/data/local/entities/hadith_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';
import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/data/local/entities/savepoint_type_entity.dart';
import 'package:hadith/core/data/local/entities/surah_entity.dart';
import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';
import 'package:hadith/core/data/local/entities/views/list_hadith_view.dart';
import 'package:hadith/core/data/local/entities/views/list_verse_view.dart';
import 'package:hadith/core/data/local/entities/views/section_topics_view.dart';
import 'package:hadith/core/data/local/entities/views/topic_hadiths_view.dart';
import 'package:hadith/core/data/local/entities/views/topic_verses_view.dart';
import 'package:hadith/core/data/local/services/cuz_dao.dart';
import 'package:hadith/core/data/local/services/list/list_dao.dart';
import 'package:hadith/core/data/local/services/list/list_hadith_dao.dart';
import 'package:hadith/core/data/local/services/list/list_hadith_view_dao.dart';
import 'package:hadith/core/data/local/services/list/list_verse_dao.dart';
import 'package:hadith/core/data/local/services/list/list_verse_view_dao.dart';
import 'package:hadith/core/data/local/services/save_point_dao.dart';
import 'package:hadith/core/data/local/services/surah_dao.dart';
import 'package:hadith/core/data/local/services/topic/section_view_dao.dart';
import 'package:hadith/core/data/local/services/topic/topic_hadiths_view_dao.dart';
import 'package:hadith/core/data/local/services/topic/topic_verses_view_dao.dart';
import 'package:hadith/core/data/local/services/topic_save_point_dao.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/entities/backup_meta.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/history_entity.dart';
import 'package:hadith/db/entities/list_entity.dart';
import 'package:hadith/db/entities/list_hadith_entity.dart';
import 'package:hadith/db/entities/list_verse_entity.dart';
import 'package:hadith/db/entities/save_point_entity.dart';
import 'package:hadith/db/entities/topic_savepoint_entity.dart';
import 'package:hadith/db/entities/user_info_entity.dart';
import 'package:hadith/db/entities/verse_arabic.dart';
import 'package:hadith/db/entities/verse_audio.dart';
import 'package:hadith/db/entities/views/cuz_audio_view.dart';
import 'package:hadith/core/data/local/entities/views/hadith_info_list_view.dart';
import 'package:hadith/db/entities/views/i_list_view.dart';
import 'package:hadith/db/entities/views/list_hadith_view.dart';
import 'package:hadith/db/entities/views/list_verse_view.dart';
import 'package:hadith/db/entities/views/surah_audio_view.dart';
import 'package:hadith/core/data/local/entities/views/verse_info_list_view.dart';
import 'package:hadith/db/services/audio_edition_dao.dart';
import 'package:hadith/db/services/backup_dao.dart';
import 'package:hadith/db/services/backup_meta_dao.dart';
import 'package:hadith/db/services/history_dao.dart';
import 'package:hadith/db/services/manage_audio_dao.dart';
import 'package:hadith/db/services/save_point_dao.dart';
import 'package:hadith/db/services/section_dao.dart';
import 'package:hadith/db/services/topic_dao.dart';
import 'package:hadith/db/entities/helper/item_count_model.dart';
import 'package:hadith/db/services/topic_savepoint_dao.dart';
import 'package:hadith/db/services/user_info_dao.dart';
import 'package:hadith/db/services/verse_arabic_dao.dart';
import 'package:hadith/db/services/verse_audio_dao.dart';
import 'package:hadith/db/services/verse_audio_state_dao.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:hadith/features/extra_features/esmaul_husna/data/esmaul_husna_dao.dart';
import 'package:hadith/features/extra_features/islamic_info/data/islamic_info_dao.dart';
import 'package:hadith/features/extra_features/prayer_surah/data/entity/prayer_entity.dart';
import 'package:hadith/features/extra_features/prayer_surah/data/prayer_dao.dart';
import 'package:hadith/features/extra_features/quran_prayer/data/entity/quran_prayer_entity.dart';
import 'package:hadith/core/data/local/services/hadith_all_dao.dart';
import '../core/data/local/services/hadith_info_list_dao.dart';
import '../core/data/local/services/topic_dao.dart';
import '../core/data/local/services/verse_info_list_dao.dart';
import '../features/extra_features/counter/data/counter_dao.dart';
import '../features/extra_features/counter/data/entity/counter_entity.dart';
import '../features/extra_features/esmaul_husna/data/entity/esmaul_husna_entity.dart';
import '../features/extra_features/islamic_info/data/entity/islamic_info_item_entity.dart';
import '../features/extra_features/islamic_info/data/entity/islamic_info_title_entity.dart';
import '../features/extra_features/quran_prayer/data/quran_prayer_dao.dart';
import 'entities/hadith_topic.dart';
import 'entities/source_type_entity.dart';
import 'entities/verse_topic.dart';
import 'entities/book.dart';
import 'entities/hadith.dart';
import 'entities/cuz.dart';
import 'entities/section.dart';
import 'entities/surah.dart';
import 'entities/topic.dart';
import 'entities/verse.dart';
import 'services/hadith_dao.dart';
import 'services/cuz_dao.dart';
import 'services/list_dao.dart';
import 'services/surah_dao.dart';
import 'services/verse_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';

@Database(version: 4,
    entities: [HadithEntity,Cuz,Surah,Topic,Verse,Section,IntData,SavePointEntity,SavePointTypeEntity,
      BackupMeta,TopicSavePointEntityOld,HistoryEntity,UserInfoEntity,IListView,VerseArabic,
      ListEntity,SourceTypeEntity,ItemCountModel,VerseTopic,ListHadithEntity,DownloadVoiceEntity,
      ListVerseEntity,HadithTopic,Book,VerseAudio,AudioEdition,VerseAudioEntity,CounterEntity,
      EsmaulHusnaEntity, PrayerEntity, IslamicInfoItemEntity,IslamicInfoTitleEntity,
      SavePointEntityOld, TopicSavePointEntity, CuzEntity, SurahEntity,
      QuranPrayerEntity, Hadith, SavePointEntity, ListEntityOld, ListHadithEntityOld,ListVerseEntityOld
    ],
    views: [ListVerseView,ListHadithView,CuzAudioView,SurahAudioView,
      ListHadithViewOld,ListVerseViewOld,
      SectionTopicsView, TopicHadithsView, TopicVersesView,
      VerseInfoListView,HadithInfoListView])
abstract class AppDatabase extends FloorDatabase{
  HadithDaoOld get hadithDao;
  CuzDaoOld get cuzDaoOld;
  ListDaoOld get listDaoOld;
  SurahDaoOld get surahDaoOld;
  VerseDao get verseDao;
  TopicDaoOld get topicDaoOld;
  SectionDao get sectionDao;
  SavePointDaoOld get savePointDaoOld;
  TopicSavePointDaoOld get topicSavePointDaoOld;
  HistoryDao get historyDao;
  BackupMetaDao get backupMetaDao;
  BackupDao get backupDao;
  UserInfoDao get userInfoDao;
  AudioEditionDao get editionDao;
  VerseAudioDao get verseAudioDao;
  VerseArabicDao get verseArabicDao;
  VerseAudioStateDao get verseAudioStateDao;
  ManageAudioDao get manageAudioDao;
  CounterDao get counterDao;
  EsmaulHusnaDao get esmaulHusnaDao;
  PrayerDao get prayerDao;
  IslamicInfoDao get islamicInfoDao;
  QuranPrayerDao get quranPrayerDao;

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
}
