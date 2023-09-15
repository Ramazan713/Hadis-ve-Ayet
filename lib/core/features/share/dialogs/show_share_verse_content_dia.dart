

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_verse_content_dia.dart';
import 'package:hadith/core/features/share/enums/share_verse_content_menu_item.dart';
import 'package:hadith/core/presentation/dialogs/show_share_alert_dia.dart';

void showShareVerseContentDia(BuildContext context,{
  required ShareVerseContent item,
  FontModel? fontModel,
  required String imageName
}){
  final shareText = item.getShareText();
  final shareBloc = context.read<ShareBloc>();

  FontModel currentFontModel = fontModel ?? context.read<FontModelUseCase>().call();

  showShareAlertDia(context,
      items: SharingCommonMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case SharingCommonMenuItem.copyText:
            shareBloc.add(ShareEventCopyText(text: shareText));
            break;
          case SharingCommonMenuItem.shareImage:
            showPreviewVerseContentDia(context,
              item: item,
              fontModel: currentFontModel,
              imageName: imageName
            );
            break;
          case SharingCommonMenuItem.shareText:
            shareBloc.add(ShareEventShareText(text: shareText));
            break;
        }
      }
  );
}