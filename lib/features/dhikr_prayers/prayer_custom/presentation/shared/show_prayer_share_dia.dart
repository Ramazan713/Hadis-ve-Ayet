

import 'package:flutter/material.dart';
import 'package:hadith/core/features/share/dialogs/show_share_verse_content_dia.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_custom_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

void showCustomPrayerShareDia(BuildContext context,{
  required PrayerCustom? prayer,
}){
  if(prayer == null || !prayer.hasAnyData) return;

  showShareVerseContentDia(
      context,
      item: prayer.toShareContent(),
      imageName: "${prayer.name}.png"
  );
}