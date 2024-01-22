

import 'package:hadith/core/features/premium/domain/models/subscription_model.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

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