
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/category/category_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/prayer_and_verse_detail_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/prayer_and_verse_list_page.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/prayer_in_quran_page.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/hadith_all_page.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/hadiths/presentation/hadith_list_page.dart';
import 'package:hadith/features/hadiths/presentation/hadith_search_page.dart';
import 'package:hadith/features/hadiths/presentation/hadith_topic_page.dart';
import 'package:hadith/features/lists/presentation/archive_list/archive_list_page.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/presentation/section_page/section_page.dart';
import 'package:hadith/features/topics/presentation/topic_page/topic_page.dart';
import 'package:hadith/features/verses/cuz/presentation/cuz_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_cuz_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_list_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_search_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_surah_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/verse_show_topic_page.dart';
import 'package:hadith/features/verses/surah/presentation/surah_page.dart';
part 'app_routers.g.dart';


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


@TypedGoRoute<HadithTopicRoute>(
    path: "/hadith/topic/:bookId/:topicId/:pos"
)
class HadithTopicRoute extends GoRouteData{
  final int bookId;
  final int topicId;
  final int pos;

  HadithTopicRoute({
    required this.bookId,
    required this.topicId,
    this.pos = 0
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithTopicPage(
        bookEnum: BookEnum.from(bookId),
        topicId: topicId,
        pos: pos
    );
  }
}


@TypedGoRoute<HadithListRoute>(
    path: "/hadith/list/:sourceId/:listId/:pos"
)
class HadithListRoute extends GoRouteData{
  final int listId;
  final int sourceId;
  final int pos;

  HadithListRoute({
    required this.sourceId,
    required this.listId,
    this.pos = 0
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithListPage(
        listBookScope: ListBookScopeExt.fromSourceType(SourceTypeEnumExt.fromSourceId(sourceId)),
        listId: listId,
        pos: pos
    );
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

  ArchiveListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ArchiveListPage();
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
      useBookAllSections: useBookAllSections
    );
  }
}


@TypedGoRoute<CuzRoute>(
  path: "/cuz"
)
class CuzRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CuzPage();
  }
}



@TypedGoRoute<SurahRoute>(
    path: "/surah"
)
class SurahRoute extends GoRouteData{

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SurahPage();
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


@TypedGoRoute<VerseShowListRoute>(
    path: "/verse/list/:sourceId/:listId/:pos"
)
class VerseShowListRoute extends GoRouteData{

  final int listId;
  final int pos;
  final int sourceId;

  VerseShowListRoute({required this.listId, required this.sourceId, this.pos = 0});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerseShowListPage(
        listId: listId,
        pos: pos,
        listBookScope: ListBookScopeExt.fromSourceType(SourceTypeEnumExt.fromSourceId(sourceId)));
  }
}

@TypedGoRoute<VerseShowTopicRoute>(
    path: "/verse/topic/:bookId/:topicId/:pos"
)
class VerseShowTopicRoute extends GoRouteData{

  final int topicId;
  final int bookId;
  final int pos;

  VerseShowTopicRoute({required this.topicId, required this.bookId, this.pos = 0});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerseShowTopicPage(topicId: topicId, pos: pos,bookEnum: BookEnum.from(bookId));
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
    return PrayerInQuranPage();
  }
}

