import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/select_edition/show_select_edition.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/verses/cuz/domain/enums/cuz_top_bar_menu_item.dart';
import 'package:flutter/material.dart';
import '../cuz_page.dart';

extension CuzPageTopBarExt on CuzPageState{

  List<Widget> getActions(){
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
      _getDropdownMenu()
    ];
  }

  Widget _getDropdownMenu(){
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