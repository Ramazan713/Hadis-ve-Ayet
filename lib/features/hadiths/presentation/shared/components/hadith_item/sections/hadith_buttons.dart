

import '../hadith_item.dart';
import 'package:flutter/material.dart';

extension HadithItemButtonsExt on HadithItemState{

  Widget getButtons(BuildContext context){

    final iconSize = widget.fontSize + 3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(),
        Flexible(
          child: IconButton(
            onPressed: widget.onShareClick,
            icon: const Icon(Icons.share_outlined),
            iconSize: iconSize,
          ),
        ),
        Flexible(
          child: IconButton(
            isSelected: hadithList.isInFavorite,
            onPressed: widget.onFavoriteClick,
            icon: const Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite,color: Theme.of(context).colorScheme.error,),
            iconSize: iconSize,
          ),
        ),
        Flexible(
          child: IconButton(
            isSelected: hadithList.isInAnyList,
            onPressed: widget.onListClick,
            selectedIcon: const Icon(Icons.library_add_check),
            iconSize: iconSize,
            icon: const Icon(Icons.library_add_outlined),
          ),
        ),
        const SizedBox(),
      ],
    );
  }

}