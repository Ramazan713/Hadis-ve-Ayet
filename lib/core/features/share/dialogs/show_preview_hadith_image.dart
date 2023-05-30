

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/components/get_hadith_repaint_boundary.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_share_image_dia.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';


void showPreviewAndShareHadithImage(
    BuildContext context,
{
  required String hadithContent,
  required String hadithSource,
  required int hadithId
}){
  final GlobalKey globalKey = GlobalKey();

  final shareBloc = context.read<ShareBloc>();

  final previewWidget = getHadithRepaintBoundary(context,
      hadithContent: hadithContent,
      hadithSource: hadithSource,
      globalKey: globalKey
  );

  showPreviewSharedImageDia(context,
      previewWidget: previewWidget,
      onTap: ()async{
        RenderRepaintBoundary? boundary = globalKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary?;
        ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image?.toByteData(format: ui.ImageByteFormat.png);

        shareBloc.add(ShareEventShareImage(data: byteData, imageName: "$hadithId-Hadis.png"));
      },
  );

}