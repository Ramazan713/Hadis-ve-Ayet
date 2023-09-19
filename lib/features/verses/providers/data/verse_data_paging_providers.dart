


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_list_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_page_paing_repo.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_search_paging_repo.dart';

import '../../show_verse/data/repo/verse_cuz_paging_repo.dart';
import '../../show_verse/data/repo/verse_surah_paging_repo.dart';
import '../../show_verse/data/repo/verse_topic_paging_repo.dart';

List<RepositoryProvider> pVerseDataPagingProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<VerseListPagingRepo>(create: (context) => VerseListPagingRepo(
        verseRepo: context.read(),
        verseArabicRepo: context.read(),
        itemListInfoRepo: context.read(),
    )),

    RepositoryProvider<VerseCuzPagingRepo>(create: (context) => VerseCuzPagingRepo(
        verseRepo: context.read(),
        verseArabicRepo: context.read(),
        itemListInfoRepo: context.read(),
    )),

    RepositoryProvider<VerseSurahPagingRepo>(create: (context) => VerseSurahPagingRepo(
        verseRepo: context.read(),
        verseArabicRepo: context.read(),
        itemListInfoRepo: context.read(),
    )),

    RepositoryProvider<VerseTopicPagingRepo>(create: (context) => VerseTopicPagingRepo(
        verseRepo: context.read(),
        verseArabicRepo: context.read(),
        itemListInfoRepo: context.read(),
    )),

    RepositoryProvider<VerseSearchPagingRepo>(create: (context) => VerseSearchPagingRepo(
      verseRepo: context.read(),
      verseArabicRepo: context.read(),
      itemListInfoRepo: context.read(),
      searchRepo:  context.read()
    )),

    RepositoryProvider<VersePagePagingRepo>(create: (context) => VersePagePagingRepo(
        verseRepo: context.read(),
        verseArabicRepo: context.read(),
        itemListInfoRepo: context.read(),
    )),
  ];
}