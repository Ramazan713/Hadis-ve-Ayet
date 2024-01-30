import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/premium/presentation/components/premium_feature_item.dart';
import 'package:hadith/core/features/premium/presentation/components/premium_subscription_item.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';

import 'bloc/premium_bloc.dart';
import 'bloc/premium_event.dart';
import 'bloc/premium_state.dart';

void showPremiumDia(BuildContext context){

  final premiumBloc=context.read<PremiumBloc>();
  premiumBloc.add(PremiumEventLoadProducts());

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    child: _DialogContent(
      scrollController: ScrollController(),
      onClosed: (){
        Navigator.pop(context);
      },
    ),
    bottomSheetChild: DraggableScrollableSheet(
      minChildSize: 0.5,
      initialChildSize: 0.7,
      expand: false,
      builder: (context, scrollControllerDraggable) {
        return _DialogContent(
          scrollController: scrollControllerDraggable,
          onClosed: (){
            Navigator.pop(context);
          },
        );
       }
      )
  );

}

class _DialogContent extends StatelessWidget {

  final void Function() onClosed;
  final ScrollController scrollController;

   const _DialogContent({
     super.key,
     required this.onClosed,
     required this.scrollController
   });

  @override
  Widget build(BuildContext context) {

    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeader(context),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 19,),
                    getFeaturesSection(context),
                    const SizedBox(height: 29,),
                    getSubsItemsSection(context),
                    const SizedBox(height: 37,),
                    getDescriptionsSection(context),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget getSubsItemsSection(BuildContext context){
    final premiumBloc=context.read<PremiumBloc>();

    return BlocBuilder<PremiumBloc,PremiumState>(
      builder: (context,state){

        if(state.isLoading){
          return const SharedLoadingIndicator();
        }
        final error = state.error;
        if(error!=null){
          return getErrorWidget(context, error);
        }

        final items = state.items;
        return ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return PremiumSubscriptionItem(
              subsItem: item,
              onClick: (){
                premiumBloc.add(PremiumEventMakePurchase(productDetails: item.productDetails));
              }
            );
          });
      });
  }

  Widget getErrorWidget(BuildContext context, String error){
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error_outline,size: 50,),
          const SizedBox(height: 5,),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  Widget getDescriptionsSection(BuildContext context){
    return ListView(
      controller: ScrollController(),
      shrinkWrap: true,
      children: const [
        Text("* Ücretsiz denemeye katıldıysanız,tekrardan ücretsiz denemeye katılamazsınız. Aboneliği satın alırken fatura döneminin başlama tarihine bakınız"),
        Text("* Abonelikler iptal edilmediği takdirde; aylık abonelik için aylık, yıllık abonelik için yıllık olarak yenilenir"),
        Text("* Aboneliği iptal ederseniz,geçerli fatura döneminde geri ödeme yapılmaz ve bu süre boyunca  abonelik devam eder. Fatura dönemi sonunda,üyelik sona erer ve ödeme tekrar alınmaz"),
        Text("* Google Play'de abonelikler bölümünden aboneliğinizi iptal edebilir veya tekrardan devam ettirebilirsiniz"),
      ],
    );
  }

  Widget getFeaturesSection(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Özellikler",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500
          )
        ),
        const SizedBox(height: 5,),
        BlocSelector<PremiumBloc, PremiumState, List<String>>(
          selector: (state) => state.features,
          builder: (context, features){
            return ListView.builder(
              itemCount: features.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (context, index) {
                final item = features[index];
                return PremiumFeatureItem(
                  featureName: item,
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget getHeader(BuildContext context){
     return Stack(
       alignment: Alignment.center,
       children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 48),
           child: Text(
             "Premium",
             textAlign: TextAlign.center,
             style: Theme.of(context).textTheme.titleLarge,
           ),
         ),
         Align(
           alignment: Alignment.centerRight,
           child: IconButton(
             onPressed: onClosed,
             icon: const Icon(Icons.close),
           ),
         )
       ],
     );
   }

  Widget getListeners({required Widget child}){
    return BlocListener<PremiumBloc,PremiumState>(
      listenWhen: (prevState, nextState){
        return prevState.isPremium != nextState.isPremium;
      },
      listener: (context, state){
        try{
          if(state.isPremium){
            onClosed();
          }
        }catch(e){}
      },
      child: child,
    );
  }

}


