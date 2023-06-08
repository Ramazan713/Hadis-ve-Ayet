
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/hadith_all_page.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/hadiths/presentation/hadith_list_page.dart';
import 'package:hadith/features/hadiths/presentation/hadith_topic_page.dart';
import 'package:hadith/features/lists/presentation/archive_list/archive_list_page.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/presentation/section_page/section_page.dart';
import 'package:hadith/features/topics/presentation/topic_page/topic_page.dart';
import 'package:hadith/features/verses/cuz/presentation/cuz_page.dart';
import 'package:hadith/features/verses/surah/presentation/surah_page.dart';
part 'app_routers.g.dart';


@TypedGoRoute<HadithAllRoute>(
  path: "/all_hadiths/:hadithBookId/:pos"
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


@TypedGoRoute<HadithTopicRoute>(
    path: "/hadithTopic/:bookId/:topicId/:pos"
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
    path: "/hadithList/:listBookId/:listId/:pos"
)
class HadithListRoute extends GoRouteData{
  final int listId;
  final int listBookId;
  final int pos;

  HadithListRoute({
    required this.listBookId,
    required this.listId,
    this.pos = 0
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithListPage(
        listBookScope: ListBookScopeExt.fromWithDefault(BookScopeExt.fromBinaryId(listBookId)),
        listId: listId,
        pos: pos
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






