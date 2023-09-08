

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_extended_enum.dart';
import 'package:hadith/core/domain/models/premium/subscription_model.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
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