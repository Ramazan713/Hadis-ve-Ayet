import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/use_cases/list/list_use_cases.dart';

import 'archive_list_event.dart';
import 'archive_list_state.dart';

class ArchiveListBloc extends Bloc<IArchiveListEvent,ArchiveListState>{

  late final ListUseCases _listUseCases;

  ArchiveListBloc({required ListUseCases listUseCases}): super(ArchiveListState.init()){
    _listUseCases = listUseCases;

    on<ArchiveListEventListenListModels>(_onListenListModels);
    on<ArchiveListEventRename>(_onRename);
    on<ArchiveListEventRemove>(_onRemove);
    on<ArchiveListEventUnArchive>(_onUnArchive);
    on<ArchiveListEventClearMessage>(_onClearMessage);
    on<ArchiveListEventHideDetail>(_onHideDetail);
    on<ArchiveListEventShowDetail>(_onShowDetail);

    add(ArchiveListEventListenListModels());
  }

  void _onHideDetail(ArchiveListEventHideDetail event, Emitter<ArchiveListState>emit){
    emit(state.copyWith(selectedItem: null, isDetailOpen: false));
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
      return state.copyWith(listModels: listViews, selectedItem: state.selectedItem ?? listViews.firstOrNull);
    });
  }
}