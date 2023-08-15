import 'package:hadith/features/extra_features/counter/presentation/counter_detail/counter_detail_page.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/detail_islamic_info_page.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/detail_prayer_page.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/show_prayer_surah/show_prayer_surah_page.dart';
import 'package:hadith/features/hadiths/presentation/hadith_all_page.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';
import 'package:hadith/features/settings/audio_setting/audio_settings.dart';

import '../../features/hadith/hadith_page_scrollable.dart';
import '../../features/list/list_archive_screen.dart';
import '../../features/search/search_page.dart';
import '../../features/topic/section_screen.dart';
import '../../features/topic/topic_screen.dart';
import '../../features/verse/cuz/cuz_screen.dart';
import '../../features/verse/surah/surah_screen.dart';
import '../../features/verse/verse_screen.dart';
import '../extra_features/counter/presentation/add_counter/add_counter_page.dart';
import '../extra_features/counter/presentation/counter_detail_setting/counter_detail_setting.dart';
import '../extra_features/counter/presentation/manage_counter/manage_counter_page.dart';
import '../extra_features/counter/presentation/show_counters/show_counter_page.dart';
import '../extra_features/esmaul_husna/presentation/detail_esmaul_husna/detail_esmaul_husna_page.dart';
import '../extra_features/esmaul_husna/presentation/show_list_esmaul_husna/esmaul_husna_page.dart';
import '../extra_features/quran_prayer/presentation/show_quran_prayer_page/show_quran_prayer_page.dart';
import '../settings/setting_screen.dart';
import 'bottom_navbar.dart';

final kRouters={
  BottomNavBar.id: (context) => const BottomNavBar(),
  VerseScreen.id: (context) => const VerseScreen(),
  TopicScreen.id: (context) => const TopicScreen(),
  SectionScreen.id: (context) => const SectionScreen(),
  HadithPageScrollable.id: (context) => const HadithPageScrollable(),
  CuzScreen.id: (context) => const CuzScreen(),
  SearchPage.id: (context) => const SearchPage(),
  SurahScreen.id: (context) => const SurahScreen(),
  SettingScreen.id:(context)=> SettingScreen(),
  ListArchiveScreen.id:(context)=> const ListArchiveScreen(),
  AudioSettings.id: (context)=> AudioSettings(),
  ShowCounterPageOld.id: (context) => ShowCounterPageOld(),
  ManageCounterPageOld.id: (context)=> const ManageCounterPageOld(),
  CounterDetailPage.id: (context) => const CounterDetailPage(),
  CounterDetailSettingPageOld.id: (context)=> const CounterDetailSettingPageOld(),
  AddCounterPageOld.id: (context)=>AddCounterPageOld(),
  EsmaulHusnaPageOld.id: (context)=> const EsmaulHusnaPageOld(),
  DetailEsmaulHusnaPageOld.id: (context)=> DetailEsmaulHusnaPageOld(),
  ShowPrayerSurahPage.id: (context) => ShowPrayerSurahPage(),
  DetailPrayerPage.id: (context) => const DetailPrayerPage(),
  DetailIslamicInfoPage.id: (context) => DetailIslamicInfoPage(),
  ShowQuranPrayerPage.id: (context)=>ShowQuranPrayerPage(),

  // HadithAllPage.id: (context)=>HadithAllPage(),
  ShowListPage.id: (context)=>ShowListPage()

};