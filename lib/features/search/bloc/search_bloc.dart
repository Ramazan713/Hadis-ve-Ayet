import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/db/repos/search_manager.dart';
import 'package:hadith/db/repos/hadith_repo.dart';
import 'package:hadith/db/repos/verse_repo.dart';
import 'package:hadith/features/search/bloc/search_event.dart';
import 'package:hadith/features/search/bloc/search_state.dart';

class SearchBlocOld extends Bloc<ISearchEvent,SearchState>{
  final VerseRepoOld verseRepo;
  final HadithRepoOld hadithRepo;
  late final SearchManager searchManager;
  SearchBlocOld({required this.verseRepo,required this.hadithRepo})
      : super(const SearchState.initial()){

    searchManager=SearchManager(verseRepo: verseRepo, hadithRepo: hadithRepo);

    on<SearchEventRequestResult>(_onRequestResult);
    on<SearchEventResetState>(_onResetState);
  }

  void _onRequestResult(SearchEventRequestResult event, Emitter<SearchState> emit)async{
    emit(state.copyWith(status: DataStatus.loading));
    final String searchText=event.searchKey;
    final int verseCount=((await searchManager.getSearchWithVerseCount(searchText))?.data)??0;
    final int sitteCount=
        ((await searchManager.getSearchHadithCountWithBook(searchText,BookEnum.sitte.bookId))?.data)??0;
    final int serlevhaCount=
        ((await searchManager.getSearchHadithCountWithBook(searchText,BookEnum.serlevha.bookId))?.data)??0;
    final int hadithCount=sitteCount+serlevhaCount;
    emit(state.copyWith(status: DataStatus.success,hadithCount: hadithCount,serlevhaCount: serlevhaCount,
      sitteCount: sitteCount,verseCount: verseCount,searchKey: searchText));
  }

  void _onResetState(SearchEventResetState event, Emitter<SearchState> emit){
    emit(state.copyWith(status: DataStatus.success,verseCount: 0,sitteCount: 0,
      serlevhaCount: 0,hadithCount: 0,searchKey: ""));
  }
}