

import 'package:flutter/material.dart';

void showVerseInfoDia(BuildContext context,{
  required String title,
  required String content
}){

  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context){
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Ok"),
          )
        ],
      );
    }
  );
}