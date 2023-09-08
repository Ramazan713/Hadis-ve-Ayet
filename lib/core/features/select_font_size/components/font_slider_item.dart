

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';

class FontSliderItem extends StatelessWidget {
  final String title;
  final FontSizeEnum currentValue;
  final void Function(FontSizeEnum) onChanged;

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
                flex: 4,
                child: SliderTheme(
                  data: const SliderThemeData(
                    showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                  ),
                  child: Slider(
                    value: currentValue.enumValue.toDouble(),
                    onChanged: (newValue){
                      onChanged(FontSizeEnum.from(newValue.toInt()));
                    },
                    min: FontSizeEnum.values.map((e) => e.enumValue).min.toDouble(),
                    max:  FontSizeEnum.values.map((e) => e.enumValue).max.toDouble(),
                    label: currentValue.description,
                    divisions: FontSizeEnum.values.length - 1,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  currentValue.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
