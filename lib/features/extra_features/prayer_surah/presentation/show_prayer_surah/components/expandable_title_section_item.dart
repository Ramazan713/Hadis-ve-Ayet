

import 'package:flutter/material.dart';

class ExpandableTitleSectionItem extends StatelessWidget{

  final String title;
  final Widget child;
  final bool isExpanded;
  final Function(bool) onClickExpand;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleTextStyle;
  const ExpandableTitleSectionItem({Key? key,required this.title,required this.child,
    this.margin,required this.isExpanded,required this.onClickExpand,this.titleTextStyle}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin??EdgeInsets.zero,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13),
            side: BorderSide(width: 2,color: Theme.of(context).primaryColorDark)
        ),
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Padding(
          padding: const EdgeInsets.only(left: 11,right: 11,bottom: 11,top: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: (){onClickExpand(!isExpanded);},
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: EdgeInsets.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 11,top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                        style: titleTextStyle??Theme.of(context).textTheme.titleLarge,
                      ),
                      Icon(isExpanded?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: isExpanded,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: child,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}