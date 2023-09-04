import 'package:flutter/material.dart';


class CounterCompleteGoalItem extends StatelessWidget {

  final void Function() onClick;

  const CounterCompleteGoalItem({
    Key? key,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(13);
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: onClick,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
          child: Column(
            children: [
              Text(
                "Hedefe ulaşıldı",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                "sıfırlamak için tıklayın",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          )
        ),
      ),
    );
  }
}
