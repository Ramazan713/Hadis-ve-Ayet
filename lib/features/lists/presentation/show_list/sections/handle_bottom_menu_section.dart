

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/features/lists/domain/list_share_menu_item.dart';
import 'package:hadith/features/lists/domain/show_list_menu_enum.dart';
import 'package:hadith/features/lists/presentation/shared/export_list_view.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';

import '../show_list_page.dart';

extension HandleBottomMenuExt on ShowListPageState{

  void showAndManageBottomMenu(ListViewModel item, SourceTypeEnum sourceType){
    final listMenuEnums = ShowListMenuEnum.getMenuItems(item.isRemovable);

    showBottomMenuItems(
        context,
        items: listMenuEnums,
        onItemClick: (menuItem){
          Navigator.of(context,rootNavigator: true).pop();

          switch(menuItem){
            case ShowListMenuEnum.rename:
              _rename(item);
              break;
            case ShowListMenuEnum.remove:
              _remove(item);
              break;
            case ShowListMenuEnum.archive:
              _archive(item);
              break;
            case ShowListMenuEnum.removeItems:
              _removeItems(item, sourceType);
              break;
            case ShowListMenuEnum.newCopy:
              _copy(item);
              break;
            case ShowListMenuEnum.exportAs:
              exportListViewModel(context, item);
              break;
          }
        },
        title: "'${item.name}' listesi için",
        useRootNavigator: true
    );
  }

  void _rename(ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showEditTextDia(context, (newText) {
      bloc.add(ShowListEventRename(listViewModel: item, newTitle: newText));
    }, title: "Yeniden İsimlendir", content: item.name,useRootNavigator: true);
  }

  void _remove(ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(
        context,
        useRootNavigator: true,
        title: "Silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        btnApproved: () {
          bloc.add(ShowListEventRemove(listViewModel: item));
        }
    );
  }

  void _archive(ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(
        context,
        title: "Arşivlemek istediğinize emin misiniz?",
        useRootNavigator: true,
        content: "Arşivlenen listeler yalnızca arşiv kısmında kullanılabilir",
        btnApproved: () {
          bloc.add(ShowListEventArchive(listViewModel: item));
        });
  }

  void _removeItems(ListViewModel item, SourceTypeEnum sourceType){
    final key= sourceType==SourceTypeEnum.hadith?"hadisleri":"ayetleri";
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(
        context,
        title: "Listedeki $key silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        useRootNavigator: true,
        btnApproved: (){
          bloc.add(ShowListEventRemoveItems(listViewModel: item));
        });
  }

  void _copy(ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(context,useRootNavigator: true,
        title: "Yeni bir kopya oluştumak istediğinize emin misiniz",
        btnApproved: () {
          bloc.add(ShowListEventCopy(listViewModel: item));
        });
  }
}