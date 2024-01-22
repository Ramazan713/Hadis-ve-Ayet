


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
part 'subscription_model.freezed.dart';

@freezed
class SubscriptionModel with _$SubscriptionModel{
  const factory SubscriptionModel({
    required String title,
    required String price,
    required ProductDetails productDetails,
    String? trialContent,
  }) = _SubscriptionModel;
}