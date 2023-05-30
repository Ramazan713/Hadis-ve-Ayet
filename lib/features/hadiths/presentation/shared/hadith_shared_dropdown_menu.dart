import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/presentation/components/dropdown_bar_menu.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_top_bar_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

class HadithSharedDropdownMenu extends StatelessWidget {

  final List<IMenuItem> customMenuItems;
  final bool useDefaultMenuItems;
  final void Function(IMenuItem menuItem, void Function(IMenuItem) defaultHandler)? onMenuItem;
  final SavePointDestination destination;

  const HadithSharedDropdownMenu({
    Key? key,
    required this.destination,
    this.customMenuItems = const [],
    this.useDefaultMenuItems = true,
    this.onMenuItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final menuItems = <IMenuItem>[];
    menuItems.addAll(customMenuItems);
    if(useDefaultMenuItems){
      menuItems.addAll(HadithTopBarMenuItem.values);
    }

    return BlocSelector<PaginationBloc,PaginationState,HadithListModel?>(
        selector: (state)=> state.visibleMiddleItem.castOrNull<HadithListModel>(),
        builder: (context, visibleMiddleItem){
          return CustomDropdownBarMenu(
              items: menuItems,
              selectedFunc: (menuItem){
                if(onMenuItem!=null){
                  return onMenuItem?.call(menuItem,(menuItem){
                    _handleMenuItem(context, menuItem,visibleMiddleItem: visibleMiddleItem);
                  });
                }
                _handleMenuItem(context, menuItem,visibleMiddleItem: visibleMiddleItem);
              }
          );
        }
    );
  }

  void _handleMenuItem(BuildContext context,IMenuItem menuItem,{HadithListModel? visibleMiddleItem}){
    final pagingBloc = context.read<PaginationBloc>();

    switch(menuItem){
      case HadithTopBarMenuItem.fontSize:
        showSelectFontSizeBottomDia(context);
        break;
      case HadithTopBarMenuItem.savePoint:
        showEditSavePointsDiaBasic(context,
            destination: destination,
            itemIndexPos: visibleMiddleItem?.rowNumber ?? 0,
            onLoadSavePointClick: (savePoint){
              pagingBloc.add(PaginationEventJumpToPos(pos: savePoint.itemIndexPos));
            }
        );
        break;
    }
  }


}
