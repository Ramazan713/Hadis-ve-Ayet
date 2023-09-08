

import 'package:hadith/core/domain/models/premium/subscription_model.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class PremiumProductDetailInfoUseCase{

  SubscriptionModel call({required ProductDetails productDetails}){
    String? trialContent;
    if(productDetails is GooglePlayProductDetails){
      final daysPattern = RegExp("\\d+D");
      final match = daysPattern.firstMatch(productDetails.skuDetails.freeTrialPeriod);
      final matchResult = productDetails.skuDetails.freeTrialPeriod.substring(match?.start??0,match?.end);
      if(matchResult != ''){
        trialContent = matchResult.split("D")[0];
      }
    }

    String title;
    if(productDetails.title.contains("(")){
      title = productDetails.title.split("(")[0];
    }else{
      title = productDetails.title;
    }

    return SubscriptionModel(
      title: title,
      price: productDetails.price,
      trialContent: trialContent,
      productDetails: productDetails
    );
  }

}