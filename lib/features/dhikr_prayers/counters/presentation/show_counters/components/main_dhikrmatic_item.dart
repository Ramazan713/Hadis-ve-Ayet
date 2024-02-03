import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/core/utils/asset_helper.dart';


class MainDhikrmaticItem extends StatelessWidget {
  final String title;
  final Function() onClick;
  final EdgeInsets? margin;

  const MainDhikrmaticItem({
    Key? key,
    required this.title,
    required this.onClick,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CardListTile(
      margins: margin ?? EdgeInsets.zero,
      title: Text(title),
      leading: Image.asset(AssetHelper.dhikr,width: 35),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onClick,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(19),
          bottomRight: Radius.circular(19),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        ),
      ),
      defaultColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
