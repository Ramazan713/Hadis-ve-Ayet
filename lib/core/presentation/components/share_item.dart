import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';


class ShareItem extends StatelessWidget {
  final Function()onTap;
  final String title;
  final IconInfo? iconInfo;

  const ShareItem({Key? key,required this.title,required this.onTap,
    required this.iconInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText1Style=Theme.of(context).textTheme.bodyText1;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: onTap,
        tileColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        leading: iconInfo?.toIcon(color: bodyText1Style?.color,useDefaultOrSet: true),
        title: Text(title,style: bodyText1Style,),
      ),
    );
  }
}
