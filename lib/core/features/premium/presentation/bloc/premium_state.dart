import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/core/features/premium/domain/models/subscription_model.dart';

part 'premium_state.freezed.dart';

@freezed
class PremiumState with _$PremiumState{
  const factory PremiumState({
    required bool isPremium,
    required bool isLoading,
    required List<SubscriptionModel> items,
    required List<String> features,
    String? error
  }) = _PremiumState;

  static PremiumState init(){
    return const PremiumState(
      isLoading: false,
      items: [],
      features: [
        "Reklamsız",
      ],
      isPremium: false
    );
  }

}