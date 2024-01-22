

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'get_title_state.freezed.dart';

@freezed
class GetTitleState with _$GetTitleState{
  const factory GetTitleState({
    String? title
  }) = _GetTitleState;

  static GetTitleState init(){
    return const GetTitleState(

    );
  }

}