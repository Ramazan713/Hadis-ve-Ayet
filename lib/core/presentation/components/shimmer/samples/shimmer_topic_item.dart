import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/shimmer/i_shimmer_item.dart';
import 'package:hadith/core/presentation/components/shimmer/shimmer_skeleton.dart';

class ShimmerTopicItem extends IShimmerItem{
  const ShimmerTopicItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.outline,width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 13,),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.7),
                    1: FlexColumnWidth(1.0),
                    2: FlexColumnWidth(7.0),
                  },
                  children: const [
                    TableRow(
                        children: [
                          TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ShimmerSkeleton(height: 25,width: 30,),),
                          SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ShimmerSkeleton(height: 20,width: 50,),
                              SizedBox(height: 7,),
                              Padding(padding: EdgeInsets.only(right: 30),
                                  child: ShimmerSkeleton(height: 20,width: 20,)),
                            ],
                          )
                        ]
                    )
                  ],
                ),
                const SizedBox(height: 13,),
               
              ],
            ),
          ),
        ),
      ),
    );
  }



}