


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/components/save_point_list_view.dart';
import 'package:hadith/core/features/save_point/show_save_point/bloc/show_save_point_event.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

import 'bloc/show_save_point_bloc.dart';
import 'bloc/show_save_point_state.dart';


void showSelectSavePointsWithScopes(
    BuildContext context,
    {
      required String shortTitle,
      required List<SavePointType> menuItems,
      required List<BookScopeEnum> scopes,
    }
){
  _showSelectSavePoints(
    context,
    shortTitle: shortTitle,
    menuItems: menuItems,
    filter: null,
    scopes: scopes
  );
}

void showSelectSavePoints(
    BuildContext context,
    {
      required String shortTitle,
      required List<SavePointType> menuItems,
      required SavePointType filter,
    }
    ){
  _showSelectSavePoints(
      context,
      shortTitle: shortTitle,
      menuItems: menuItems,
      filter: filter,
      scopes: []
  );
}


void _showSelectSavePoints(
    BuildContext context,
{
  required String shortTitle,
  required List<SavePointType> menuItems,
  required SavePointType? filter,
  required List<BookScopeEnum> scopes,
}
){

  final bloc = context.read<ShowSavePointBloc>();

  final ScrollController scrollController=ScrollController();

  bloc.add(ShowSavePointEventLoadData(scopes: scopes, filter: filter));


  List<DropdownMenuItem<SavePointType>> getDropDownItems(){
    List<DropdownMenuItem<SavePointType>>items=[];

    items.add(DropdownMenuItem(child: Text("Seçilmedi",style: Theme.of(context).textTheme.subtitle1,),value: null,));
    for(var item in menuItems){
      items.add(DropdownMenuItem(child: Text(item.title),value: item,));
    }
    return items;
  }

  Widget getDropdownSelectOrigin(){
    return filter!=null?
    const SizedBox():
    Padding(
      padding: const EdgeInsets.only(left: 5,top: 5),
      child: BlocSelector<ShowSavePointBloc,ShowSavePointState,SavePointType>(
        selector: (state)=>state.selectedMenuItem,
        builder: (context,selectedOriginTag){
          return DropdownButton<SavePointType>(
            items:getDropDownItems(),
            value: selectedOriginTag,
            onChanged: (selected){
              if(selected!=null) {
                bloc.add(ShowSavePointEventChangeMenuItem(savePointType: selected));
              }
            },);
        },
      ),
    );
  }


  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {

        return DraggableScrollableSheet(
          minChildSize: 0.3,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollControllerDraggable) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollControllerDraggable,
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    getDropdownSelectOrigin(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 27,
                                        ))
                                  ],
                                ),
                                Text("$shortTitle Kayıt Noktaları",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6,),
                                const SizedBox(height: 13,),

                                BlocBuilder<ShowSavePointBloc,ShowSavePointState>(
                                  builder: (context,state){
                                    if(state.status == DataStatus.loading){
                                      return const Center(child: CircularProgressIndicator(),);
                                    }
                                    final items = state.savePoints;

                                    if(items.isEmpty){
                                      return  Center(child: Text("Herhangi bir kayıt bulunamadı",
                                        style: Theme.of(context).textTheme.bodyText2,),);
                                    }
                                    return SavePointListView(
                                      items: state.savePoints,
                                      scrollController: scrollController,
                                      selectedSavePoint: state.selectedSavePoint,
                                      onDeleteSavePoint: (item){
                                        bloc.add(ShowSavePointEventDelete(savePoint: item));
                                      },
                                      onEditSavePoint: (item,newTitle){
                                        bloc.add(ShowSavePointEventRename(savePoint: item,newTitle: newTitle));
                                      },
                                      onSelectSavePoint: (item){
                                        bloc.add(ShowSavePointEventSelect(savePoint: item));
                                      },
                                    );
                                  },
                                )
                              ]
                          )
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: CustomButtonPositive(
                        onTap: () {
                          // if(selectedSavePoint!=null){
                          //   final label=selectedSavePoint.parentName;
                          //   final loader=PagingLoaderFactory.getLoader(bookEnum,selectedSavePoint.bookScope,
                          //       selectedSavePoint.savePointType, selectedSavePoint.parentKey,
                          //       context);
                          //   final argument=PagingArgument(originTag: selectedSavePoint.savePointType,
                          //       savePointArg: SavePointLoadArg(parentKey: selectedSavePoint.parentKey,id: selectedSavePoint.id),
                          //       bookScope: selectedSavePoint.bookScope,
                          //       loader: loader,title:label);
                          //
                          //   switch(selectedSavePoint.bookScope.sourceType){
                          //     case SourceTypeEnum.hadith:
                          //       routeHadithPage(context,argument);
                          //       break;
                          //     case SourceTypeEnum.verse:
                          //       Navigator.pushNamed(context, VerseScreen.id,arguments: argument);
                          //       break;
                          //   }
                          // }
                        },
                        label: "Yükle ve Git",
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      });
}