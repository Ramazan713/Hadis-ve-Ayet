import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/shimmer/i_shimmer_item.dart';
import 'package:shimmer/shimmer.dart';

class GetShimmerItems extends StatelessWidget {

  final IShimmerItem shimmerItem;
  final int itemCount;

  const GetShimmerItems({
    super.key,
    required this.itemCount,
    required this.shimmerItem
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceVariant,
      highlightColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index){
          return shimmerItem;
        },
      )
    );
  }
}
