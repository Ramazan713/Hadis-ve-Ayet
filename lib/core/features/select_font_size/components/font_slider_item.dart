

import 'package:flutter/material.dart';
import 'package:hadith/constants/app_constants.dart';

class FontSliderItem extends StatelessWidget {
  final String title;
  final double currentValue;
  final void Function(double) onChanged;

  const FontSliderItem({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.currentValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,style: Theme.of(context).textTheme.titleMedium,),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: currentValue,
                  onChanged: (newValue){
                    onChanged(newValue);
                  },
                  min: kFontSizeMin,
                  max: kFontSizeMax,
                ),
              ),
              Text(currentValue.toStringAsFixed(0),style: Theme.of(context).textTheme.bodyMedium,)
            ],
          )
        ],
      ),
    );
  }
}
