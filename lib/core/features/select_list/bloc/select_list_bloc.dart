

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';
import 'package:hadith/core/domain/use_cases/list/list_use_cases.dart';
import 'package:hadith/core/domain/use_cases/select_list/select_list_use_cases.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'select_list_event.dart';
import 'select_list_state.dart';

class SelectListBloc extends Bloc<ISelectListEvent,SelectListState>{

  late final SelectListUseCases _selectListUseCases;
  late final ListUseCases _listUseCases;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  SelectListBloc({
    required SelectListUseCases selectListUseCases,
    required ListUseCases listUseCases
  }): super(SelectListState.init()){

    _selectListUseCases = selectListUseCases;
    _listUseCases = listUseCases;

    on<SelectListEventLoadData>(_onLoadData, transformer: restartable());
    on<SelectListEventInsertOrDelete>(_onInsertOrDelete, transformer: restartable());
    on<SelectListEventInsertNewList>(_onInsertNewList, transformer: restartable());
    on<SelectListEventClearMessage>(_onClearMessage, transformer: restartable());
  }


  void _onLoadData(SelectListEventLoadData event, Emitter<SelectListState> emit) async{
    final useArchiveListAsList = _sharedPreferences.getBool(PrefConstants.useArchiveListFeatures.key) ??
        PrefConstants.useArchiveListFeatures.defaultValue;
    emit(state.copyWith(
        itemId: event.itemId,
        sourceType: event.sourceType,
        listIdControl: event.listIdControl, setListIdControl: true
    ));
    final streamData = _selectListUseCases.getSelectableListView.call(
        itemId: event.itemId,
        sourceType: event.sourceType,
        includeArchiveLists: useArchiveListAsList
    );
    await emit.forEach<List<SelectableListViewModel>>(streamData, onData: (data){
      return state.copyWith(items: data);
    });

  }

  void _onInsertOrDelete(SelectListEventInsertOrDelete event, Emitter<SelectListState> emit) async{
    await _selectListUseCases.addList.call(listViewModel: event.item.listViewModel, itemId: state.itemId);
  }

  void _onInsertNewList(SelectListEventInsertNewList event, Emitter<SelectListState> emit) async{
    await _listUseCases.insertList.call(event.listName, state.sourceType);
    emit(state.copyWith(message: "Başarılı",setMessage: true));
  }

  void _onClearMessage(SelectListEventClearMessage event, Emitter<SelectListState> emit){
    emit(state.copyWith(setMessage: true));
  }
}