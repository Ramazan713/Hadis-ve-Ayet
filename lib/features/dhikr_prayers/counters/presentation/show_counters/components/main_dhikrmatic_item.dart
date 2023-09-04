import 'package:flutter/material.dart';
import 'package:hadith/core/utils/asset_helper.dart';


class MainDhikrmaticItem extends StatelessWidget {
  final String title;
  final Function() onClick;

  const MainDhikrmaticItem({
    Key? key,
    required this.title,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
      child: ListTile(
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
        tileColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
