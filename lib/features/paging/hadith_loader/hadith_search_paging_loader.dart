
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/repos/search_manager.dart';
import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/repos/verse_repo.dart';
import 'i_paging_hadith_loader.dart';

class HadithSearchPagingLoader extends IPagingHadithLoader{
  final String searchKey;
  late final SearchManager _searchManager;

  HadithSearchPagingLoader(BuildContext context,{required this.searchKey}) : super(context){
    _searchManager=SearchManager(verseRepo: context.read<VerseRepoOld>(), hadithRepo: hadithRepo);
  }

  @override
  Future<List<Hadith>> getHadiths(int limit, int page){
    return _searchManager.getPagingSearchHadiths(limit, page,searchKey);
  }

  @override
  Future<IntData?> getPagingCount(){
    return _searchManager.getSearchWithHadithCount(searchKey);
  }

}