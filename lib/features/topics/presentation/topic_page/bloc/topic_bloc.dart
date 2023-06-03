
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
  late final TopicSavePointUseCases _topicSavePointUseCases;

  Timer? _timer;

  TopicBloc({
    required TopicViewRepo topicViewRepo,
    required TopicSavePointUseCases topicSavePointUseCases
  }):super(TopicState.init()){

    _topicViewRepo = topicViewRepo;
    _topicSavePointUseCases = topicSavePointUseCases;

    on<TopicEventSetSearchBarVisibility>(_onSearchBarVisible, transformer: restartable());
    on<TopicEventSearch>(_onSearch, transformer: restartable());
    on<TopicEventLoadData>(_onLoadData, transformer: restartable());
    on<TopicEventListenTopicSavePoint>(_onListenSavePoint, transformer: restartable());
    on<TopicEventInsertSavePoint>(_onInsertSavePoint, transformer: restartable());
    on<TopicEventDeleteSavePoint>(_onDeleteSavePoint, transformer: restartable());
    on<TopicEventSetScrollDirection>(_onSetScrollDirection, transformer: restartable());
    on<TopicEventSetVisibleMiddlePos>(_onSetVisibleMiddlePos, transformer: restartable());

  }


  void _onSetScrollDirection(TopicEventSetScrollDirection event, Emitter<TopicState> emit){
    emit(state.copyWith(scrollDirection: event.scrollDirection));
  }

  void _onSetVisibleMiddlePos(TopicEventSetVisibleMiddlePos event, Emitter<TopicState> emit){
    final middlePos = (event.firstVisiblePos + event.lastVisiblePos) ~/ 2;
    emit(state.copyWith(middleVisiblePos: middlePos));
  }

  void _onInsertSavePoint(TopicEventInsertSavePoint event, Emitter<TopicState> emit)async{
    await _topicSavePointUseCases.insertSavePoint.call(event.pos, state.topicType);
  }
  void _onDeleteSavePoint(TopicEventDeleteSavePoint event, Emitter<TopicState> emit)async{
    final topicSavePoint = state.topicSavePoint;
    if(topicSavePoint!=null){
      await _topicSavePointUseCases.deleteSavePoint.call(topicSavePoint);
    }
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


  void _onListenSavePoint(TopicEventListenTopicSavePoint event, Emitter<TopicState> emit)async{

    final streamData = _topicSavePointUseCases.getSavePoint(state.topicType);

    await emit.forEach<TopicSavePoint?>(streamData, onData: (topicSavePoint){
      return state.copyWith(setTopicSavePoint: true, topicSavePoint: topicSavePoint);
    });
  }

  void _onLoadData(TopicEventLoadData event, Emitter<TopicState> emit) async{

    _queryFilter.add("");
    final sourceType = event.book.bookScope?.sourceType ?? SourceTypeEnum.hadith;

    emit(state.copyWith(topicType: _getTopicType(event.book, event.useBookAllSections, event.sectionId)));
    add(TopicEventListenTopicSavePoint());


    final streamData = _queryFilter.switchMap((query){
      if(event.useBookAllSections) {
        return _getAllBookSectionTopics(event.book, query, sourceType);
      }
      return _getSectionTopics(event.sectionId, query, sourceType);
    });

    await emit.forEach<List<TopicViewModel>>(streamData, onData: (items){
      return state.copyWith(items: items);
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


  TopicSavePointType _getTopicType(
    BookEnum book,
    bool useBookAllSections,
    int sectionId
  ){
    if(useBookAllSections){
      return TopicSavePointTypeTopicUsesAllBook(bookEnum: book);
    }
    return TopicSavePointTypeTopic(sectionId: sectionId);
  }

}