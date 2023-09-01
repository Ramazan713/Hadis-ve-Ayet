
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/presentation/components/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/dialogs/show_select_edition.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/verses/cuz/domain/enums/cuz_top_bar_menu_item.dart';
import 'package:hadith/features/verses/cuz/presentation/cuz_page.dart';
import 'package:flutter/material.dart';

extension CuzPageTopBarExt on CuzPage{

  List<Widget> getActions(BuildContext context){
    return [
      IconButton(
        onPressed: () {
          showSelectSavePoints(context,
            shortTitle: "Cüz",
            savePointType: SavePointType.cuz,
            bookScope: BookScopeEnum.diyanetMeal,
          );
        },
        icon: const Icon(Icons.save),
        tooltip: "Kayıt Noktası",
      ),
      _getDropdownMenu(context)
    ];
  }

  Widget _getDropdownMenu(BuildContext context){
    return CustomDropdownIconMenu(
      items: CuzTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case CuzTopBarMenuItem.selectEdition:
            showSelectEdition(context);
            break;
        }
      },
    );
  }

}