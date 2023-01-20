import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/save_point/constants/scope_filter_enum.dart';
import 'package:hadith/features/save_point/constants/save_point_constant.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/db/repos/save_point_repo.dart';
import 'package:hadith/features/save_point/bloc/save_point_edit_event.dart';
import 'package:hadith/features/save_point/bloc/save_point_edit_state.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:hadith/utils/save_point_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePointEditBloc extends Bloc<ISavePointEditEvent,SavePointEditState>{
  final SavePointRepo savePointRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  final BehaviorSubject<ScopeFilterEnum> _filterController = BehaviorSubject<ScopeFilterEnum>();

  SavePointEditBloc({required this.savePointRepo})
      : super(SavePointEditState.init()){

    on<SavePointEditEventInitialRequest>(_onSavePointRequest,transformer: restartable());
    on<SavePointEditEventInsert>(_onSavePointInsert,transformer: restartable());
    on<SavePointEditEventOverride>(_onSavePointOverride,transformer: restartable());
    on<SavePointEditEventChangeSavePoint>(_onChangeSavePoint,transformer: restartable());
    on<SavePointEditEventChangeScopeFilter>(_onChangeScopeFilter,transformer: restartable());

  }

  void _addMessage(String message,Emitter<SavePointEditState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }


  void _onSavePointRequest(SavePointEditEventInitialRequest event,Emitter<SavePointEditState>emit)async{
    emit(state.copyWith(status: DataStatus.loading));
    final scopeFilter = ScopeFilterEnum.values[_sharedPreferences.getInt(PrefConstants.scopeFilterEnum.key) ?? 0];
    _filterController.add(scopeFilter);
    emit(state.copyWith(scopeFilter: scopeFilter,setScopeFilter: true));

    final originTag = event.savePointParam.originTag;

    final wideSavePointScope=kSavePointScopeOrigins.contains(originTag);
    final isScopeOrigin = SavePointHelper.isScopeOrigin(originTag);

    final Stream<List<SavePoint>> rawStreamData = wideSavePointScope ?
      savePointRepo.getStreamSavePointsWithBookIdBinary(originTag.savePointId, event.savePointParam.bookScope) :
      savePointRepo.getStreamSavePoints(originTag, event.savePointParam.parentKey);

    final filteredStreamData = Rx.combineLatest2<ScopeFilterEnum,List<SavePoint>,List<SavePoint>>(_filterController.stream, rawStreamData, (ScopeFilterEnum filter,List<SavePoint> items) {
      if(!isScopeOrigin || filter == ScopeFilterEnum.scope)return items;
      return items.where((element) => element.parentKey == event.savePointParam.parentKey).toList();
    });
    await emit.forEach<List<SavePoint>>(filteredStreamData, onData: (data)=>state.copyWith(status: DataStatus.success,
        savePoints: data));
  }

  void _onSavePointInsert(SavePointEditEventInsert event,Emitter<SavePointEditState>emit)async{
    final savePoint = event.savePointParam.toSavePoint(event.title, SaveAutoType.none,event.dateTime.toIso8601String());
    await savePointRepo.insertSavePoint(savePoint);
  }

  void _onSavePointOverride(SavePointEditEventOverride event,Emitter<SavePointEditState>emit)async{
    final param = event.savePointParam;

    final newSavePoint = event.selectedSavePoint.copyWith(
      modifiedDate: DateTime.now().toIso8601String(),
      itemIndexPos: param.itemIndexPos,
      parentKey: param.parentKey,
      parentName: param.parentName,
    );
    await savePointRepo.updateSavePoint(newSavePoint);
    _addMessage("Üzerine Yazıldı",emit);
  }

  void _onChangeSavePoint(SavePointEditEventChangeSavePoint event,Emitter<SavePointEditState>emit){
    emit(state.copyWith(selectedSavePoint: event.savePoint,setSelectedSavePoint: true));
  }

  void _onChangeScopeFilter(SavePointEditEventChangeScopeFilter event,Emitter<SavePointEditState>emit){
    _filterController.add(event.scopeFilter);
    emit(state.copyWith(scopeFilter: event.scopeFilter,setScopeFilter: true));
    _sharedPreferences.setInt(PrefConstants.scopeFilterEnum.key, event.scopeFilter.index);
  }

  @override
  Future<void> close() async{
    await _filterController.close();
    return super.close();
  }


}

