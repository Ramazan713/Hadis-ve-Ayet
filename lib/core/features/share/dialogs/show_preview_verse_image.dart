

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/components/get_verse_repaint_boundary.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_share_image_dia.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';


void showPreviewAndShareVerseImage(
    BuildContext context,
    {
      required VerseListModel verseListModel
    }){
  final GlobalKey globalKey = GlobalKey();

  final shareBloc = context.read<ShareBloc>();

  final previewWidget = getVerseRepaintBoundary(context,
      globalKey: globalKey,
      verseListModel: verseListModel
  );

  showPreviewSharedImageDia(context,
    previewWidget: previewWidget,
    onTap: ()async{
      RenderRepaintBoundary? boundary = globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);

      shareBloc.add(ShareEventShareImage(
          data: byteData,
          imageName: "${verseListModel.verse.surahName}-${verseListModel.verse.verseNumber}-Ayet.png"
      ));
    },
  );

}