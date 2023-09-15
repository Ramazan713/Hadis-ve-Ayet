import 'package:flutter/material.dart';


void showPreviewSharedImageDia(BuildContext context,{
  required Widget previewWidget,
  required Function()onTap
}){

  showDialog(
    context: context,
    builder: (context){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 7),
        child: _DialogContent(
          previewWidget: previewWidget,
          onShareClick: onTap,
          onNavigateBack: (){
            Navigator.pop(context);
          },
        ),
      );
    }
  );
}


class _DialogContent extends StatelessWidget {

  final Widget previewWidget;
  final void Function() onShareClick;
  final void Function() onNavigateBack;

  const _DialogContent({
    super.key,
    required this.previewWidget,
    required this.onShareClick,
    required this.onNavigateBack
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getHeader(context),
          const SizedBox(height: 4,),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  previewWidget,
                ],
              ),
            ),
          ),
          const SizedBox(height: 4,),
          FilledButton.tonal(
            onPressed: onShareClick,
            child: const Text("Paylaş"),
          ),
        ],
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text("Paylaşılacak Olan Resim",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onNavigateBack,
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }

}


