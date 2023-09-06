import 'package:flutter/material.dart';


class SharedEmptyResult extends StatelessWidget {

  final String content;

  const SharedEmptyResult({
    Key? key,
    this.content = "Herhangi bir sonuç bulunamadı"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
