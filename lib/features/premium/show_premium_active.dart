

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hadith/features/premium/premium_features.dart';

void showPremiumActive(BuildContext context){

  showDialog(context: context, builder: (context){
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 19),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: Alignment.centerRight,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.close,size: 30,
                  color: Theme.of(context).textTheme.headline5?.color,)),),
              Text("Premium Kullanılıyor",textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).errorColor,
                  fontWeight: FontWeight.bold
                ),),
              const SizedBox(height: 19,),
              Text("Özellikler",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w700
                  ),textAlign: TextAlign.left,),
              const SizedBox(height: 5,),
              ListView.builder(
                itemBuilder: (context, index) {
                  return kPremiumFeatureItems[index];
                },itemCount: kPremiumFeatureItems.length,shrinkWrap: true,),
              const SizedBox(height: 29,),
            ],
          ),
        ),
      ),
    );
  });


}