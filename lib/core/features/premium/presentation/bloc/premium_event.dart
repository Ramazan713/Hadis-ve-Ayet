
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class IPremiumEvent{}

class PremiumEventInit extends IPremiumEvent{}

class PremiumEventLoadProducts extends IPremiumEvent{}

class PremiumEventCheckPurchase extends IPremiumEvent{}

class PremiumEventMakePurchase extends IPremiumEvent{
  final ProductDetails productDetails;
  PremiumEventMakePurchase({required this.productDetails});
}

