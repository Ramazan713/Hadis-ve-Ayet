import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

class IconTextMenuItem extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final IconInfo? iconInfo;


  const IconTextMenuItem({Key? key,required this.title, required this.iconInfo, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        leading: iconInfo?.toIcon(color: Theme.of(context).iconTheme.color),
        dense: true,
        contentPadding: const EdgeInsets.only(left: 20,top: -23,bottom: -23),
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onTap: onTap,
      ),
    );
  }
}
