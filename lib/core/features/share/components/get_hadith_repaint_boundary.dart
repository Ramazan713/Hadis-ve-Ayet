import 'package:flutter/material.dart';


Widget getHadithRepaintBoundary(
    BuildContext context,
{
  required String hadithContent,
  required String hadithSource,
  required GlobalKey<State<StatefulWidget>> globalKey
}
){

  const double fontSize=18;

  final  textStyle=Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: fontSize,
      fontWeight: FontWeight.w400,inherit: true);

  return RepaintBoundary(
      key: globalKey,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 13, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Text(
                  hadithContent,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
                const SizedBox(
                  height: 13,
                ),
                Text("- $hadithSource",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: fontSize-4)),
              ],
            ),
          ),
        ),
      )
  );
}
