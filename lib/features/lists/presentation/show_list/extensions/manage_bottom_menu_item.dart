

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/presentation/bottom_sheets/showEditTextBottomDia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/dialogs/showShareAlertDialog.dart';
import 'package:hadith/features/lists/domain/list_share_menu_item.dart';
import 'package:hadith/features/lists/domain/show_list_menu_enum.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';

import '../show_list_page.dart';

extension ManageBottomMenuItems on ShowListPage{

  void showAndManageBottomMenu(BuildContext context,ListViewModel item, SourceTypeEnum sourceType){
    final listMenuEnums = ShowListMenuEnum.getMenuItems(item.isRemovable);

    showBottomMenuItems(context,
        items: listMenuEnums,
        onItemClick: (menuItem){
          Navigator.of(context,rootNavigator: true).pop();

          switch(menuItem){
            case ShowListMenuEnum.rename:
              _rename(context, item);
              break;
            case ShowListMenuEnum.remove:
              _remove(context, item);
              break;
            case ShowListMenuEnum.archive:
              _archive(context, item);
              break;
            case ShowListMenuEnum.removeItems:
              _removeItems(context, item, sourceType);
              break;
            case ShowListMenuEnum.newCopy:
              _copy(context, item);
              break;
            case ShowListMenuEnum.exportAs:
              _exportAs(context, item);
              break;
          }
        },
        title: "'${item.name}' listesi için",
        useRootNavigator: true
    );
  }

  void _rename(BuildContext context, ListViewModel item){
    showEditTextBottomDia(context, (newText) {
      context.read<ShowListBloc>()
          .add(ShowListEventRename(listViewModel: item, newTitle: newText));
    }, title: "Yeniden İsimlendir", content: item.name,useRootNavigator: true);
  }

  void _remove(BuildContext context, ListViewModel item){
    showCustomAlertBottomDia(
        context,
        useRootNavigator: true,
        title: "Silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        btnApproved: () {
          context.read<ShowListBloc>()
              .add(ShowListEventRemove(listViewModel: item));
        });
  }

  void _archive(BuildContext context, ListViewModel item){
    showCustomAlertBottomDia(
        context,
        title: "Arşivlemek istediğinize emin misiniz?",
        useRootNavigator: true,
        content: "Arşivlenen listeler yalnızca arşiv kısmında kullanılabilir",
        btnApproved: () {
          context.read<ShowListBloc>()
              .add(ShowListEventArchive(listViewModel: item));
        });
  }

  void _removeItems(BuildContext context, ListViewModel item, SourceTypeEnum sourceType){
    final key= sourceType==SourceTypeEnum.hadith?"hadisleri":"ayetleri";

    showCustomAlertBottomDia(
        context,
        title: "Listedeki $key silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        useRootNavigator: true,
        btnApproved: (){
          context.read<ShowListBloc>()
              .add(ShowListEventRemoveItems(listViewModel: item));
        });
  }

  void _copy(BuildContext context, ListViewModel item){
    showCustomAlertBottomDia(context,useRootNavigator: true,
        title: "Yeni bir kopya oluştumak istediğinize emin misiniz",
        btnApproved: () {
          context.read<ShowListBloc>()
              .add(ShowListEventCopy(listViewModel: item));
        });
  }

  void _exportAs(BuildContext context, ListViewModel item){
    final shareBloc = context.read<ShareBloc>();

    showShareAlertDialog(
        context,
        menuItems: ListShareMenuItem.values,
        onClick: (menuItem){
          switch(menuItem){
            case ListShareMenuItem.shareText:
              shareBloc.add(ShareEventSharePdfText(
                  listId: item.id,
                  sourceType: item.sourceType
              ));
              break;
            case ListShareMenuItem.sharePdf:
              shareBloc.add(ShareEventSharePdf(
                  listId: item.id,
                  sourceType: item.sourceType,
                  listName: item.name
              ));
              break;
          }
        },
    );

    // showShareAlertDialog(context, listItems: [
    //   // ListTileShareItem(
    //   //     title: "PDF Olarak Paylaş", onTap: () async {
    //   //   ShareUtils.sharePdf(context, item,
    //   //       SourceTypeHelper.getSourceTypeWithSourceId(
    //   //           item.sourceId));
    //   // }, iconData: FontAwesomeIcons.filePdf),
    //   // ListTileShareItem(title: "Yazı Olarak Paylaş", onTap: () {
    //   //   ShareUtils.shareTextWithList(context, item.id,
    //   //       SourceTypeHelper.getSourceTypeWithSourceId(
    //   //           item.sourceId));
    //   // }, iconData: Icons.text_format),
    // ]);
  }

}