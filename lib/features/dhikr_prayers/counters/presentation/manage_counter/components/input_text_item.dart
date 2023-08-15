import 'package:flutter/material.dart';



class InputTextItem extends StatelessWidget {
  final String name;
  final TextEditingController textEditingController;
  final int maxLines;
  final int minLines;
  final String? hintText;
  final TextInputType? inputType;
  final String? fontFamily;
  final TextDirection? textDirection;
  final int plusFontSize;
  final TextInputAction? textInputAction;

  const InputTextItem({
    Key? key,
    required this.name,
    required this.textEditingController,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputType,
    this.hintText,
    this.fontFamily,
    this.textDirection,
    this.plusFontSize = 0,
    this.textInputAction
  }) : super(key: key);

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
              minLines: minLines,
              keyboardType: inputType,
              textDirection: textDirection,
              textInputAction: textInputAction,
              onSubmitted: (_){
                if(textInputAction == TextInputAction.next){
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontFamily: fontFamily,
                fontSize: (Theme.of(context).textTheme.bodyLarge?.fontSize??17) + plusFontSize
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
                suffixIcon: IconButton(
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    textEditingController.clear();
                  },
                  icon: const Icon(Icons.clear)
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}