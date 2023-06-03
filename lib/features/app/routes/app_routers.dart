
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/all_hadith/hadith_all_page.dart';
import 'package:flutter/material.dart';
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













