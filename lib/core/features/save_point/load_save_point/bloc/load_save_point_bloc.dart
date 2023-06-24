

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/core/features/save_point/load_save_point/model/result_load_save_point.dart';

import 'load_save_point_event.dart';
import 'load_save_point_state.dart';

class LoadSavePointBloc extends Bloc<ILoadSavePointEvent,LoadSavePointState>{

  late final SavePointRepo _savePointRepo;

  LoadSavePointBloc({required SavePointRepo savePointRepo}): super(LoadSavePointState.init()){

    _savePointRepo = savePointRepo;

    on<LoadSavePointEventLoadLast>(_onLoadLast, transformer: restartable());
    on<LoadSavePointEventLoadLastOrDefault>(_onLoadLastOrDefault, transformer: restartable());
    on<LoadSavePointEventClearResult>(_onClearResult, transformer: restartable());
  }


  void _onLoadLast(LoadSavePointEventLoadLast event, Emitter<LoadSavePointState> emit)async{
    final savePoint = await _savePointRepo.getLastSavePointByDestinationAndAutoType(
        event.destination, event.autoType
    );

    if(savePoint!=null){
      emit(state.copyWith(
        setResult: true,
        resultLoadSavePoint: ResultLoadSavePoint(destination: event.destination, itemIndexPos: savePoint.itemIndexPos)
      ));
    }
  }

  void _onLoadLastOrDefault(LoadSavePointEventLoadLastOrDefault event, Emitter<LoadSavePointState> emit)async{
    final savePoint = await _savePointRepo.getLastSavePointByDestinationAndAutoType(
        event.destination, event.autoType
    );

    if(savePoint!=null){
      emit(state.copyWith(
          setResult: true,
          resultLoadSavePoint: ResultLoadSavePoint(destination: event.destination, itemIndexPos: savePoint.itemIndexPos)
      ));
    }else{
      emit(state.copyWith(
          setResult: true,
          resultLoadSavePoint: ResultLoadSavePoint(destination: event.destination, itemIndexPos: event.defaultPos)
      ));
    }
  }

  void _onClearResult(LoadSavePointEventClearResult event, Emitter<LoadSavePointState> emit)async{
    emit(state.copyWith(setResult: true));
  }

}