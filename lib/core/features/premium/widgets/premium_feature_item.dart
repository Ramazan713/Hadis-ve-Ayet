import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';

class PremiumFeatureItem extends StatelessWidget {
  final String featureName;

  const PremiumFeatureItem({
    Key? key,
    required this.featureName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CardListTile(
      margins: const EdgeInsets.symmetric(vertical: 2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 13),
      leading: const Icon(Icons.done_outline),
      defaultColor: Theme.of(context).colorScheme.secondaryContainer,
      title: Text(featureName),
      borderRadius: BorderRadius.circular(19),
    );
  }
}
