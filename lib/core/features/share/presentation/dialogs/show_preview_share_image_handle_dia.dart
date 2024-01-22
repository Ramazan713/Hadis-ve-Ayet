
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_preview_share_image_dia.dart';

final _globalKey = GlobalKey();

void showPreviewShareImageHandleDia(BuildContext context,{
  required Widget Function(GlobalKey key) onImageWidget,
  required String imageName
}){

  final shareBloc = context.read<ShareBloc>();

  final previewWidget = onImageWidget(_globalKey);

  showPreviewSharedImageDia(context,
    previewWidget: previewWidget,
    onTap: ()async{
      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);

      shareBloc.add(ShareEventShareImage(data: byteData, imageName: imageName));
    },
  );
}