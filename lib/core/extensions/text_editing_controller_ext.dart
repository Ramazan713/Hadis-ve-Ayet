

import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController{

  void setTextWithCursor(String text){
    this.text = text;
    selection = TextSelection.fromPosition(TextPosition(offset: this.text.length));
  }

}