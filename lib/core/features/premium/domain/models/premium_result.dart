


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'premium_result.freezed.dart';

@freezed
class PremiumResult with _$PremiumResult{
  const factory PremiumResult({
    required bool isLoading,
    required bool isPremium,
    String? error
  }) = _PremiumResult;
}