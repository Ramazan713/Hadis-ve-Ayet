import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_bloc.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_event.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_state.dart';
import 'package:hadith/features/save_point/widget/save_point_show_list_item.dart';
import 'package:hadith/widgets/custom_button_positive.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/constants/enums/sourcetype_enum.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/features/hadith/hadith_router.dart';
import 'package:hadith/features/paging/paging_argument.dart';
import 'package:hadith/features/paging/paging_loader_factory.dart';
import 'package:hadith/features/verse/verse_screen.dart';

import '../../models/save_point_argument.dart';
import 'bloc/save_point_edit_bloc.dart';

void showSelectSavePointWithBookDia(BuildContext context,
    {bool showOriginText=true,
      required BookEnum bookEnum,required List<BookScopeEnum>bookScopes,
      OriginTag? filter,List<OriginTag>exclusiveTags=const []}) {

  final editSavePoint = context.read<SavePointEditBookBloc>();
  final ScrollController scrollController=ScrollController();

  editSavePoint.add(SavePointBookEditEventRequest(bookScopes: bookScopes, filter: filter));


  List<DropdownMenuItem<OriginTag>> getDropDownItems(){
    List<DropdownMenuItem<OriginTag>>menuItems=[];
    List<OriginTag> tags=OriginTag.values.toList();
    for(var tag in exclusiveTags){
      tags.remove(tag);
    }
    menuItems.add(DropdownMenuItem(child: Text("Seçilmedi",style: Theme.of(context).textTheme.subtitle1,),value: null,));
    for(var item in tags){
      menuItems.add(DropdownMenuItem(child: Text(item.shortName),value: item,));
    }
    return menuItems;
  }

  Widget getDropdownSelectOrigin(){
    return filter!=null?
    const SizedBox():
    Padding(
      padding: const EdgeInsets.only(left: 5,top: 5),
      child: BlocSelector<SavePointEditBookBloc,SavePointEditBookState,OriginTag?>(
        selector: (state)=>state.selectedOriginTag,
        builder: (context,selectedOriginTag){
          return DropdownButton<OriginTag>(
            items:getDropDownItems(),
            value: selectedOriginTag,
            onChanged: (selected){
              editSavePoint.add(SavePointBookEditEventSelectOrigin(originTag: selected));
            },);
        },
      ),
    );
  }


  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {

        final String title;
        if(filter!=null){
          title="${filter.shortName} Kayıt Noktaları";
        }else{
          title="${bookEnum.bookScope?.description??""} Kayıt Noktaları";
        }

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
                              Text(title,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline6,),
                              const SizedBox(height: 13,),

                              BlocBuilder<SavePointEditBookBloc,SavePointEditBookState>(
                                builder: (context,state){
                                  if(state.status==DataStatus.loading){
                                    return const Center(child: CircularProgressIndicator(),);
                                  }
                                  final items = state.savePoints;

                                  if(items.isEmpty){
                                    return  Center(child: Text("Herhangi bir kayıt bulunamadı",
                                      style: Theme.of(context).textTheme.bodyText2,),);
                                  }
                                  return SavePointShowListItem(
                                    items: state.savePoints,
                                    scrollController: scrollController,
                                    showOriginText: showOriginText,
                                    selectedSavePoint: state.selectedSavePoint,
                                    onSelectSavePoint: (newSavePoint){
                                      editSavePoint.add(SavePointBookEditEventSelectSavePoint(savePoint: newSavePoint));
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
                      child: BlocSelector<SavePointEditBookBloc,SavePointEditBookState,SavePoint?>(
                        selector: (state)=>state.selectedSavePoint,
                        builder: (context,selectedSavePoint){
                          return CustomButtonPositive(
                            onTap: () {
                              if(selectedSavePoint!=null){
                                final label=selectedSavePoint.parentName;
                                final loader=PagingLoaderFactory.getLoader(bookEnum,selectedSavePoint.bookScope,
                                    selectedSavePoint.savePointType, selectedSavePoint.parentKey,
                                    context);
                                final argument=PagingArgument(originTag: selectedSavePoint.savePointType,
                                    savePointArg: SavePointLoadArg(parentKey: selectedSavePoint.parentKey,id: selectedSavePoint.id),
                                    bookScope: selectedSavePoint.bookScope,
                                    loader: loader,title:label);

                                switch(selectedSavePoint.bookScope.sourceType){
                                  case SourceTypeEnum.hadith:
                                    routeHadithPage(context,argument);
                                    break;
                                  case SourceTypeEnum.verse:
                                    Navigator.pushNamed(context, VerseScreen.id,arguments: argument);
                                    break;
                                }
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
            );
          },
        );
      });
}
