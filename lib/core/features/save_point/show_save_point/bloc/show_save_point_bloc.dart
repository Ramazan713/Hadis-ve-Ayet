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

    on<ShowSavePointEventLoadBookData>(_onLoadBookData,transformer: restartable());
    on<ShowSavePointEventLoadTypeData>(_onLoadTypeData,transformer: restartable());
    on<ShowSavePointEventChangeMenuItem>(_onChangeMenuItem,transformer: restartable());
    on<ShowSavePointEventRename>(_onRename, transformer: restartable());
    on<ShowSavePointEventDelete>(_onDelete, transformer: restartable());
    on<ShowSavePointEventSelect>(_onSelect, transformer: restartable());
    on<ShowSavePointEventClearMessage>(_onClearMessage, transformer: restartable());

  }

  void _onLoadBookData(ShowSavePointEventLoadBookData event,Emitter<ShowSavePointState>emit)async{
    _filterController.add(event.filter);
    emit(state.copyWith(setSelectedMenuItem: true, setSavePoint: true));

    final streamData = _filterController.switchMap((SavePointType? filter)=>
        _savePointUseCases.getSavePoints.callBook(scopes: event.scopes, type: filter)
    );
    await emit.forEach<List<SavePoint>>(streamData, onData: (data)=>
        state.copyWith(savePoints: data)
    );
  }

  void _onLoadTypeData(ShowSavePointEventLoadTypeData event,Emitter<ShowSavePointState>emit)async{

    emit(state.copyWith(setSelectedMenuItem: true, setSavePoint: true));

    final streamData = _savePointUseCases.getSavePoints.callType(
      bookScope: event.scope,
      type: event.savePointType
    );

    await emit.forEach<List<SavePoint>>(streamData, onData: (data)=>
        state.copyWith(savePoints: data)
    );
  }

  void _onChangeMenuItem(ShowSavePointEventChangeMenuItem event,Emitter<ShowSavePointState>emit)async{
    _filterController.add(event.savePointType);
    emit(state.copyWith(selectedMenuItem: event.savePointType,setSelectedMenuItem: true));
  }



  void _onDelete(ShowSavePointEventDelete event,Emitter<ShowSavePointState>emit)async{
    await _savePointUseCases.deleteSavePoint.call(event.savePoint);
    emit(state.copyWith(
        setMessage: true,
        message: "Silindi"
    ));
  }

  void _onRename(ShowSavePointEventRename event,Emitter<ShowSavePointState>emit)async{
    await _savePointUseCases.updateSavePoint(event.savePoint.copyWith(title: event.newTitle));
    emit(state.copyWith(
      setMessage: true,
      message: "Yeniden İsimlendirildi"
    ));
  }

  void _onSelect(ShowSavePointEventSelect event,Emitter<ShowSavePointState>emit)async{
    emit(state.copyWith(selectedSavePoint: event.savePoint,setSavePoint: true));
  }

  void _onClearMessage(ShowSavePointEventClearMessage event,Emitter<ShowSavePointState>emit)async{
    emit(state.copyWith(setMessage: true));
  }

  @override
  Future<void> close() async{
    await _filterController.close();
    return super.close();
  }

}
