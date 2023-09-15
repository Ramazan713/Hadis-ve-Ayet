import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/core/features/share/components/verse_content_share_item.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_share_image_handle_dia.dart';

void showPreviewVerseContentDia(BuildContext context,{
  required ShareVerseContent item,
  required FontModel fontModel,
  required String imageName
}){

  showPreviewShareImageHandleDia(context,
    onImageWidget: (key){
      return ShareVerseContentItem(
        item: item,
        fontModel: fontModel,
        repaintKey: key,
      );
    },
    imageName: imageName
  );
}