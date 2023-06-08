
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/domain/repo/topic_save_point_repo.dart';
import 'package:hadith/core/domain/use_cases/topic_save_point/topic_save_point_use_cases.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/domain/repo/topic_view_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'topic_event.dart';
import 'topic_state.dart';


class TopicBloc extends Bloc<ITopicEvent, TopicState>{


  final BehaviorSubject<String> _queryFilter = BehaviorSubject();

  late final TopicViewRepo _topicViewRepo;

  Timer? _timer;

  TopicBloc({
    required TopicViewRepo topicViewRepo,
  }):super(TopicState.init()){

    _topicViewRepo = topicViewRepo;

    on<TopicEventSetSearchBarVisibility>(_onSearchBarVisible, transformer: restartable());
    on<TopicEventSearch>(_onSearch, transformer: restartable());
    on<TopicEventLoadData>(_onLoadData, transformer: restartable());

  }

  void _onSearchBarVisible(TopicEventSetSearchBarVisibility event, Emitter<TopicState> emit){
    emit(state.copyWith(searchBarVisible: event.isSearchBarVisible));
  }

  void _onSearch(TopicEventSearch event, Emitter<TopicState> emit){
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: kTimerDelaySearchMilliSecond), () async{
      _queryFilter.add(event.query);
    });
  }


  void _onLoadData(TopicEventLoadData event, Emitter<TopicState> emit) async{

    _queryFilter.add("");
    final sourceType = event.book.sourceType;

    emit(state.copyWith(isLoading: true, items: []));

    final streamData = _queryFilter.switchMap((query){
      if(event.useBookAllSections) {
        return _getAllBookSectionTopics(event.book, query, sourceType);
      }
      return _getSectionTopics(event.sectionId, query, sourceType);
    });

    await emit.forEach<List<TopicViewModel>>(streamData, onData: (items){
      return state.copyWith(items: items,isLoading: false);
    });
  }

  Stream<List<TopicViewModel>> _getAllBookSectionTopics(BookEnum bookEnum, String query,SourceTypeEnum sourceType){
    if(query.trim().isEmpty){
      return _topicViewRepo.getTopicViewsByBookId(bookEnum.bookId,sourceType);
    }
    return _topicViewRepo.getTopicViewsByBookIdAndQuery(bookEnum.bookId, query, sourceType);
  }

  Stream<List<TopicViewModel>> _getSectionTopics(int sectionId, String query,SourceTypeEnum sourceType){
    if(query.trim().isEmpty){
      return _topicViewRepo.getTopicViewsBySectionId(sectionId, sourceType);
    }
    return _topicViewRepo.getTopicViewsBySectionIdAndQuery(sectionId, query, sourceType);
  }

}