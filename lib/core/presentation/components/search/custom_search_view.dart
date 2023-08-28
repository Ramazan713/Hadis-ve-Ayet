
import 'package:flutter/material.dart';

class CustomSearchView extends StatelessWidget {

  final EdgeInsets? margins;
  final EdgeInsets? paddings;
  final String? hintText;
  final TextEditingController? textEditingController;
  final void Function()? onBackClick;

  const CustomSearchView({
    Key? key,
    this.hintText,
    this.margins,
    this.paddings,
    this.textEditingController,
    this.onBackClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final borderRadius =  BorderRadius.circular(19);
    final currentPaddings =  paddings ?? const EdgeInsets.symmetric(horizontal: 8,vertical: 16);
    final currentMargins = margins ?? const EdgeInsets.symmetric(vertical: 1,horizontal: 2);

    return Padding(
      padding: currentMargins,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText ?? "Ara",
          contentPadding: currentPaddings,
          filled: true,
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none
          ),
          prefixIcon: IconButton(
            onPressed: onBackClick,
            icon: const Icon(Icons.arrow_back)
          ),
          suffixIcon: IconButton(
            onPressed: (){
              textEditingController?.clear();
            },
            icon: const Icon(Icons.clear)
          )
        ),
      ),
    );
  }
}
