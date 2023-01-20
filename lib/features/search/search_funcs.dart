import 'package:flutter/material.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import '../../constants/enums/book_enum.dart';
import '../save_point/constants/origin_tag_enum.dart';
import '../../models/save_point_argument.dart';
import '../hadith/hadith_page_scrollable.dart';
import '../paging/hadith_loader/hadith_search_paging_loader.dart';
import '../paging/hadith_loader/hadith_search_with_bookid_loader.dart';
import '../paging/i_paging_loader.dart';
import '../paging/paging_argument.dart';
import '../paging/verse_loader/verse_search_paging_loader.dart';
import '../verse/verse_screen.dart';
import 'bloc/search_state.dart';
import 'model/search_result_model.dart';

PagingArgument _getPagingArgument(
    String searchKey, BookScopeEnum bookScope, IPagingLoader loader) {
  return PagingArgument(
      bookScope: bookScope,
      savePointArg: SavePointLoadArg(parentKey: searchKey),
      title: searchKey,
      searchKey: searchKey,
      originTag: OriginTag.search,
      loader: loader);
}

List<SearchResultModel> getResultModels(
    BuildContext context, SearchState state) {
  final String searchKey = state.searchKey;
  final List<SearchResultModel> results = [];

  final verseArgument = _getPagingArgument(
      searchKey,
      BookScopeEnum.diyanetMeal,
      VerseSearchPagingLoader(context, searchKey: searchKey));
  final sitteArgument = _getPagingArgument(
      searchKey,
      BookScopeEnum.sitte,
      HadithSearchBookIdLoader(context,
          searchKey: searchKey, bookId: BookEnum.sitte.bookId));
  final serlevhaArgument = _getPagingArgument(
      searchKey,
      BookScopeEnum.serlevha,
      HadithSearchBookIdLoader(context,
          searchKey: searchKey, bookId: BookEnum.serlevha.bookId));
  final allHadithArgument = _getPagingArgument(
      searchKey,
      BookScopeEnum.serlevhaSitte,
      HadithSearchPagingLoader(context, searchKey: searchKey));
  if(state.verseCount!=0){
    results.add(SearchResultModel(
        resultCount: state.verseCount,
        title: "Ayetler",
        argument: verseArgument,
        destinationId: VerseScreen.id));
  }

  if(state.hadithCount!=0){
    results.add(SearchResultModel(
        resultCount: state.hadithCount,
        title: "Tüm Hadisler",
        argument: allHadithArgument,
        destinationId: HadithPageScrollable.id));
  }
  if(state.serlevhaCount!=0){
    results.add(SearchResultModel(
        resultCount: state.serlevhaCount,
        title: "Serlevha Hadis",
        argument: serlevhaArgument,
        destinationId: HadithPageScrollable.id));
  }
  if(state.sitteCount!=0){
    results.add(SearchResultModel(
        resultCount: state.sitteCount,
        title: "Kütübi Sitte Hadis",
        argument: sitteArgument,
        destinationId: HadithPageScrollable.id));
  }
  return results;
}