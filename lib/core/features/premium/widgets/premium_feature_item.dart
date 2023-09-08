import 'package:flutter/material.dart';

class PremiumFeatureItem extends StatelessWidget {
  final String featureName;

  const PremiumFeatureItem({
    Key? key,
    required this.featureName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 13),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19)
        ),
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        leading: const Icon(Icons.done_outline),
        title: Text(featureName),
      ),
    );
  }
}
