
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/hadith_all_page.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/hadiths/presentation/hadith_list_page.dart';
import 'package:hadith/features/hadiths/presentation/hadith_topic_page.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/presentation/section_page/section_page.dart';
import 'package:hadith/features/topics/presentation/topic_page/topic_page.dart';
part 'app_routers.g.dart';


@TypedGoRoute<HadithAllRoute>(
  path: "/all_hadiths/:hadithBookId"
)
class HadithAllRoute extends GoRouteData{

  final int hadithBookId;

  HadithAllRoute({required this.hadithBookId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithAllPage(
        hadithBookEnum: HadithBookEnumExt.from(hadithBookId)
    );
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
    path: "/hadithTopic/:bookId/:topicId/:topicName"
)
class HadithTopicRoute extends GoRouteData{
  final int bookId;
  final int topicId;
  final String topicName;
  HadithTopicRoute({
    required this.bookId,
    required this.topicId,
    required this.topicName
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithTopicPage(
        bookEnum: BookEnum.from(bookId),
        topicId: topicId,
        topicName: topicName
    );
  }
}


@TypedGoRoute<HadithListRoute>(
    path: "/hadithList/:listBookId/:listId/:listName"
)
class HadithListRoute extends GoRouteData{
  final int listId;
  final String listName;
  final int listBookId;

  HadithListRoute({
    required this.listBookId,
    required this.listId,
    required this.listName
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HadithListPage(
        listBookScope: ListBookScopeExt.fromWithDefault(BookScopeExt.fromBinaryId(listBookId)),
        listId: listId,
        listName: listName,
    );
  }
}









