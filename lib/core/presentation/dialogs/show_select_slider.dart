

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';

void showSelectSlider(BuildContext context,{
  required double value,
  required double min,
  required double max,
  void Function(double)? onApprove,
  void Function()? onClose,
  required String title
}){

  final ValueNotifier<double> valueNotifier = ValueNotifier(value);

  Widget getTitle(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      )
    );
  }

  Widget getButtons(){
    return SharedDiaButtons(
      onCancel: onClose ?? (){
        Navigator.of(context,rootNavigator: true).pop();
      },
      onApprove: (){
        onApprove?.call(valueNotifier.value);
        Navigator.of(context,rootNavigator: true).pop();
      },
    );
  }

  Widget getSliderContent(){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: ValueListenableBuilder<double>(
        valueListenable: valueNotifier,
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
              Text(
                value.toStringAsFixed(1),
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }


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
                mainAxisSize: MainAxisSize.min,
                children: [
                  getTitle(),
                  getSliderContent(),
                  getButtons()
                ],
              ),
            ),
          ),
        );
      }
  );
}