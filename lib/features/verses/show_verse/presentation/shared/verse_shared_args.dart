

import 'package:flutter/material.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';

mixin VerseSharedPageArgs {

  EditSavePointHandler? get editSavePointHandler;
  int? get listIdControlForSelectList;
  bool get showNavigateToActions;
  bool? get useWideScopeNaming;

  SelectAudioOption? get selectAudioOption;
}

abstract class VerseSharedBasePageStateful extends StatefulWidget implements VerseSharedPageArgs {

  @override
  final EditSavePointHandler? editSavePointHandler;
  @override
  final int? listIdControlForSelectList;
  @override
  final bool showNavigateToActions;
  @override
  final bool? useWideScopeNaming;

  @override
  final SelectAudioOption? selectAudioOption;


  const VerseSharedBasePageStateful({
    super.key,
    this.editSavePointHandler,
    this.listIdControlForSelectList,
    required this.showNavigateToActions,
    this.useWideScopeNaming,
    this.selectAudioOption,
  });

}

abstract class VerseSharedBasePageStateless extends StatelessWidget implements VerseSharedPageArgs {

  @override
  final EditSavePointHandler? editSavePointHandler;
  @override
  final int? listIdControlForSelectList;
  @override
  final bool showNavigateToActions;
  @override
  final bool? useWideScopeNaming;

  @override
  final SelectAudioOption? selectAudioOption;

  const VerseSharedBasePageStateless({
    super.key,
    this.editSavePointHandler,
    this.listIdControlForSelectList,
    required this.showNavigateToActions,
    this.useWideScopeNaming,
    this.selectAudioOption,
  });

}