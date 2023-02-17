import 'package:flutter/material.dart';



class InputTextItem extends StatelessWidget {
  final String name;
  final TextEditingController textEditingController;
  final int maxLines;
  final String? hintText;
  final TextInputType inputType;
  final String? fontFamily;
  final TextDirection? textDirection;
  final int plusFontSize;
  const InputTextItem({Key? key,required this.name,required this.textEditingController,
    this.maxLines=1,this.inputType = TextInputType.text,this.hintText,
    this.fontFamily,this.textDirection, this.plusFontSize = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Text(name,
                    style: Theme.of(context).textTheme.bodyLarge)),
            TextField(
              controller: textEditingController,
              maxLines: maxLines,
              keyboardType: inputType,
              textDirection: textDirection,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontFamily: fontFamily,
                fontSize: (Theme.of(context).textTheme.bodyLarge?.fontSize??17) + plusFontSize
              ),
              decoration:  InputDecoration(
                  isDense: true,
                  hintText: hintText,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 9, horizontal: 13)),
            )
          ],
        ),
      ),
    );
  }
}