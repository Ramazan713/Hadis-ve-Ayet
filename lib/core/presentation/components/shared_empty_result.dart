import 'package:flutter/material.dart';


class SharedEmptyResult extends StatelessWidget {

  final String content;
  final EdgeInsets? paddings;
  final TextAlign textAlign;

  const SharedEmptyResult({
    Key? key,
    this.content = "Herhangi bir sonuç bulunamadı",
    this.paddings,
    this.textAlign = TextAlign.center
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings ?? EdgeInsets.zero,
      child: Center(
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
