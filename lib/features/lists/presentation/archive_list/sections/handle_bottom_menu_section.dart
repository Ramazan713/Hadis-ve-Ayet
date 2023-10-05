import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/features/lists/domain/archive_list_menu_enum.dart';
import 'package:hadith/features/lists/presentation/shared/export_list_view.dart';

import '../archive_list_page.dart';
import '../bloc/archive_list_bloc.dart';
import '../bloc/archive_list_event.dart';

extension HandleBottomMenuExt on ArchiveListPageState{

  void showAndManageBottomMenu(ListViewModel item, SourceTypeEnum sourceType){

    showBottomMenuItems(context,
        items: ArchiveListMenuEnum.values,
        onItemClick: (menuItem){
          Navigator.pop(context);

          switch(menuItem){
            case ArchiveListMenuEnum.rename:
              _rename(context, item);
              break;
            case ArchiveListMenuEnum.remove:
              _remove(context, item);
              break;
            case ArchiveListMenuEnum.unArchive:
              _unArchive(context, item);
              break;
            case ArchiveListMenuEnum.exportAs:
              exportListViewModel(context, item);
              break;
          }
        },
        title: "'${item.name}' listesi için",
    );
  }

  void _rename(BuildContext context, ListViewModel item){
    final bloc = context.read<ArchiveListBloc>();
    showEditTextDia(context, (newText) {
      bloc.add(ArchiveListEventRename(listViewModel: item, newTitle: newText));
    }, title: "Yeniden İsimlendir", content: item.name);
  }

  void _remove(BuildContext context, ListViewModel item){
    final bloc = context.read<ArchiveListBloc>();
    showCustomAlertDia(
        context,
        title: "Silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        btnApproved: () {
          bloc.add(ArchiveListEventRemove(listViewModel: item));
        });
  }

  void _unArchive(BuildContext context, ListViewModel item){
    final bloc = context.read<ArchiveListBloc>();
    showCustomAlertDia(
        context,
        title: "Arşivden çıkarmak istediğinize emin misiniz?",
        btnApproved: () {
          bloc.add(ArchiveListEventUnArchive(listViewModel: item));
        });
  }

}