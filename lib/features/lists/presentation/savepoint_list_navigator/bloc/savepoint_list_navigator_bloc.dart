

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/bloc/savepoint_list_navigator_event.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/bloc/savepoint_list_navigator_state.dart';

class SavePointListNavigatorBloc extends Bloc<ISavePointListNavigatorEvent,SavePointListNavigatorState>{

  late final ListRepo _listRepo;

  SavePointListNavigatorBloc({
    required ListRepo listRepo
  }): super(SavePointListNavigatorState.init()){

    _listRepo = listRepo;

    on<SavePointListNavigatorEventLoadData>(_onLoadData,transformer: restartable());
    on<SavePointListNavigatorEventClearNavigation>(_onClearNavigation,transformer: restartable());
  }


  void _onLoadData(SavePointListNavigatorEventLoadData event, Emitter<SavePointListNavigatorState> emit)async{
    final listModel = await _listRepo.getListById(event.listId);
    if(listModel == null){
      emit(state.copyWith(hasError: true));
      return;
    }

    emit(state.copyWith(
      navigateToList: listModel,
    ));
  }

  void _onClearNavigation(SavePointListNavigatorEventClearNavigation event, Emitter<SavePointListNavigatorState> emit){
    emit(state.copyWith(navigateToList: null, hasError: false));
  }

}