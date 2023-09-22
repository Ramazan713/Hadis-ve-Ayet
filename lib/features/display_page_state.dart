import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/data_paging_status_enum.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/constants/menu_resources.dart';
import 'package:hadith/features/save_point/constants/save_point_constant.dart';
import 'package:hadith/db/entities/list_entity.dart';
import 'package:hadith/features/paging/bloc/paging_state.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_state.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/models/save_point_argument.dart';
import 'package:hadith/core/utils/ad_util.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/add_to_list/model/edit_select_list_model.dart';
import 'package:hadith/features/add_to_list/model/i_select_list_loader.dart';
import 'package:hadith/features/add_to_list/show_select_list_bottom_dia.dart';
import 'package:hadith/features/paging/i_paging_loader.dart';
import 'package:hadith/features/paging/mixin/list_mixin.dart';
import 'package:hadith/features/paging/paging_argument.dart';
import 'package:hadith/features/paging/paging_loader_factory.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_bloc.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_event.dart';
import 'package:hadith/menus/menu_display_item.dart';
import 'package:hadith/models/i_add_list_common.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/features/paging/controller/custom_scrolling_controller.dart';
import 'package:hadith/features/paging/default_paging_argument.dart';
import '../utils/search_helper.dart';
import 'add_to_list/bloc/list_bloc.dart';
import 'add_to_list/bloc/list_event.dart';
import 'app/ads/ad_check_widget.dart';

abstract class DisplayPageState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver{

  var itemCount = 0;
  var lastIndex = 0;
  final ValueNotifier<bool>changeBarTitleNotifier=ValueNotifier(true);
  final CustomScrollingController customPagingController = CustomScrollingController();
  late ListBloc listBloc;
  final int limitCount = kPagingLimitCount;
  String? cleanableSearchText;
  final rebuildItemNotifier=ValueNotifier(false);
  PagingArgument pagingArgument=DefaultPagingArgument();
  SearchCriteriaEnum searchCriteriaEnum=SearchCriteriaEnum.inOneExpression;

  final ScrollController nestedViewScrollController = ScrollController();
  bool lastIsScrollUp=true;
  bool lastIsPrevSuccessScroll=false;
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    listBloc = context.read<ListBloc>();

    pagingArgument =
        (ModalRoute.of(context)?.settings.arguments as PagingArgument?) ??
            DefaultPagingArgument();
    cleanableSearchText = pagingArgument.searchKey;

    loadSavePoint(context);
    loadSearchCriteria(pagingArgument.searchKey);
    
    return AdCheckWidget(child: buildPage(context));
  }


  void checkAppBarVisibilityForTop(int minPos){
    if(minPos==0&&!lastIsScrollUp){
      lastIsScrollUp=true;
      nestedViewScrollController.animateTo(
        nestedViewScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void appBarVisibility(bool isScrollUp,CustomPagingState? state){

    //this if else-if block provides to prohibit appbar which scrolling up to collapse
    // because of state.pagingSuccess
    //if state.pagingSuccess occurred first time,it will prohibit to collapse bar else do whatever
    if(!isScrollUp&&!lastIsPrevSuccessScroll&&state?.status==DataPagingStatus.prevPagingSuccess){
      lastIsPrevSuccessScroll=true;
    }else if(lastIsPrevSuccessScroll){
      lastIsPrevSuccessScroll=false;
    }

    if(!lastIsPrevSuccessScroll&&lastIsScrollUp!=isScrollUp){
      lastIsScrollUp=isScrollUp;

      if (isScrollUp) {//expend
        nestedViewScrollController.animateTo(
          nestedViewScrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {//collapse
        nestedViewScrollController.animateTo(
            nestedViewScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn);
      }
    }

  }

  void loadSearchCriteria(String? searchKey)async{
    if(searchKey!=null){
      searchCriteriaEnum = SearchHelper.getCriteria();
      rebuildItemNotifier.value=!rebuildItemNotifier.value;
    }
  }

  PagingArgument getArgument();

  void setArgument(PagingArgument newArgument);

  IPagingLoader getLoader();


  void setArgumentWithSavePoint(SavePoint savePoint){
    final label=savePoint.parentName;
    var loader=PagingLoaderFactory.getLoaderWithBookBinaryId(
        savePoint.bookScope, savePoint.savePointType, savePoint.parentKey, context);

    setArgument(PagingArgument(originTag:savePoint.savePointType,
        savePointArg: SavePointLoadArg(id: savePoint.id,parentKey: savePoint.parentKey),
        bookScope: savePoint.bookScope,
        searchKey: getArgument().searchKey,
        loader: loader,title:label));

    customPagingController.setLoader(loader);
    customPagingController.setPageEventWhenReady(limitNumber: limitCount,itemIndex: savePoint.itemIndexPos);
    changeBarTitleNotifier.value=!changeBarTitleNotifier.value;
  }

  void loadSavePoint(BuildContext context){
    final argument=getArgument();
    final savePointArg=argument.savePointArg;
    final savePointBloc=context.read<SavePointBloc>();
    savePointBloc.add(SavePointEventRequest(savePointArg: savePointArg, originTag: argument.originTag));
  }

  void _saveAuto(){
    final argument=getArgument();
    if(kAutoSavePointOrigins.contains(argument.originTag)){
      context.read<SavePointBloc>().add(SavePointEventAutoInsert(
          savePointParam: SavePointParam.fromPagingArgument(argument, lastIndex),));
    }
  }

  List<MenuModel<int>>getPopUpMenus(){
    final List<MenuModel<int>> items=[];
    if(cleanableSearchText!=null){
      items.add(MenuModel(label: "Vurgu Temizle",iconData: Icons.clear_all,value: MenuResources.cleanSearchText),);
    }
    items.addAll(getDisplayItemsMenu());
    return items;
  }

  void reloadPagingItems(int rowNumber){
    customPagingController.setPageEvent(
        limitNumber: limitCount,
        itemIndex: rowNumber - 1,
        reloadItemCount: true);
  }

  void rebuildItems(){
    rebuildItemNotifier.value=!rebuildItemNotifier.value;
  }


  void addFavoriteList(ListBloc listBloc,IAddListCommon listCommon,int listId){
    listCommon.isFavorite=true;
    listBloc.add(ListEventAddToList(listId: listId));
  }

  void removeFavoriteList(ListBloc listBloc,IAddListCommon listCommon,int listId){
    listBloc.add(ListEventRemoveToList(listId: listId));
    listCommon.isFavorite=false;
  }

  void addOrRemoveFavoriteList(EditSelectListModel listParam,ListBloc listBloc, bool isFavorite,{void Function()? reloadPagingListener}){

    if (listParam.loader is ListMixinLoader && listParam.favoriteListId
        ==(listParam.loader as ListMixinLoader).listId) {
      if(!isFavorite){
        showCustomAlertBottomDia(context,title: "Favori listesinden kaldırmak istediğinize emin misiniz?",
            content: "Bulunduğunuz listeyi etkileyecektir",btnApproved: (){
              removeFavoriteList(listBloc,listParam.listCommon,listParam.favoriteListId);
              reloadPagingItems(listParam.listCommon.rowNumber);
              reloadPagingListener?.call();
            });
      }else{
        addFavoriteList(listBloc,listParam.listCommon,listParam.favoriteListId);
        listParam.updateArea.call();
      }
    }else{
      isFavorite?addFavoriteList(listBloc,listParam.listCommon,listParam.favoriteListId)
          :removeFavoriteList(listBloc,listParam.listCommon,listParam.favoriteListId);
      listParam.updateArea.call();
    }
  }

  void editSelectedLists(
      EditSelectListModel listParam, ISelectListLoader listLoader,bool rebuildWhenChange,
    {Function(List<ListEntityOld>)?changeListener}) {
    final bool isLoaderListPaging=listParam.loader is ListMixinLoader;
    final int? parentId=isLoaderListPaging?(listParam.loader as ListMixinLoader).listId:null;

    showSelectListBottomDia(context,
        listLoader: listLoader,parentListId: parentId,
        includeFavoriteList: false, anyChange: (isChange,selectedLists) {

          if(isChange){
            if (isLoaderListPaging&&listParam.favoriteListId!=parentId&&!selectedLists.map((e) => e.id).contains(parentId)) {
              reloadPagingItems(listParam.listCommon.rowNumber);
            }

            if(changeListener!=null){
              changeListener.call(selectedLists);
            }else{
              listParam.listCommon.isAddListNotEmpty=selectedLists.isNotEmpty;
            }

            if(rebuildWhenChange) {
              listParam.updateArea.call();
            }
          }
        });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state==AppLifecycleState.inactive){
      _saveAuto();
    }
  }

  @override
  void deactivate() {
    _saveAuto();
    super.deactivate();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}