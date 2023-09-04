import 'package:flutter/material.dart';


class ProgressRateContent extends StatelessWidget {

  final double? rate;
  final String? description;

  const ProgressRateContent({
    super.key,
    this.rate,
    this.description
  });

  @override
  Widget build(BuildContext context) {

    final colorSchema = Theme.of(context).colorScheme;

    final rateInPercentileText = (rateOrDefault * 100).toStringAsFixed(1);
    final textColor = rateOrDefault >= 0.5 ? colorSchema.onPrimaryContainer : colorSchema.primary;
    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(
          value: rate,
          minHeight: 20,
          color: colorSchema.primaryContainer,
        ),
        Text(
          "%$rateInPercentileText ${getDescription()}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor
          ),
        )
      ],
    );
  }

  double get rateOrDefault => rate ?? 0.0;

  String getDescription(){
    if(description == null) return "";
    return "($description)";
  }
}



class ProgressContent extends StatelessWidget {
  final int current;
  final int total;
  final String? description;

  const ProgressContent({
    Key? key,
    required this.current,
    required this.total,
    this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rate = current / total;
    return ProgressRateContent(
      rate: rate,
      description: description,
    );
  }
}
