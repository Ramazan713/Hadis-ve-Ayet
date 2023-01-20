

import 'package:flutter/material.dart';

class SnackUtils{

  static void showMessage(BuildContext context,SnackBar snackBar){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}