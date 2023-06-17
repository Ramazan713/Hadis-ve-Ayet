

import '../hadith_item.dart';
import 'package:flutter/material.dart';

extension HadithItemButtonsExt on HadithItem{

  Widget getButtons(BuildContext context){

    final iconSize = fontSize + 3;

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(),
        IconButton(
          onPressed: onShareClick,
          icon: const Icon(Icons.share),
          iconSize: iconSize,
        ),
        IconButton(
          onPressed: onFavoriteClick,
          icon: hadithList.isInFavorite? const Icon(
            Icons.favorite,color: Colors.red,
          ): const Icon(Icons.favorite),
          iconSize: iconSize,
        ),
        IconButton(
          onPressed: onListClick,
          iconSize: iconSize,
          icon: Icon(hadithList.isInAnyList? Icons.library_add_check:Icons.library_add),
        ),
        const SizedBox(),
      ],
    );
  }

}