

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
part 'handle_receive_intent_state.freezed.dart';

@freezed
class HandleReceiveIntentState with _$HandleReceiveIntentState{
  const factory HandleReceiveIntentState({
    required LoadingEnum loadingEnum,
    required bool navigateToCustomPrayer,
    String? message
  }) = _HandleReceiveIntentState;
  
  static HandleReceiveIntentState init(){
    return const HandleReceiveIntentState(
      loadingEnum: LoadingEnum.idle,
      navigateToCustomPrayer: false
    );
  }
  
}