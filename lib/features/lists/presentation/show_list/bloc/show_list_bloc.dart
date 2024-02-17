
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
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
    
    on<ShowListEventChangeTab>(_onShowListEventChangeTab, transformer: restartable());
    on<ShowListEventSetVisibilitySearchBar>(_onShowListEventSetVisibilitySearchBar, transformer: restartable());
    on<ShowListEventListenListHadiths>(_onListenListHadiths, transformer: restartable());
    on<ShowListEventListenListVerses>(_onListenListVerses, transformer: restartable());
    on<ShowListEventSearch>(_onShowListEventSearch, transformer: restartable());
    on<ShowListEventAddNewList>(_onAddNewList, transformer: restartable());
    on<ShowListEventRename>(_onRename, transformer: restartable());
    on<ShowListEventRemove>(_onRemove, transformer: restartable());
    on<ShowListEventRemoveItems>(_onRemoveItems, transformer: restartable());
    on<ShowListEventArchive>(_onArchive, transformer: restartable());
    on<ShowListEventCopy>(_onCopy, transformer: restartable());
    on<ShowListEventClearMessage>(_onClearMessage, transformer: restartable());
    on<ShowListEventHideDetail>(_onHideDetail, transformer: restartable());
    on<ShowListEventShowDetail>(_onShowDetail, transformer: restartable());
    on<ShowListEventSetSelected>(_onSetSelected, transformer: restartable());
    on<ShowListEventLoadData>(_onLoadData, transformer: restartable());
    on<ShowListEventClearJumpToPos>(_onClearJumpToPos, transformer: restartable());


    _queryFilter.value = "";
    add(ShowListEventListenListHadiths());
    add(ShowListEventListenListVerses());
  }

  var _isCheckedForInitSelectedItem = false;
  int? selectedInitId;

  void _onLoadData(ShowListEventLoadData event, Emitter<ShowListState>emit){
    final verseItems = state.listVerses;
    final hadithItems = state.listHadiths;
    _isCheckedForInitSelectedItem = false;
    selectedInitId = event.selectedListId;
    if(verseItems.isNotEmpty && hadithItems.isNotEmpty){
      var initState = checkInitSelectedItemState(state,verseItems);
      initState = checkInitSelectedItemState(initState, hadithItems);
      emit(initState.copyWith(selectedItem: null));
      emit(initState);
    }
  }

  void _onClearJumpToPos(ShowListEventClearJumpToPos event, Emitter<ShowListState>emit){
    emit(state.copyWith(jumpToPos: null));
  }

  void _onShowListEventChangeTab(ShowListEventChangeTab event, Emitter<ShowListState>emit){
    emit(state.copyWith(currentTab: ListTabEnumExt.fromIndex(event.index)));
  }

  void _onHideDetail(ShowListEventHideDetail event, Emitter<ShowListState>emit){
    emit(state.copyWith(selectedItem: null, isDetailOpen: false));
  }

  void _onShowDetail(ShowListEventShowDetail event, Emitter<ShowListState>emit){
    emit(state.copyWith(selectedItem: event.item, isDetailOpen: true));
  }

  void _onSetSelected(ShowListEventSetSelected event, Emitter<ShowListState>emit){
    emit(state.copyWith(selectedItem: event.item));
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
      final initState = checkInitSelectedItemState(state.copyWith(listHadiths: listViews), listViews);
      return initState.copyWith(selectedItem: getDefaultSelectedItem(initState,ListTabEnum.hadith, listViews.firstOrNull));
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
      final initState = checkInitSelectedItemState(state.copyWith(listVerses: listViews),listViews);
      return initState.copyWith(selectedItem: getDefaultSelectedItem(initState, ListTabEnum.verse, listViews.firstOrNull));
    });
  }

  ShowListState checkInitSelectedItemState(ShowListState state,List<ListViewModel> listViews){
    if(_isCheckedForInitSelectedItem || selectedInitId == null) return state;
    final index = listViews.indexWhere((e) => e.id == selectedInitId);
    if(index == -1) return state;
    _isCheckedForInitSelectedItem = true;
    final selectedItem = listViews[index];

    return state.copyWith(
      jumpToPos: index,
      selectedItem: selectedItem,
      isDetailOpen: true,
      currentTab: selectedItem.sourceType.sourceId == SourceTypeEnum.verse.sourceId ? ListTabEnum.verse :
          ListTabEnum.hadith
    );
  }

  ListViewModel? getDefaultSelectedItem(ShowListState state, ListTabEnum listTabEnum, ListViewModel? candidate){
    return state.selectedItem ?? candidate;
  }

}