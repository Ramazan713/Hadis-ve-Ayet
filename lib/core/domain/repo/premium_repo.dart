

import 'package:hadith/core/domain/models/premium/premium_result.dart';
import 'package:hadith/core/domain/models/premium/subscription_model.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:rxdart/rxdart.dart';

abstract class PremiumRepo{

  ValueStream<PremiumResult> get resultStream;

  Future<Resource<List<SubscriptionModel>>> loadProducts();

  Future<void> purchase(ProductDetails productDetails);

  Future<void> checkAndCompletePurchase(PurchaseDetails purchaseDetail);

  Future<bool> hasPremium();

  Future<bool> isAvailable();
}