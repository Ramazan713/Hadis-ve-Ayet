

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_preview_verse_content_dia.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_verse_content_dia.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/prayer_custom_share_menu.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_custom_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

void showCustomPrayerShareDia(BuildContext context,{
  required PrayerCustom? prayer,
}){
  if(prayer == null || !prayer.hasAnyData) return;

  final shareItem = prayer.toShareContent();
  final shareText = shareItem.getShareText();
  final shareBloc = context.read<ShareBloc>();

  FontModel currentFontModel = context.read<FontModelUseCase>().call();

  showShareAlertDia(context,
      items: PrayerCustomShareMenu.values,
      onSelected: (menuItem){
        switch(menuItem){
          case PrayerCustomShareMenu.copyText:
            shareBloc.add(ShareEventCopyText(text: shareText));
            break;
          case PrayerCustomShareMenu.shareImage:
            showPreviewVerseContentDia(context,
                item: shareItem,
                fontModel: currentFontModel,
                imageName: "${prayer.name}.png"
            );
            break;
          case PrayerCustomShareMenu.shareText:
            shareBloc.add(ShareEventShareText(text: shareText));
            break;
          case PrayerCustomShareMenu.shareJson:
            shareBloc.add(ShareEventSharePrayerCustomJson(prayerCustom: prayer));
            break;
        }
      }
  );
}