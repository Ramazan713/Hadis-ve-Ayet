import 'package:flutter/material.dart';


class ProgressContent extends StatelessWidget {
  final int current;
  final int total;
  const ProgressContent({Key? key,required this.current,required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rate = current / total;
    final rateInPercentileText = (rate * 100).toStringAsFixed(1);

    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(value: rate, minHeight: 20),
        Text("%$rateInPercentileText", textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)
      ],
    );
  }
}
