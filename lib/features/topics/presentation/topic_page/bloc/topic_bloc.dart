
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/domain/repo/topic_view_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'topic_event.dart';
import 'topic_state.dart';


class TopicBloc extends Bloc<ITopicEvent, TopicState>{

  final BehaviorSubject<String> _queryFilter = BehaviorSubject();
  late final TopicViewRepo _topicViewRepo;

  TopicBloc({
    required TopicViewRepo topicViewRepo,
  }):super(TopicState.init()){

    _topicViewRepo = topicViewRepo;

    on<TopicEventSetSearchBarVisibility>(_onSearchBarVisible, transformer: restartable());
    on<TopicEventSearch>(_onSearch, transformer: restartable());
    on<TopicEventLoadData>(_onLoadData, transformer: restartable());
    on<TopicEventHideDetail>(_onHideDetail);
    on<TopicEventShowDetail>(_onShowDetail);
    on<TopicEventClearJumpToPos>(_onClearJumpToPos);
  }

  void _onLoadData(TopicEventLoadData event, Emitter<TopicState> emit) async{

    _queryFilter.add("");
    final sourceType = event.book.sourceType;

    emit(state.copyWith(isLoading: true, items: []));
    if(event.selectedTopicId != null){
      final initItems = event.useBookAllSections ? await _topicViewRepo.getTopicViewsByBookId(event.book.bookId, sourceType) :
          await _topicViewRepo.getTopicViewsBySectionId(event.sectionId, sourceType);

      final pos = initItems.indexWhere((e) => e.id == event.selectedTopicId);
      if(pos != -1){
        emit(state.copyWith(items: initItems,jumpToPos: pos, selectedItem: initItems[pos],isDetailOpen: true));
      }
    }


    final streamData = _queryFilter.distinct().switchMap((query){
      if(event.useBookAllSections) {
        return _getAllBookSectionTopics(event.book, query, sourceType);
      }
      return _getSectionTopics(event.sectionId, query, sourceType);
    });

    await emit.forEach<List<TopicViewModel>>(streamData, onData: (items){
      final selectedItem = _queryFilter.value.isEmpty ? (state.selectedItem ?? items.firstOrNull) :
          items.firstOrNull;
      return state.copyWith(items: items, isLoading: false, selectedItem: selectedItem);
    });
  }


  void _onHideDetail(TopicEventHideDetail event, Emitter<TopicState>emit){
    emit(state.copyWith(selectedItem: null, isDetailOpen: false));
  }

  void _onClearJumpToPos(TopicEventClearJumpToPos event, Emitter<TopicState>emit){
    emit(state.copyWith(jumpToPos: null));
  }

  void _onShowDetail(TopicEventShowDetail event, Emitter<TopicState>emit){
    emit(state.copyWith(selectedItem: event.item, isDetailOpen: true));
  }

  void _onSearchBarVisible(TopicEventSetSearchBarVisibility event, Emitter<TopicState> emit){
    emit(state.copyWith(searchBarVisible: event.isSearchBarVisible));
  }

  void _onSearch(TopicEventSearch event, Emitter<TopicState> emit){
    EasyDebounce.debounce("topic_search", const Duration(milliseconds: K.searchDelaySearchMilliSecond), () {
      _queryFilter.add(event.query);
    });
  }

  Stream<List<TopicViewModel>> _getAllBookSectionTopics(BookEnum bookEnum, String query,SourceTypeEnum sourceType){
    if(query.trim().isEmpty){
      return _topicViewRepo.getStreamTopicViewsByBookId(bookEnum.bookId,sourceType);
    }
    return _topicViewRepo.getStreamTopicViewsByBookIdAndQuery(bookEnum.bookId, query, sourceType);
  }

  Stream<List<TopicViewModel>> _getSectionTopics(int sectionId, String query,SourceTypeEnum sourceType){
    if(query.trim().isEmpty){
      return _topicViewRepo.getStreamTopicViewsBySectionId(sectionId, sourceType);
    }
    return _topicViewRepo.getStreamTopicViewsBySectionIdAndQuery(sectionId, query, sourceType);
  }

}