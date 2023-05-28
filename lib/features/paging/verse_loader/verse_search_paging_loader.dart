import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/repos/hadith_repo.dart';
import 'package:flutter/material.dart';
import 'package:hadith/db/repos/search_manager.dart';
import 'i_paging_verse_loader.dart';

class VerseSearchPagingLoader extends IPagingVerseLoader{
  final String searchKey;
  late final SearchManager _searchManager;

  VerseSearchPagingLoader(BuildContext context,{required this.searchKey}) : super(context){
    _searchManager=SearchManager(verseRepo: verseRepo, hadithRepo:  context.read<HadithRepoOld>());

  }

  @override
  Future<IntData?> getPagingCount() {
    return _searchManager.getSearchWithVerseCount(searchKey);
  }

  @override
  Future<List<Verse>> getVerses(int limit, int page) {
    return _searchManager.getPagingSearchVerses(limit, page, searchKey);
  }

}