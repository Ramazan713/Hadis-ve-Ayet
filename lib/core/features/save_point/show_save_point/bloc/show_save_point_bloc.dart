import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/use_cases/save_point/save_point_use_cases.dart';
import 'package:rxdart/rxdart.dart';

import 'show_save_point_event.dart';
import 'show_save_point_state.dart';

class ShowSavePointBloc extends Bloc<IShowSavePointEvent,ShowSavePointState>{

  final BehaviorSubject<SavePointType?> _filterController = BehaviorSubject();

  late final SavePointUseCases _savePointUseCases;

  ShowSavePointBloc({required SavePointUseCases savePointUseCases})
      : super(ShowSavePointState.init()){

    _savePointUseCases = savePointUseCases;

    on<ShowSavePointEventLoadData>(_onLoadData,transformer: restartable());
    on<ShowSavePointEventChangeMenuItem>(_onChangeMenuItem,transformer: restartable());
    on<ShowSavePointEventRename>(_onRename, transformer: restartable());
    on<ShowSavePointEventDelete>(_onDelete, transformer: restartable());
    on<ShowSavePointEventSelect>(_onSelect, transformer: restartable());
    on<ShowSavePointEventLoadAndGo>(_onLoadAndGo, transformer: restartable());

  }

  void _onLoadData(ShowSavePointEventLoadData event,Emitter<ShowSavePointState>emit)async{
    _filterController.add(event.filter);

    final streamData = _filterController.switchMap((SavePointType? filter)=>
        _savePointUseCases.getSavePoints(scopes: event.scopes, type: filter)
    );

    await emit.forEach<List<SavePoint>>(streamData, onData: (data)=>
        state.copyWith(savePoints: data)
    );

  }

  void _onChangeMenuItem(ShowSavePointEventChangeMenuItem event,Emitter<ShowSavePointState>emit)async{
    _filterController.add(event.savePointType);
    emit(state.copyWith(selectedMenuItem: event.savePointType));
  }



  void _onDelete(ShowSavePointEventDelete event,Emitter<ShowSavePointState>emit)async{
    await _savePointUseCases.deleteSavePoint.call(event.savePoint);
  }

  void _onRename(ShowSavePointEventRename event,Emitter<ShowSavePointState>emit)async{
    await _savePointUseCases.updateSavePoint(event.savePoint.copyWith(title: event.newTitle));
  }

  void _onSelect(ShowSavePointEventSelect event,Emitter<ShowSavePointState>emit)async{
    emit(state.copyWith(selectedSavePoint: event.savePoint,setSavePoint: true));
  }

  void _onLoadAndGo(ShowSavePointEventLoadAndGo event,Emitter<ShowSavePointState>emit)async{
    final selectedSavePoint = state.selectedSavePoint;
    if(selectedSavePoint == null) return;

    selectedSavePoint.destination.getType() == SavePointType.topic;


  }


  @override
  Future<void> close() async{
    await _filterController.close();
    return super.close();
  }

}
