import 'package:flutter/material.dart';
import 'package:hadith/utils/theme_util.dart';

class CustomButtonPositive extends StatelessWidget {
  final void Function()?onTap;
  final String? label;
  final bool enabled;
  const CustomButtonPositive({Key? key, required this.onTap,this.label="Onayla",
    this.enabled = true
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    final buttonStyle=ThemeUtil.getThemeModel(context).positiveButtonStyle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          onPressed: enabled?onTap:null,
          style: TextButton.styleFrom(
            backgroundColor: buttonStyle.backgroundColor,
          ),
          child: Text(label??"Onayla",
            style: TextStyle(
              fontSize: buttonStyle.fontSize,
              fontWeight: buttonStyle.fontWeight,
              color: buttonStyle.textColor,
            ),
            textAlign: TextAlign.center,
          ),
      ),
    );
  }
}
