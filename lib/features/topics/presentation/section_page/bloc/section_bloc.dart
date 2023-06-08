
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';
import 'package:hadith/features/topics/domain/repo/section_view_repo.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_event.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_state.dart';
import 'package:hadith/features/topics/presentation/section_page/section_model.dart';
import 'package:rxdart/rxdart.dart';

class SectionBloc extends Bloc<ISectionEvent, SectionState>{


  final BehaviorSubject<String> _queryFilter = BehaviorSubject();

  late final SectionViewRepo _sectionViewRepo;

  Timer? _timer;

  SectionBloc({required SectionViewRepo sectionViewRepo}): super(SectionState.init()){

    _sectionViewRepo = sectionViewRepo;

    on<SectionEventSetSearchBarVisibility>(_onSearchBarVisible, transformer: restartable());
    on<SectionEventSearch>(_onSearch, transformer: restartable());
    on<SectionEventLoadData>(_onLoadData, transformer: restartable());
  }




  void _onLoadData(SectionEventLoadData event, Emitter<SectionState> emit) async{

    _queryFilter.add("");

    emit(state.copyWith(isLoading: true, items: []));

    final bookSection = await _getBookSectionModel(event.book);

    final streamData = _queryFilter.switchMap((query){
      if(query.trim().isEmpty){
        return _sectionViewRepo.getSectionTopicsByBookId(event.book.bookId);
      }else{
        return _sectionViewRepo.getSectionTopicsByBookIdAndQuery(event.book.bookId, query);
      }
    });

    await emit.forEach<List<SectionViewModel>>(streamData, onData: (items){
      final sectionModels = items.map((e) => SectionModel(sectionViewModel: e,isBookSection: false))
          .toList();
      if(_queryFilter.value.trim().isEmpty){
        sectionModels.insert(0, bookSection);
      }
      return state.copyWith(items: sectionModels, isLoading: false);
    });
  }

  void _onSearchBarVisible(SectionEventSetSearchBarVisibility event, Emitter<SectionState> emit){
    emit(state.copyWith(searchBarVisible: event.isSearchBarVisible));
  }

  void _onSearch(SectionEventSearch event, Emitter<SectionState> emit){
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: kTimerDelaySearchMilliSecond), () async{
      _queryFilter.add(event.query);
    });
  }

  Future<SectionModel> _getBookSectionModel(BookEnum bookEnum)async{
    final itemCounts = await _sectionViewRepo.getTopicsCountByBookId(bookEnum.bookId);
    final sectionViewModel = SectionViewModel(
        id: 0, name: "Tüm Başlıklar", topicsCount: itemCounts, book: bookEnum);

    return SectionModel(sectionViewModel: sectionViewModel,isBookSection: true);
  }


}