
import 'package:flutter/material.dart';

class CustomSearchView extends StatelessWidget {

  final EdgeInsets? margins;
  final EdgeInsets? paddings;
  final String? hintText;
  late final TextEditingController? textEditingController;
  final void Function()? onBackClick;
  final void Function(String text)? onChanged;
  final bool autofocus;
  final FocusNode? focusNode;

  CustomSearchView({
    Key? key,
    this.hintText,
    this.margins,
    this.paddings,
    TextEditingController? textEditingController,
    this.onBackClick,
    this.onChanged,
    this.focusNode,
    this.autofocus = true
  }) : super(key: key){
    this.textEditingController = textEditingController ?? TextEditingController();
  }

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
        autofocus: autofocus,
        onChanged: onChanged,
        focusNode: focusNode,
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
            onPressed: onBackClick ?? (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)
          ),
          suffixIcon: IconButton(
            onPressed: (){
              onChanged?.call("");
              textEditingController?.clear();
            },
            icon: const Icon(Icons.clear)
          )
        ),
      ),
    );
  }
}
