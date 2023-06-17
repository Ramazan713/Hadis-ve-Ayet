import 'package:flutter/material.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';


void showPreviewSharedImageDia(
    BuildContext context,
{
  required Widget previewWidget,
  required Function()onTap
}){

  showDialog(context: context, builder: (context){

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 7),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 13,),
              Text("Paylaşılacak Olan Resim",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 13,),
              previewWidget,
              const SizedBox(height: 13,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomButtonNegative(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      label: "Iptal",
                    ),
                  ),
                  Expanded(
                    child: CustomButtonPositive(
                      onTap: onTap,
                      label: "Paylaş",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}