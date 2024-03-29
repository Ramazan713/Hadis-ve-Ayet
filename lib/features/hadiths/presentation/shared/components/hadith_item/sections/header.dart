

import 'package:flutter/material.dart';
import '../hadith_item.dart';

extension HadithItemHeaderExt on HadithItemState{

  Widget getHeader(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${hadithList.rowNumber}",
          textAlign: TextAlign.start,
          style: getSmallTextStyle(context)?.copyWith(fontSize: widget.fontSize - 2),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: Text("- ${hadithList.topicNames}",
              textAlign: TextAlign.center,
              style:
              getSmallTextStyle(context)?.copyWith(fontSize: widget.fontSize - 4)),
        ),
        const SizedBox(
          width: 33,
        )
      ],
    );
  }

}