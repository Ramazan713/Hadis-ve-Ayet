import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';


class ShareItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final IconInfo? iconInfo;

  const ShareItem({Key? key,required this.title,required this.onTap,
    required this.iconInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: onTap,
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        leading: iconInfo?.toIcon(),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
