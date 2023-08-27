

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';

bool _isLoading = false;

void showFullLoadingDia(BuildContext context,{
  required bool showLoading
}){

  if(!_isLoading && showLoading){
    _isLoading = true;
  }

  if(_isLoading && !showLoading){
    _isLoading = false;
    Navigator.of(context,rootNavigator: true).pop();
  }

  if(_isLoading){
    duplicateDialogHandler(func: ()async{
      showModalBottomSheet(context: context,
          isScrollControlled: true,
          isDismissible: false,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          builder: (context){
            return WillPopScope(
              onWillPop: (){
                return Future.value(false);
              },
              child: DraggableScrollableSheet(
                maxChildSize: 1,
                builder: (context,scrollController){
                  return const Column(
                    children: [
                      Center(child: CircularProgressIndicator(),)
                    ],
                  );
                },),
            );
          }).then((value){
        _isLoading=false;
      });
    });
  }
}