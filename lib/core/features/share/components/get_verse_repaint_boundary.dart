//
//
// import 'package:flutter/material.dart';
//
// RepaintBoundary getVerseRepaintBoundary(
//   BuildContext context,{
//     required GlobalKey<State<StatefulWidget>> globalKey,
//       required bool isProstrationVerse,
//       required String surahName,
//       required String surahContent,
//       required String surahId
// }){
//
//   const double fontSize=18;
//
//
//   final  textStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
//       fontSize: fontSize,fontWeight: verse.isProstrationVerse ? FontWeight.w700 : FontWeight.normal, inherit: true
//   );
//   ArabicVerseUI2X arabicVerseUIEnum=ArabicVerseUI2X.values[sharedPreferences.getInt(PrefConstants.arabicVerseAppearanceEnum.key)
//       ??PrefConstants.arabicVerseAppearanceEnum.defaultValue];
//
//   return RepaintBoundary(
//       key: globalKey,
//       child: Center(
//           child: Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(19),
//               child: Ink(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const SizedBox(height: 3,),
//                       Text(
//                         "${verse.surahId}/${verse.surahName}",
//                         style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: fontSize - 5),
//                       ),
//                       ... getVerseItemContent([TextSpan(text: verse.content)],
//                           item, fontSize, textStyle, arabicVerseUIEnum)
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//       )
//   );
// }