import 'package:flutter/material.dart';


class CustomButtonNegative extends StatelessWidget {
  final void Function()?onTap;
  final String? label;
  const CustomButtonNegative({Key? key,required this.onTap,this.label="Iptal"}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          onPressed: onTap,
          child: Text(label??"Iptal",style: TextStyle(

          ),),
          style: Theme.of(context).textButtonTheme.style?.copyWith(

          )
      ),
    );
  }
}
