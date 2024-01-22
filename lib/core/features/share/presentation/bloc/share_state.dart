

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/features/share/share_ui_event.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'share_state.freezed.dart';

@freezed
class ShareState with _$ShareState{
  const factory ShareState({
    required LoadingEnum loadingEnum,
    String? message,
    ShareUiEvent? shareUiEvent
  }) = _ShareState;

  static ShareState init(){
    return const ShareState(
      loadingEnum: LoadingEnum.idle
    );
  }
}