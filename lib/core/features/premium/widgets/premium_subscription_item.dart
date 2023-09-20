import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/premium/subscription_model.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';

class PremiumSubscriptionItem extends StatelessWidget {
  final SubscriptionModel subsItem;
  final void Function()onClick;

  const PremiumSubscriptionItem({
    Key? key,
    required this.subsItem,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListTile(
      defaultColor: Theme.of(context).colorScheme.primaryContainer,
      borderWidth: 1,
      onTap: onClick,
      borderRadius: BorderRadius.circular(19),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            subsItem.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 7,),
          Text(
            subsItem.price,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 7,),

          getTrialContent(context)
        ],
      ),
    );
  }

  Widget getTrialContent(BuildContext context){
    if(subsItem.trialContent == null) return const SizedBox.shrink();
    return Text(subsItem.trialContent ?? "",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

}
