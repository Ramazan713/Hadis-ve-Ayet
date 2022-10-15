

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/repos/search_manager.dart';
import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/repos/verse_repo.dart';
import 'package:hadith/features/paging/hadith_loader/i_paging_hadith_loader.dart';

class HadithSearchBookIdLoader extends IPagingHadithLoader{
  final String searchKey;
  final int bookId;
  late final SearchManager _searchManager;

  HadithSearchBookIdLoader(BuildContext context,{required this.searchKey,
    required this.bookId})
      : super(context){
    _searchManager=SearchManager(verseRepo: context.read<VerseRepo>(), hadithRepo: hadithRepo);
  }

  @override
  Future<List<Hadith>> getHadiths(int limit, int page) {
    return _searchManager.getPagingSearchHadithsWithBook(limit, page, bookId, searchKey);
  }

  @override
  Future<IntData?> getPagingCount() {
    return _searchManager.getSearchHadithCountWithBook(searchKey,bookId);
  }
}