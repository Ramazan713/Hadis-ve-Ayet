import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/db/repos/save_point_repo.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_event.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_state.dart';

class SavePointBloc extends Bloc<ISavePointEvent,SavePointState>{
  final SavePointRepoOld savePointRepo;
  SavePointBloc({required this.savePointRepo})
      : super(const SavePointState(status: DataStatus.initial,savePoint: null)){
    on<SavePointEventRequest>(_onSavePointRequest,transformer: restartable());
    on<SavePointEventRequestWithId>(_onRequestWithId,transformer: restartable());
    on<SavePointEventAutoInsert>(_onSavePointAutoInsert,transformer: restartable());
    on<SavePointEventRename>(_onRename);
    on<SavePointEventDelete>(_onDelete);

  }

  void _onSavePointRequest(SavePointEventRequest event,Emitter<SavePointState>emit)async{
    emit(state.copyWith(status: DataStatus.loading));
    final data=await savePointRepo.loadSavePoint(event.savePointArg, event.originTag);
    emit(state.copyWith(status: DataStatus.success,savePoint: data,setSavePoint: true));

  }

  void _onRequestWithId(SavePointEventRequestWithId event,Emitter<SavePointState>emit)async{
    emit(state.copyWith(status: DataStatus.loading));
    final data=await savePointRepo.loadSavePointWithId(event.savePointId);
    emit(state.copyWith(status: DataStatus.success,savePoint: data,setSavePoint: true));
  }


  void _onSavePointAutoInsert(SavePointEventAutoInsert event,Emitter<SavePointState>emit)async{
    await savePointRepo.saveOrReplaceAutoSavePoint(event.savePointParam, SaveAutoType.general);
  }

  void _onDelete(SavePointEventDelete event,Emitter<SavePointState>emit)async{
    await savePointRepo.deleteSavePoint(event.savePoint);
  }

  void _onRename(SavePointEventRename event,Emitter<SavePointState>emit)async{
    await savePointRepo.updateSavePoint(event.savePoint.copyWith(title: event.newTitle));
  }

}
