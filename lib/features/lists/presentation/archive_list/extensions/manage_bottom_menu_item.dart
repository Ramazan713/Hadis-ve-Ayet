import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

extension ManageBottomMenuItems on ArchiveListPage{

  void showAndManageBottomMenu(BuildContext context,ListViewModel item, SourceTypeEnum sourceType){

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
    showEditTextDia(context, (newText) {
      context.read<ArchiveListBloc>()
          .add(ArchiveListEventRename(listViewModel: item, newTitle: newText));
    }, title: "Yeniden İsimlendir", content: item.name);
  }

  void _remove(BuildContext context, ListViewModel item){
    showCustomAlertDia(
        context,
        title: "Silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        btnApproved: () {
          context.read<ArchiveListBloc>()
              .add(ArchiveListEventRemove(listViewModel: item));
        });
  }

  void _unArchive(BuildContext context, ListViewModel item){
    showCustomAlertDia(
        context,
        title: "Arşivden çıkarmak istediğinize emin misiniz?",
        btnApproved: () {
          context.read<ArchiveListBloc>()
              .add(ArchiveListEventUnArchive(listViewModel: item));
        });
  }

}