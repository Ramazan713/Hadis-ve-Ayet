import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/components/save_point_list_view.dart';
import 'package:hadith/core/features/save_point/show_save_point/bloc/show_save_point_event.dart';
import 'package:hadith/core/presentation/components/dropdown_text_menu.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

import '../handler/save_point_navigate_handler.dart';
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
  context.read<ShowSavePointBloc>()
      .add(ShowSavePointEventLoadBookData(scopes: scopes, filter: null));

  _showSelectSavePoints(
    context,
    shortTitle: shortTitle,
    menuItems: menuItems,
  );
}

void showSelectSavePoints(
    BuildContext context,
    {
      required String shortTitle,
      required SavePointType savePointType,
      BookScopeEnum? bookScope,
    }
    ){

  context.read<ShowSavePointBloc>()
      .add(ShowSavePointEventLoadTypeData(savePointType: savePointType,scope: bookScope));

  _showSelectSavePoints(
      context,
      shortTitle: shortTitle,
      menuItems: [],
  );
}


void _showSelectSavePoints(
    BuildContext context,
{
  required String shortTitle,
  required List<SavePointType> menuItems,
}
){

  final bloc = context.read<ShowSavePointBloc>();

  final ScrollController scrollController=ScrollController();


  List<DropdownMenuItem<SavePointType>> getDropDownItems(){
    List<DropdownMenuItem<SavePointType>>items=[];
    items.add(DropdownMenuItem(value: null,child: Text("Seçilmedi",style: Theme.of(context).textTheme.subtitle1,),));
    for(var item in menuItems){
      items.add(DropdownMenuItem(value: item,child: Text(item.title),));
    }
    return items;
  }

  Widget getDropdownMenu(){

    if(menuItems.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5,top: 5),
      child: BlocSelector<ShowSavePointBloc,ShowSavePointState,SavePointType?>(
        selector: (state)=>state.selectedMenuItem,
        builder: (context,selectedOriginTag){
          return CustomDropdownTextMenu(
            selectedItem: selectedOriginTag,
            items: menuItems,
            addEmptyItem: true,
            onSelected: (selected){
              bloc.add(ShowSavePointEventChangeMenuItem(savePointType: selected));
            },
          );
        },
      ),
    );

  }


  showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {

        return DraggableScrollableSheet(
          minChildSize: 0.4,
          initialChildSize: 0.5,
          maxChildSize: 0.99,
          expand: false,
          builder: (context, scrollControllerDraggable) {

            return BlocListener<ShowSavePointBloc,ShowSavePointState>(
              listener: (context, state){
                final message = state.message;
                if(message!=null){
                  ToastUtils.showLongToast(message);
                  bloc.add(ShowSavePointEventClearMessage());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getDropdownMenu(),
                      IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 27,
                          ))
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollControllerDraggable,
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocSelector<ShowSavePointBloc,ShowSavePointState,SavePoint?>(
                          selector: (state)=>state.selectedSavePoint,
                          builder: (context, selectedSavePoint){
                            return CustomButtonPositive(
                              onTap: () {
                                if(selectedSavePoint!=null){
                                  context.pop();
                                  savePointNavigateHandlerWithSavePoint(context, savePoint: selectedSavePoint);
                                }
                              },
                              label: "Yükle ve Git",
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      });
}
