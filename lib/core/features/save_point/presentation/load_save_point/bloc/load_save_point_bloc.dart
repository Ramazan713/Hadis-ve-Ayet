
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/repo/item_position_repo.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/result_load_save_point.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';
import 'package:hadith/core/features/verses/domain/repo/surah_repo.dart';

import 'load_save_point_event.dart';
import 'load_save_point_state.dart';

class LoadSavePointBloc extends Bloc<ILoadSavePointEvent,LoadSavePointState>{

  late final SavePointRepo _savePointRepo;
  late final ItemPositionRepo _itemPositionRepo;
  late final SurahRepo _surahRepo;

  LoadSavePointBloc({
    required SavePointRepo savePointRepo,
    required ItemPositionRepo itemPositionRepo,
    required SurahRepo surahRepo
  }): super(LoadSavePointState.init()){

    _savePointRepo = savePointRepo;
    _itemPositionRepo = itemPositionRepo;
    _surahRepo = surahRepo;

    on<LoadSavePointEventLoadLast>(_onLoadLast, transformer: restartable());
    on<LoadSavePointEventNavigateWithSurahDestination>(_onNavigateWithSurahDestination, transformer: restartable());
    on<LoadSavePointEventLoadLastOrDefault>(_onLoadLastOrDefault, transformer: restartable());
    on<LoadSavePointEventNavigateToSurahDestinationWithMealId>(_onNavigateToSurahDestinationWithMealId, transformer: restartable());
    on<LoadSavePointEventClearResult>(_onClearResult, transformer: restartable());
  }


  void _onLoadLast(LoadSavePointEventLoadLast event, Emitter<LoadSavePointState> emit)async{
    final savePoint = await _savePointRepo.getLastSavePointByDestinationAndAutoType(
        event.destination, event.autoType
    );

    if(savePoint!=null){
      emit(state.copyWith(
        setResult: true,
        resultLoadSavePoint: ResultLoadSavePoint(destination: event.destination, itemIndexPos: savePoint.itemPos)
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
          resultLoadSavePoint: ResultLoadSavePoint(destination: event.destination, itemIndexPos: savePoint.itemPos)
      ));
    }else{
      emit(state.copyWith(
          setResult: true,
          resultLoadSavePoint: ResultLoadSavePoint(destination: event.destination, itemIndexPos: event.defaultPos)
      ));
    }
  }

  void _onNavigateWithSurahDestination(LoadSavePointEventNavigateWithSurahDestination event, Emitter<LoadSavePointState> emit)async{
    final destination = event.destination;
    final pos = await _itemPositionRepo.getSurahPos(destination.surahId, event.mealId);

    emit(state.copyWith(
      setResult: true,
      resultLoadSavePoint: ResultLoadSavePoint(destination: destination, itemIndexPos: pos + 1)
    ));
  }

  void _onNavigateToSurahDestinationWithMealId(LoadSavePointEventNavigateToSurahDestinationWithMealId event, Emitter<LoadSavePointState> emit)async{
    final surah = await _surahRepo.getSurahFromMealId(event.mealId);
    if(surah == null) return;

    final destination = DestinationSurah(surahId: surah.id, surahName: surah.name);
    add(LoadSavePointEventNavigateWithSurahDestination(destination: destination,mealId: event.mealId));
  }

  void _onClearResult(LoadSavePointEventClearResult event, Emitter<LoadSavePointState> emit)async{
    emit(state.copyWith(setResult: true));
  }

}