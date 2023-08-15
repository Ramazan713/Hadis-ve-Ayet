

import 'package:flutter/material.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showSelectSlider(BuildContext context,{
  required double value,
  required double min,
  required double max,
  void Function(double)? onChange,
  void Function(double)? onClose,
  required String title
}){

  final ValueNotifier<double> valueNotifier = ValueNotifier(value);

  showDialog(
      context: context,
      useSafeArea: true,
      builder: (context){
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 9),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 3),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: ValueListenableBuilder<double>(
                      valueListenable:  valueNotifier,
                      builder: (context,value,child){
                        return Column(
                          children: [
                            Slider(
                                value: value,
                                min: min,
                                max: max,
                                onChanged: (newValue){
                                   valueNotifier.value = newValue;
                                }
                            ),
                            Text(value.toStringAsFixed(1),style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomButtonPositive(
                      onTap: (){
                        onClose?.call(valueNotifier.value);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
  ).then((value){
    onClose?.call( valueNotifier.value);
  });
}