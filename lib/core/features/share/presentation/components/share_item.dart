import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';


class ShareItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final IconInfo? iconInfo;

  const ShareItem({Key? key,required this.title,required this.onTap,
    required this.iconInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListTile(
      margins: const EdgeInsets.symmetric(vertical: 5),
      onTap: onTap,
      defaultColor: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      leading: iconInfo?.toIcon(),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
