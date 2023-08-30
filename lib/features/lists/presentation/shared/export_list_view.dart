import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/features/lists/domain/list_share_menu_item.dart';

void exportListViewModel(BuildContext context, ListViewModel item){
  final shareBloc = context.read<ShareBloc>();

  showShareAlertDia(
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
}