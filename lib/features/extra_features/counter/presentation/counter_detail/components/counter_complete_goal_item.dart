import 'package:flutter/material.dart';


class CounterCompleteGoalItem extends StatelessWidget {
  const CounterCompleteGoalItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 19),
          child: Text("Hedefe ulaşıldı",style: Theme.of(context).textTheme.titleMedium,)),
    );
  }
}
