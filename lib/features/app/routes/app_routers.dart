
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/audio_setting/audio_settings_page.dart';
import 'package:hadith/features/app/root_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/counter_detail_setting/counter_detail_setting.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/detail_counter_empty_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/detail_counter_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/manage_counter_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/show_counter_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/prayer_and_verse_detail_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/prayer_and_verse_list_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/custom_prayer_detail_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_manage/custom_prayer_manage_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/show_custom_prayers_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/prayer_in_quran_page.dart';
import 'package:hadith/features/esmaul_husna/presentation/show_esmaul_husna_page.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/hadith_all_page.dart';
import 'package:hadith/features/hadiths/presentation/hadith_search_page.dart';
import 'package:hadith/features/islamic_info/adjectives_of/adjectives_of_page.dart';
import 'package:hadith/features/islamic_info/efali_mukellefin/efali_mukellefin_page.dart';
import 'package:hadith/features/islamic_info/fards/fards_info_page.dart';
import 'package:hadith/features/lists/presentation/archive_list/archive_list_page.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/savepoint_list_navigator_page.dart';
import 'package:hadith/features/lists/presentation/show_list/show_list_page.dart';
import 'package:hadith/features/search/presentation/search_page.dart';
import 'package:hadith/features/settings/presentation/settings_page.dart';
import 'package:hadith/features/topics/presentation/section_page/section_page.dart';
import 'package:hadith/features/topics/presentation/topic_page/topic_page.dart';
import 'package:hadith/features/verses/cuz/presentation/cuz_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_page_show_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_cuz_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_search_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_surah_page.dart';
import 'package:hadith/features/verses/surah/presentation/surah_page.dart';

part 'app_routers.g.dart';


@TypedGoRoute<RootRoute>(
    path: "/"
)
class RootRoute extends GoRouteData{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RootPage();
  }
}


@TypedGoRoute<HadithAllRoute>(
  path: "/hadith/all/:hadithBookId/:pos"
)
class HadithAllRoute extends GoRouteData{

  final int hadithBookId;
  final int pos;

  HadithAllRoute({required this.hadithBookId, this.pos = 0});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithAllPage(
        hadithBookEnum: HadithBookEnumExt.from(hadithBookId),
        pos: pos,
    );
  }
}


@TypedGoRoute<SearchRoute>(
    path: "/search"
)
class SearchRoute extends GoRouteData{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }
}


@TypedGoRoute<HadithSearchRoute>(
    path: "/hadith/search/:query/:bookScopeId/:criteriaId/:pos"
)
class HadithSearchRoute extends GoRouteData{

  final String query;
  final int bookScopeId;
  final int criteriaId;
  final int pos;

  HadithSearchRoute({
    required this.query,
    required this.bookScopeId,
    required this.criteriaId,
    this.pos = 0
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithSearchPage(
        query: query,
        searchCriteria: SearchCriteriaEnum.from(criteriaId),
        bookScope: BookScopeExt.fromBinaryId(bookScopeId),
        pos: pos
    );
  }
}


@TypedGoRoute<ArchiveListRoute>(
    path: "/archiveList"
)
class ArchiveListRoute extends GoRouteData{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArchiveListPage(initPos: 0,sourceTypeId: SourceTypeEnum.hadith.sourceId,);
  }
}

@TypedGoRoute<ArchiveListWithSelectedRoute>(
    path: "/archiveList/:listId/:sourceTypeId/:pos"
)
class ArchiveListWithSelectedRoute extends GoRouteData{
  final int pos;
  final int listId;
  final int sourceTypeId;
  ArchiveListWithSelectedRoute({
    this.pos = 0,
    required this.listId,
    required this.sourceTypeId
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArchiveListPage(initPos: pos,selectedListId: listId,sourceTypeId: sourceTypeId,);
  }
}

@TypedGoRoute<ShowListRoute>(
    path: "/showList/:listId/:sourceTypeId/:pos"
)
class ShowListRoute extends GoRouteData{
  final int pos;
  final int listId;
  final int sourceTypeId;
  ShowListRoute({
    this.pos = 0,
    required this.listId,
    required this.sourceTypeId
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShowListPage(initPos: pos,selectedListId: listId,sourceTypeId: sourceTypeId,);
  }
}

@TypedGoRoute<ListForSavePointNavigationRoute>(
    path: "/savePointListNavigator/:listId/:pos"
)
class ListForSavePointNavigationRoute extends GoRouteData{
  final int listId;
  final int pos;
  ListForSavePointNavigationRoute({
    required this.listId,
    required this.pos
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SavePointListNavigatorPage(listId: listId,listDefaultPos: pos,);
  }
}

@TypedGoRoute<SectionRoute>(
  path: "/section/:bookId"
)
class SectionRoute extends GoRouteData{
  final int bookId;
  SectionRoute({required this.bookId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SectionPage(
      bookEnum: BookEnum.from(bookId),
    );
  }
}

@TypedGoRoute<TopicListDetailRoute>(
    path: "/topicListDetail/:bookId/:sectionId/:sectionTitle/:useBookAllSections/:selectedTopicId/:listPos"
)
class TopicListDetailRoute extends GoRouteData{
  final int bookId;
  final int sectionId;
  final String sectionTitle;
  final bool useBookAllSections;
  final int? selectedTopicId;
  final int? listPos;

  TopicListDetailRoute({required this.bookId, required this.sectionId, required this.sectionTitle,
    required this.useBookAllSections,this.selectedTopicId, this.listPos});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TopicPage(
      bookEnum: BookEnum.from(bookId),
      sectionId: sectionId,
      sectionTitle: sectionTitle,
      useBookAllSections: useBookAllSections,
      initPos: listPos,
      selectedTopicId: selectedTopicId,
    );
  }
}


@TypedGoRoute<TopicRoute>(
    path: "/topic/:bookId/:sectionId/:sectionTitle/:useBookAllSections"
)
class TopicRoute extends GoRouteData{
  final int bookId;
  final int sectionId;
  final String sectionTitle;
  final bool useBookAllSections;

  TopicRoute({required this.bookId, required this.sectionId, required this.sectionTitle,
    required this.useBookAllSections});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TopicPage(
      bookEnum: BookEnum.from(bookId),
      sectionId: sectionId,
      sectionTitle: sectionTitle,
      useBookAllSections: useBookAllSections,
    );
  }
}


@TypedGoRoute<CuzRoute>(
  path: "/cuz"
)
class CuzRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CuzPage();
  }
}



@TypedGoRoute<SurahRoute>(
    path: "/surah"
)
class SurahRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SurahPage();
  }
}


@TypedGoRoute<VerseShowCuzRoute>(
    path: "/cuz/:cuzNo/:pos"
)
class VerseShowCuzRoute extends GoRouteData{

  final int cuzNo;
  final int pos;

  VerseShowCuzRoute({required this.cuzNo, this.pos = 0});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerseShowCuzPage(cuzNo: cuzNo, pos: pos,);
  }
}

@TypedGoRoute<VerseShowSurahRoute>(
    path: "/surah/:surahId/:pos"
)
class VerseShowSurahRoute extends GoRouteData{

  final int surahId;
  final int pos;

  VerseShowSurahRoute({required this.surahId, this.pos = 0});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerseShowSurahPage(surahId: surahId, pos: pos,);
  }
}

@TypedGoRoute<VersePageShowRoute>(
    path: "/verse/page/:pageIndex/:pagePos"
)
class VersePageShowRoute extends GoRouteData{

  final int pageIndex;
  final int pagePos;

  VersePageShowRoute({
    this.pageIndex = 0,
    this.pagePos = 0
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VersePageShowPage(startPageIndex: pageIndex, pagePos: pagePos,);
  }
}


@TypedGoRoute<VerseShowSearchRoute>(
    path: "/verse/search/:query/:bookScopeId/:criteriaId/:pos"
)
class VerseShowSearchRoute extends GoRouteData{

  final String query;
  final int bookScopeId;
  final int criteriaId;
  final int pos;

  VerseShowSearchRoute({
    required this.query,
    required this.bookScopeId,
    required this.criteriaId,
    this.pos = 0
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerseShowSearchPage(
        query: query,
        searchCriteria: SearchCriteriaEnum.from(criteriaId),
        bookScope: BookScopeExt.fromBinaryId(bookScopeId),
        pos: pos,
    );
  }
}


@TypedGoRoute<PrayerAndVerseListRoute>(
    path: "/prayerverse/list"
)
class PrayerAndVerseListRoute extends GoRouteData{

  PrayerAndVerseListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PrayerAndVerseListPage();
  }
}

@TypedGoRoute<PrayerAndVerseDetailRoute>(
    path: "/prayerverse/detail/:prayerId"
)
class PrayerAndVerseDetailRoute extends GoRouteData{

  final int prayerId;

  PrayerAndVerseDetailRoute({
    required this.prayerId
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PrayerAndVerseDetailPage(prayerId: prayerId);
  }
}


@TypedGoRoute<PrayerInQuranRoute>(
    path: "/prayerinqurans"
)
class PrayerInQuranRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PrayerInQuranPage();
  }
}

@TypedGoRoute<CustomPrayersRoute>(
    path: "/prayers/custom"
)
class CustomPrayersRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ShowCustomPrayersPage();
  }
}

@TypedGoRoute<CustomPrayerDetailRoute>(
    path: "/prayers/custom/detail/:prayerId"
)
class CustomPrayerDetailRoute extends GoRouteData{

  final int prayerId;
  CustomPrayerDetailRoute({required this.prayerId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomPrayerDetailPage(prayerId: prayerId,);
  }
}

@TypedGoRoute<AddCustomPrayerRoute>(
    path: "/prayers/custom/add"
)
class AddCustomPrayerRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomPrayerManagePage(prayerId: null);
  }
}

@TypedGoRoute<UpdateCustomPrayerRoute>(
    path: "/prayers/custom/update/:prayerId"
)
class UpdateCustomPrayerRoute extends GoRouteData{

  final int prayerId;
  UpdateCustomPrayerRoute({required this.prayerId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CustomPrayerManagePage(prayerId: prayerId);
  }
}

@TypedGoRoute<ShowEsmaulHusnaRoute>(
    path: "/esmaulHusna/:pos"
)
class ShowEsmaulHusnaRoute extends GoRouteData{

  final int pos;

  ShowEsmaulHusnaRoute({this.pos = 0});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShowEsmaulHusnaPage(initPos: pos,);
  }
}

@TypedGoRoute<ShowCountersRoute>(
    path: "/counters"
)
class ShowCountersRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ShowCounterPage();
  }
}

@TypedGoRoute<DetailCounterRoute>(
    path: "/counters/detail/:id"
)
class DetailCounterRoute extends GoRouteData{

  final int id;

  DetailCounterRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailCounterPage(counterId: id,);
  }
}

@TypedGoRoute<DetailCounterEmptyRoute>(
    path: "/counters/detail/empty/:counterTypeId"
)
class DetailCounterEmptyRoute extends GoRouteData{

  final int counterTypeId;

  DetailCounterEmptyRoute({required this.counterTypeId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailCounterEmptyPage(counterTypeId: counterTypeId);
  }
}


@TypedGoRoute<CounterSettingRoute>(
    path: "/counters/setting"
)
class CounterSettingRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CounterDetailSettingPage();
  }
}

@TypedGoRoute<AddNewCounterRoute>(
    path: "/counters/addNewCounter"
)
class AddNewCounterRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ManageCounterPage(counterId: null);
  }
}


@TypedGoRoute<ManageCounterRoute>(
    path: "/counters/manageCounter/:counterId"
)
class ManageCounterRoute extends GoRouteData{
  final int counterId;
  ManageCounterRoute({required this.counterId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ManageCounterPage(counterId: counterId);
  }
}


@TypedGoRoute<EfaliMukellefinRoute>(
    path: "/islamicInfo/efaliMukellefin"
)
class EfaliMukellefinRoute extends GoRouteData{
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EfaliMukellefinPage();
  }
}


@TypedGoRoute<FardsInfoRoute>(
    path: "/islamicInfo/fards/:fardsTypeId"
)
class FardsInfoRoute extends GoRouteData{

  final int fardsTypeId;

  FardsInfoRoute({required this.fardsTypeId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FardsInfoPage(fardsTypeId: fardsTypeId);
  }
}


@TypedGoRoute<AdjectiveOfAllahRoute>(
    path: "/islamicInfo/adjectiveOfAllah"
)
class AdjectiveOfAllahRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdjectiveOfPage();
  }
}

@TypedGoRoute<SettingsRoute>(
    path: "/settings"
)
class SettingsRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@TypedGoRoute<SettingsAudioRoute>(
    path: "/settings/audio"
)
class SettingsAudioRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsAudioPage();
  }
}