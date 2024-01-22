import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/services/save_point_dao.dart';
import 'package:hadith/core/features/save_point/domain/enums/local_destination_scope.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/save_point_use_cases.dart';
import 'package:rxdart/rxdart.dart';

import 'edit_save_point_event.dart';
import 'edit_save_point_state.dart';

class EditSavePointBloc extends Bloc<IEditSavePointEvent,EditSavePointState>{

  final BehaviorSubject<LocalDestinationScope> _scopeFilter = BehaviorSubject();

  late final SavePointUseCases _savePointUseCases;
  SavePointDao savePointDao;

  EditSavePointBloc({required SavePointUseCases savePointUseCases,required this.savePointDao})
      : super(EditSavePointState.init()){

    _savePointUseCases = savePointUseCases;

    on<EditSavePointEventLoadData>(_onLoadData,transformer: restartable());
    on<EditSavePointEventChangeDestinationScope>(_onChangeDestinationScope,transformer: restartable());
    on<EditSavePointEventRename>(_onRename, transformer: restartable());
    on<EditSavePointEventDelete>(_onDelete, transformer: restartable());
    on<EditSavePointEventClearMessage>(_onClearMessage, transformer: restartable());
    on<EditSavePointEventSelect>(_onSelect, transformer: restartable());
    on<EditSavePointEventInsert>(_onInsert, transformer: restartable());
    on<EditSavePointEventOverride>(_onOverride, transformer: restartable());

    on<EditSavePointEventAutoInsert>(_onAutoInsert, transformer: restartable());

  }


  void _onLoadData(EditSavePointEventLoadData event,Emitter<EditSavePointState>emit)async{

      _scopeFilter.add(event.scope ?? state.localScope);
      emit(state.copyWith(
          destination: event.destination,
          position: event.position,
          localScope: event.scope,
          setSelectedSavePointId: true,
          selectedSavePointId: event.selectedSavePointId
      ));

      final destination = event.destination;

      final streamData = _scopeFilter.stream.switchMap((localScope) {
        if(localScope == LocalDestinationScope.wide){
          return _savePointUseCases.getSavePoints.callType(bookScope: null, type: destination.getType());
        }
        //restrict scope
        return _savePointUseCases.getSavePoints.callParentKey(type: destination.getType(), parentKey: destination.getParentKey());
      });

      await emit.forEach<List<SavePoint>>(streamData, onData: (data){
        return state.copyWith(savePoints: data);
      }
    );
  }

  void _onDelete(EditSavePointEventDelete event,Emitter<EditSavePointState>emit)async{
    await _savePointUseCases.deleteSavePoint.call(event.savePoint);
    emit(state.copyWith(
        setMessage: true,
        message: "Silindi"
    ));
  }

  void _onInsert(EditSavePointEventInsert event,Emitter<EditSavePointState>emit)async{
    await _savePointUseCases.insertSavePoint.call(
        destination: state.destination,
        position: state.position,
        title: event.title,
        dateTime: event.dateTime,
    );
    emit(state.copyWith(
        setMessage: true,
        message: "Yeni Kayıt Oluşturuldu"
    ));
  }

  void _onRename(EditSavePointEventRename event,Emitter<EditSavePointState>emit)async{
    await _savePointUseCases.updateSavePoint.call(event.savePoint.copyWith(title: event.newTitle));
    emit(state.copyWith(
        setMessage: true,
        message: "Yeniden İsimlendirildi"
    ));
  }

  void _onSelect(EditSavePointEventSelect event,Emitter<EditSavePointState>emit)async{
    emit(state.copyWith(
      selectedSavePointId: event.savePoint?.id,
      setSelectedSavePointId: true
    ));
  }

  void _onOverride(EditSavePointEventOverride event,Emitter<EditSavePointState>emit)async{
    final updatedSavePoint = event.selectedSavePoint.copyWith(
      itemIndexPos: state.position,
      destination: state.destination
    );
    await _savePointUseCases.updateSavePoint.call(updatedSavePoint);
    emit(state.copyWith(
        setMessage: true,
        message: "Üzerine Yazıldı"
    ));
  }

  void _onChangeDestinationScope(EditSavePointEventChangeDestinationScope event,Emitter<EditSavePointState>emit)async{
    _scopeFilter.add(event.scope);
    emit(state.copyWith(localScope: event.scope));
  }

  void _onClearMessage(EditSavePointEventClearMessage event,Emitter<EditSavePointState>emit)async{
    emit(state.copyWith(setMessage: true));
  }

  void _onAutoInsert(EditSavePointEventAutoInsert event,Emitter<EditSavePointState>emit)async{

    await _savePointUseCases.insertOrUpdateSavePoint.call(
        destination: event.destination,
        itemIndexPos: event.itemIndexPos,
        autoType: event.autoType,
    );
  }


  @override
  Future<void> close() async{
    await _scopeFilter.close();
    return super.close();
  }
}
