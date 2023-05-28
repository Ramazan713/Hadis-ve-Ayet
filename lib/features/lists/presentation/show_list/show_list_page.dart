import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/dialogs/edit_text_bottom_dia.dart';
import 'package:hadith/features/lists/presentation/components/list_item.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/features/lists/presentation/show_list/extensions/manage_bottom_menu_item.dart';
import 'package:hadith/features/lists/presentation/show_list/extensions/show_list_app_bar_ext.dart';
import 'package:hadith/features/lists/presentation/show_list/models/list_tab_enum.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/custom_animated_widget.dart';


class ShowListPage extends StatelessWidget {
  static String id = "ShowListPage";
  const ShowListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ShowListBloc>();

    return BlocListener<ShowListBloc, ShowListState>(
      listener: (context,state){
        if(state.message!=null){
          ToastUtils.showLongToast(state.message??"");
          listBloc.add(ShowListEventClearMessage());
        }
      },
      child: BlocSelector<ShowListBloc, ShowListState,bool>(
        selector: (state)=>state.searchBarVisible,
        builder: (context, searchBarVisible) {
          return WillPopScope(
            onWillPop: (){
              if(searchBarVisible){
                listBloc.add(ShowListEventSetVisibilitySearchBar(searchBarVisible: false));
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: DefaultTabController(
              length: 2,
              initialIndex: ListTabEnumExt.defaultTab.index,
              child: Scaffold(
                body: SafeArea(
                  child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {

                        listBloc.add(ShowListEventSetVisibilityFab(isVisible: !innerBoxIsScrolled));
                        return [
                          getSelectedAppBar()
                        ];
                      },
                      body: TabBarView(
                        children: [
                          BlocSelector<ShowListBloc,ShowListState,List<ListViewModel>>(
                              selector: (state)=>state.listHadiths,
                              builder: (context,listHadiths){
                                return getListItems(listHadiths, SourceTypeEnum.hadith);
                              },
                          ),
                          BlocSelector<ShowListBloc,ShowListState,List<ListViewModel>>(
                            selector: (state)=>state.listVerses,
                            builder: (context,listVerses){
                              return getListItems(listVerses, SourceTypeEnum.verse);
                            },
                          ),
                        ],
                      )),
                ),
                floatingActionButton: getFab(),
              ),

            ),
          );
        },
      ),
    );
  }


  Widget getListItems(List<ListViewModel>items,SourceTypeEnum sourceType){

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context,index){
        var item = items[index];
        return ListItem(
            subTitleTag: sourceType.shortName,
            listViewModel: item,
            icon: sourceType.getListIcon(context, item.isRemovable),
            onClick: (){

            },
            onMenuClick: (){
              showAndManageBottomMenu(context,item,sourceType);
            },
        );
      },
    );

  }


  Widget getFab(){
    return BlocSelector<ShowListBloc,ShowListState,bool>(
        selector: (state)=>state.fabVisible,
        builder: (context,isVisible){
          return CustomAnimatedWidget(
            isVisible: isVisible,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: (){
                showEditTextBottomDia(context, (text) {
                  context.read<ShowListBloc>()
                      .add(ShowListEventAddNewList(listName: text));
                },title: "Başlık Girin");
              },
            ),
          );
        });
  }

}
