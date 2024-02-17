import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/use_cases/list/list_use_cases.dart';

import 'archive_list_event.dart';
import 'archive_list_state.dart';

class ArchiveListBloc extends Bloc<IArchiveListEvent,ArchiveListState>{

  late final ListUseCases _listUseCases;

  ArchiveListBloc({required ListUseCases listUseCases}): super(ArchiveListState.init()){
    _listUseCases = listUseCases;

    on<ArchiveListEventListenListModels>(_onListenListModels, transformer: restartable());
    on<ArchiveListEventRename>(_onRename, transformer: restartable());
    on<ArchiveListEventRemove>(_onRemove, transformer: restartable());
    on<ArchiveListEventUnArchive>(_onUnArchive, transformer: restartable());
    on<ArchiveListEventClearMessage>(_onClearMessage, transformer: restartable());
    on<ArchiveListEventHideDetail>(_onHideDetail, transformer: restartable());
    on<ArchiveListEventShowDetail>(_onShowDetail, transformer: restartable());
    on<ArchiveListEventLoadData>(_onLoadData, transformer: restartable());
    on<ArchiveEventClearJumpToPos>(_onClearJumpToPos, transformer: restartable());

    add(ArchiveListEventListenListModels());
  }

  var _isCheckedForInitSelectedItem = false;
  int? selectedInitId;

  void _onLoadData(ArchiveListEventLoadData event, Emitter<ArchiveListState>emit){
    final items = state.listModels;
    _isCheckedForInitSelectedItem = false;
    selectedInitId = event.selectedListId;
    if(items.isNotEmpty){
      final (selectedItem, jumpToPos) = checkInitSelectedItem(items);
      emit(state.copyWith(selectedItem: null));
      emit(state.copyWith(selectedItem: selectedItem, isDetailOpen: selectedItem != null, jumpToPos: jumpToPos));
    }
  }

  void _onHideDetail(ArchiveListEventHideDetail event, Emitter<ArchiveListState>emit){
    emit(state.copyWith(selectedItem: null, isDetailOpen: false));
  }

  void _onClearJumpToPos(ArchiveEventClearJumpToPos event, Emitter<ArchiveListState>emit){
    emit(state.copyWith(jumpToPos: null));
  }

  void _onShowDetail(ArchiveListEventShowDetail event, Emitter<ArchiveListState>emit){
    emit(state.copyWith(selectedItem: event.item, isDetailOpen: true));
  }

  void _onRename(ArchiveListEventRename event, Emitter<ArchiveListState>emit)async{
    await _listUseCases.updateList.call(listViewModel: event.listViewModel,name: event.newTitle);
    _sendMessage("Başarılı", emit);
  }

  void _onRemove(ArchiveListEventRemove event, Emitter<ArchiveListState>emit)async{
    final listView = event.listViewModel;
    if(!listView.isRemovable)return;
    await _listUseCases.deleteList.call(listView);
    _sendMessage("Silindi", emit);
  }

  void _onUnArchive(ArchiveListEventUnArchive event, Emitter<ArchiveListState>emit)async{
    final listView = event.listViewModel;
    if(!listView.isArchive) return;
    await _listUseCases.updateList.call(listViewModel: listView,isArchive: false);
    _sendMessage("Arşivden Çıkarıldı", emit);
  }

  void _onClearMessage(ArchiveListEventClearMessage event, Emitter<ArchiveListState>emit)async{
    emit(state.copyWith(message: null));
  }

  void _sendMessage(String message,Emitter<ArchiveListState>emit){
    emit(state.copyWith(message: message));
  }

  void _onListenListModels(ArchiveListEventListenListModels event, Emitter<ArchiveListState>emit)async{

    final streamData = _listUseCases.getLists.callRemovableWithArchive(true);

    await emit.forEach<List<ListViewModel>>(streamData, onData: (listViews){
      final (initSelectedItem, jumpToPos) = checkInitSelectedItem(listViews);
      final isDetailOpen = initSelectedItem != null ? true : state.isDetailOpen;
      final currentSelectedItem = initSelectedItem ?? (state.selectedItem ?? listViews.firstOrNull);
      return state.copyWith(listModels: listViews, selectedItem: currentSelectedItem, isDetailOpen: isDetailOpen, jumpToPos: jumpToPos);
    });
  }

  (ListViewModel?,int?) checkInitSelectedItem(List<ListViewModel> listViews){
    if(_isCheckedForInitSelectedItem || selectedInitId == null) return (null,null);
    final index = listViews.indexWhere((e) => e.id == selectedInitId);
    if(index == -1 ) return (null,null);
    _isCheckedForInitSelectedItem = true;
    return (listViews[index], index);
  }
}