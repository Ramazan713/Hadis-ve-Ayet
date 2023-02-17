import 'package:flutter/material.dart';


class CounterContentWithChild extends StatelessWidget {
  final String title;
  final Widget child;
  final double fontSize;
  const CounterContentWithChild({Key? key,required this.title,required this.child,required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title,
              style: Theme.of(context).textTheme.titleMedium?.
              copyWith(fontWeight: FontWeight.w500, fontSize: fontSize),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 3,),
            child
          ],
        ),
      ),
    );
  }
}
