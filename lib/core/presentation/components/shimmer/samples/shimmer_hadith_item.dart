

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/shimmer/i_shimmer_item.dart';
import 'package:hadith/core/presentation/components/shimmer/shimmer_skeleton.dart';

class ShimmerHadithItem extends IShimmerItem{
  const ShimmerHadithItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.outline,width: 2)
            ,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerSkeleton(height: 20,width: 30,),
                    ShimmerSkeleton(height: 20,width: 100,),
                    SizedBox(width: 20,)
                  ],
                ),
                SizedBox(height: 17,),
                ShimmerSkeleton(height: 20,width: 20,),
                SizedBox(height: 7,),
                Padding(padding: EdgeInsets.only(right: 30),
                    child: ShimmerSkeleton(height: 20,width: 20,)),
                SizedBox(height: 23,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 80),
                    child: ShimmerSkeleton(height: 20,width: 20,)),
                SizedBox(height: 7,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}