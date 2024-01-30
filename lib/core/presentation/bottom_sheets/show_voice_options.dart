

import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_menu_items.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_service_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';

void showVoiceOptions(BuildContext context, {
    required void Function(QuranAudioOption option) onTap,
    required SelectAudioOption selectOp,
    required AudioServiceEnum audioServiceEnum
}){
  duplicateDialogHandler(func: ()async{
    if(selectOp == SelectAudioOption.verse){
      onTap.call(QuranAudioOption.verse);
      return;
    }
    final items = selectOp.getSelectOptions();

    final shortTitle = audioServiceEnum == AudioServiceEnum.listenAudio ?
        "Dinlemek" : "Indirmek";
    final title = "$shortTitle istediğiniz kategoriyi seçiniz";

    selectAdaptiveMenuItems(
      context,
      items: items,
      title: title,
      onItemClick: (selected){
        Navigator.of(context,rootNavigator: false).pop();
        onTap(selected);
      }
    );
  });
}