
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/use_cases/list/list_use_cases.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/features/lists/domain/list_tab_enum.dart';
import 'package:rxdart/rxdart.dart';

class ShowListBloc extends Bloc<IShowListEvent,ShowListState>{
  
  late final ListUseCases _listUseCases;

  final BehaviorSubject<String> _queryFilter = BehaviorSubject();
  
  ShowListBloc({required ListUseCases listUseCases}): super(ShowListState.init()){
    _listUseCases = listUseCases;
    
    on<ShowListEventChangeTab>(_onShowListEventChangeTab);
    on<ShowListEventSetVisibilitySearchBar>(_onShowListEventSetVisibilitySearchBar);
    on<ShowListEventListenListHadiths>(_onListenListHadiths);
    on<ShowListEventListenListVerses>(_onListenListVerses);
    on<ShowListEventSearch>(_onShowListEventSearch);
    on<ShowListEventAddNewList>(_onAddNewList);
    on<ShowListEventRename>(_onRename);
    on<ShowListEventRemove>(_onRemove);
    on<ShowListEventRemoveItems>(_onRemoveItems);
    on<ShowListEventArchive>(_onArchive);
    on<ShowListEventCopy>(_onCopy);
    on<ShowListEventClearMessage>(_onClearMessage);

    _queryFilter.value = "";
    add(ShowListEventListenListHadiths());
    add(ShowListEventListenListVerses());
  }

  void _onShowListEventChangeTab(ShowListEventChangeTab event, Emitter<ShowListState>emit){
    emit(state.copyWith(currentTab: ListTabEnumExt.fromIndex(event.index)));
  }

  void _onShowListEventSearch(ShowListEventSearch event, Emitter<ShowListState>emit){
    EasyDebounce.debounce("list_search", const Duration(milliseconds: K.searchDelaySearchMilliSecond), () {
      _queryFilter.add(event.query);
    });
  }


  void _onShowListEventSetVisibilitySearchBar(ShowListEventSetVisibilitySearchBar event, Emitter<ShowListState>emit){
    emit(state.copyWith(searchBarVisible: event.searchBarVisible));
  }

  void _onAddNewList(ShowListEventAddNewList event, Emitter<ShowListState>emit)async{
    final listName = event.listName;
    if(listName.trim().isEmpty)return;
    await _listUseCases.insertList.call(listName.trim(), state.currentTab.sourceType);
    _sendMessage("Liste Oluşturuldu", emit);
  }

  void _onRename(ShowListEventRename event, Emitter<ShowListState>emit)async{
    await _listUseCases.updateList.call(listViewModel: event.listViewModel,name: event.newTitle);
    _sendMessage("Başarılı", emit);
  }

  void _onRemove(ShowListEventRemove event, Emitter<ShowListState>emit)async{
    final listView = event.listViewModel;
    if(!listView.isRemovable)return;
    await _listUseCases.deleteList.call(listView);
    _sendMessage("Silindi", emit);
  }

  void _onCopy(ShowListEventCopy event, Emitter<ShowListState>emit)async{
    await _listUseCases.copyList.call(event.listViewModel);
    _sendMessage("Kopyası Oluşturuldu", emit);
  }

  void _onRemoveItems(ShowListEventRemoveItems event, Emitter<ShowListState>emit)async{
    final listView = event.listViewModel;
    if(listView.isRemovable)return;
    await _listUseCases.deleteItemsInList.call(event.listViewModel.id, state.currentTab.sourceType);
    _sendMessage("Silindi", emit);
  }

  void _onArchive(ShowListEventArchive event, Emitter<ShowListState>emit)async{
    final listView = event.listViewModel;
    if(listView.isArchive) return;
    await _listUseCases.updateList.call(listViewModel: listView,isArchive: true);
    _sendMessage("Arşivlendi", emit);
  }

  void _onClearMessage(ShowListEventClearMessage event, Emitter<ShowListState>emit)async{
    emit(state.copyWith(message: null));
  }

  void _sendMessage(String message,Emitter<ShowListState>emit){
    emit(state.copyWith(message: message));
  }

  void _onListenListHadiths(ShowListEventListenListHadiths event, Emitter<ShowListState>emit)async{
    
    final streamData = _queryFilter.distinct().switchMap((query){
      if(query.trim().isNotEmpty){
        return _listUseCases.searchLists(query, SourceTypeEnum.hadith, false);
      }
      return _listUseCases.getLists(SourceTypeEnum.hadith, false);
    });

    await emit.forEach<List<ListViewModel>>(streamData, onData: (listViews){
      return state.copyWith(listHadiths: listViews);
    });
  }

  void _onListenListVerses(ShowListEventListenListVerses event, Emitter<ShowListState>emit)async{
    final streamData = _queryFilter.switchMap((query){
      if(query.trim().isNotEmpty){
        return _listUseCases.searchLists(query, SourceTypeEnum.verse, false);
      }
      return _listUseCases.getLists(SourceTypeEnum.verse, false);
    });

    await emit.forEach<List<ListViewModel>>(streamData, onData: (listViews){
      return state.copyWith(listVerses: listViews);
    });
  }

}