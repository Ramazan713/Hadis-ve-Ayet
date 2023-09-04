

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/model/select_audio_option.dart';

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

    showBottomMenuItems(
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