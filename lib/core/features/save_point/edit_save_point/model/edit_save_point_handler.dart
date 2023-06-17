

import 'package:hadith/core/domain/models/save_point.dart';

class EditSavePointHandler{
  final void Function(SavePoint savePoint, bool differentLocation) onLoadSavePointClick;
  final void Function(void Function(bool)) onOverrideSavePointRequestHandler;
  final void Function(void Function(bool)) onLoadSavePointRequestHandler;

  EditSavePointHandler({
    required this.onLoadSavePointClick,
    required this.onLoadSavePointRequestHandler,
    required this.onOverrideSavePointRequestHandler
  });
}