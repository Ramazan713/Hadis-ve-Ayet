

import 'dart:io';

import 'package:hadith/core/domain/models/premium/premium_result.dart';
import 'package:hadith/core/domain/models/premium/subscription_model.dart';
import 'package:hadith/core/domain/repo/premium_repo.dart';
import 'package:hadith/core/domain/use_cases/premium_product_detail_info_use_case.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:rxdart/rxdart.dart';

class PremiumRepoImpl extends PremiumRepo{

  late final PremiumProductDetailInfoUseCase _premiumProductDetailUseCase;

  PremiumRepoImpl({required PremiumProductDetailInfoUseCase premiumProductDetailUseCase}){
    _premiumProductDetailUseCase = premiumProductDetailUseCase;
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  @override
  Future<bool> isAvailable() {
    return _inAppPurchase.isAvailable();
  }

  @override
  Future<void> checkAndCompletePurchase(PurchaseDetails purchaseDetail) async{
    if (purchaseDetail.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetail);
    }
  }

  @override
  Future<bool> hasPremium() async{
    if(Platform.isAndroid){
      final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final purchases = await androidAddition.queryPastPurchases();
      if(purchases.pastPurchases.isNotEmpty){
        final pastPurchases = purchases.pastPurchases;
        for(final purchase in pastPurchases){
          switch(purchase.status){
            case PurchaseStatus.purchased:
            case PurchaseStatus.restored:
              return true;
            default:
              break;
          }
        }
      }
    }
    return false;
  }



  @override
  Future<Resource<List<SubscriptionModel>>> loadProducts() async{
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if(isAvailable){
      const Set<String> kIds = <String>{'premium_monthly_hadiths'};
      final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(kIds);
      if (response.notFoundIDs.isNotEmpty) {
        return ResourceError("Bir şeyler yanlış gitti");
      }
      final subs = response.productDetails.map((e){
        return _premiumProductDetailUseCase(productDetails: e);
      }).toList();
      return ResourceSuccess(subs);
    }else{
      return ResourceError("Ödeme platformu kullanılabilir değil");
    }
  }

  @override
  Future<void> purchase(ProductDetails productDetails) async{
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  ValueStream<PremiumResult> get resultStream{
    return _inAppPurchase.purchaseStream.asyncMap<PremiumResult>((purchaseDetails)async{
      PremiumResult premiumResult;
      for (var purchaseDetail in purchaseDetails) {
        switch (purchaseDetail.status) {
          case PurchaseStatus.error:
            premiumResult = PremiumResult(
                isLoading: false,
                isPremium: false,
                error: purchaseDetail.error?.message
            );
          case PurchaseStatus.pending:
            premiumResult = const PremiumResult(
              isLoading: true,
              isPremium: false,
            );
          case PurchaseStatus.purchased:
          case PurchaseStatus.restored:
            premiumResult = const PremiumResult(
              isLoading: false,
              isPremium: true,
            );
          case PurchaseStatus.canceled:
            premiumResult = const PremiumResult(
              isLoading: false,
              isPremium: false,
            );
        }
        await checkAndCompletePurchase(purchaseDetail);
        return premiumResult;
      }
      return const PremiumResult(
        isLoading: false,
        isPremium: false,
      );
    }).shareValue();
  }



}