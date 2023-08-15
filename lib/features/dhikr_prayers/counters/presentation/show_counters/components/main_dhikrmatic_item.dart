import 'package:flutter/material.dart';


class MainDhikrmaticItem extends StatelessWidget {
  final String title;
  final Function() onClick;
  const MainDhikrmaticItem({Key? key,required this.title,required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios,color: Theme.of(context).iconTheme.color,),
        onTap: onClick,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        tileColor: Theme.of(context).selectedRowColor,
      ),
    );
  }
}
