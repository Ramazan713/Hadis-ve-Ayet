

import 'package:hadith/core/domain/models/premium/subscription_model.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class PremiumProductDetailInfoUseCase{

  SubscriptionModel call({required ProductDetails productDetails}){
    String? trialContent;

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