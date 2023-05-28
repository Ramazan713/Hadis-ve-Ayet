import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/data/local/mapper/save_point_mapper.dart';
import 'package:hadith/core/data/local/services/save_point_dao.dart';
import 'package:hadith/core/domain/enums/save_point/local_destination_scope.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/core/domain/use_cases/save_point/save_point_use_cases.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';
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
    on<EditSavePointEventRename>(_onRename);
    on<EditSavePointEventDelete>(_onDelete);
    on<EditSavePointEventClearMessage>(_onClearMessage);
    on<EditSavePointEventSelect>(_onSelect);
    on<EditSavePointEventInsert>(_onInsert);
    on<EditSavePointEventOverride>(_onOverride);

  }


  void _onLoadData(EditSavePointEventLoadData event,Emitter<EditSavePointState>emit)async{


    if(state.savePoints.isNotEmpty){
      emit(state.copyWith(
          selectedSavePoint: state.savePoints.firstWhereOrNull((element) => element.id == event.selectedSavePointId),
          setSavePoint: true
      ));
    }
    _scopeFilter.add(state.localScope);
    emit(state.copyWith(destination: event.destination,position: event.position));

    final currentBookScope = event.destination.getBookScope();

    final streamData = _scopeFilter.stream.switchMap((localScope) {
      if(localScope == LocalDestinationScope.wide){
        return _savePointUseCases.getSavePoints.call(scopes: [currentBookScope]);
      }
      //restrict scope
      return _savePointUseCases.getSavePoints.call(scopes: [currentBookScope],type: event.destination.getType());
    });

    await emit.forEach<List<SavePoint>>(streamData, onData: (data) =>
        state.copyWith(savePoints: data)
    );
  }

  void _onDelete(EditSavePointEventDelete event,Emitter<EditSavePointState>emit)async{
    await _savePointUseCases.deleteSavePoint.call(event.savePoint);
  }

  void _onInsert(EditSavePointEventInsert event,Emitter<EditSavePointState>emit)async{
    await _savePointUseCases.insertSavePoint.call(
        destination: state.destination,
        position: state.position,
        title: event.title,
        dateTime: event.dateTime,
    );
  }

  void _onRename(EditSavePointEventRename event,Emitter<EditSavePointState>emit)async{
    await _savePointUseCases.updateSavePoint.call(event.savePoint.copyWith(title: event.newTitle));
  }

  void _onSelect(EditSavePointEventSelect event,Emitter<EditSavePointState>emit)async{
    emit(state.copyWith(selectedSavePoint: event.savePoint,setSavePoint: true));
  }

  void _onOverride(EditSavePointEventOverride event,Emitter<EditSavePointState>emit)async{
    final updatedSavePoint = event.selectedSavePoint.copyWith(
      itemIndexPos: state.position,
      destination: state.destination
    );
    await _savePointUseCases.updateSavePoint.call(updatedSavePoint);
  }

  void _onChangeDestinationScope(EditSavePointEventChangeDestinationScope event,Emitter<EditSavePointState>emit)async{
    _scopeFilter.add(event.scope);
    emit(state.copyWith(localScope: event.scope));
  }

  void _onClearMessage(EditSavePointEventClearMessage event,Emitter<EditSavePointState>emit)async{
    emit(state.copyWith(setMessage: true));
  }


  @override
  Future<void> close() async{
    await _scopeFilter.close();
    return super.close();
  }
}
