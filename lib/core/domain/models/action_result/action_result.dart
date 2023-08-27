

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'action_result.freezed.dart';

@freezed
class ActionResult with _$ActionResult{
  const factory ActionResult({
    required String key,
    required bool isSuccess
  }) = _ActionResult;
}