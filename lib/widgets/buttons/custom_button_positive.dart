import 'package:flutter/material.dart';

class CustomButtonPositive extends StatelessWidget {
  final void Function()?onTap;
  final String? label;
  final bool enabled;
  const CustomButtonPositive({Key? key, required this.onTap,this.label="Onayla",
    this.enabled = true
  }): super(key: key);

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          onPressed: enabled?onTap:null,
          style: TextButton.styleFrom(
          ),
          child: Text(label??"Onayla",
            style: TextStyle(

            ),
            textAlign: TextAlign.center,
          ),
      ),
    );
  }
}
