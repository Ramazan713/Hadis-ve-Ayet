

import 'package:flutter/material.dart';


class CustomButton1 extends StatelessWidget {
  final void Function()?onTap;
  final String label;
  const CustomButton1({Key? key, required this.onTap,this.label="Onayla"}): super(key: key);

  @override
  Widget build(BuildContext context) {

    //final buttonStyle=ThemeUtil.getThemeModel(context).buttonStyle2();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          onPressed: onTap,
          child: Text(label,style: TextStyle(

          ),),
          style: Theme.of(context).textButtonTheme.style?.copyWith(

          )
      ),
    );
  }
}