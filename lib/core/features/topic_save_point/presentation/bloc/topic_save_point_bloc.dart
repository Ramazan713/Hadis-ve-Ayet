
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/topic_save_point_use_cases.dart';

import 'topic_save_point_event.dart';
import 'topic_save_point_state.dart';

class TopicSavePointBloc extends Bloc<ITopicSavePointEvent, TopicSavePointState>{

  late final TopicSavePointUseCases _topicSavePointUseCases;

  TopicSavePointBloc({
    required TopicSavePointUseCases topicSavePointUseCases
  }):super(TopicSavePointState.init()){

    _topicSavePointUseCases = topicSavePointUseCases;

    on<TopicSavePointEventLoadData>(_onListenSavePoint, transformer: restartable());
    on<TopicSavePointEventInsertSavePoint>(_onInsertSavePoint, transformer: restartable());
    on<TopicSavePointEventDeleteSavePoint>(_onDeleteSavePoint, transformer: restartable());

  }


  void _onInsertSavePoint(TopicSavePointEventInsertSavePoint event, Emitter<TopicSavePointState> emit)async{
    await _topicSavePointUseCases.insertSavePoint.call(event.pos, state.topicType);
  }

  void _onDeleteSavePoint(TopicSavePointEventDeleteSavePoint event, Emitter<TopicSavePointState> emit)async{
    final topicSavePoint = state.topicSavePoint;
    if(topicSavePoint!=null){
      await _topicSavePointUseCases.deleteSavePoint.call(topicSavePoint);
    }
  }


  void _onListenSavePoint(TopicSavePointEventLoadData event, Emitter<TopicSavePointState> emit)async{

    emit(state.copyWith(topicType: event.topicType));

    final streamData = _topicSavePointUseCases.getSavePoint(event.topicType);

    await emit.forEach<TopicSavePoint?>(streamData, onData: (topicSavePoint){
      return state.copyWith(setTopicSavePoint: true, topicSavePoint: topicSavePoint);
    });
  }
}