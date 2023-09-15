import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/hadith.dart';

class HadithRepaintItem extends StatelessWidget {

  final Hadith hadith;
  final GlobalKey repaintKey;
  final FontModel fontModel;

  const HadithRepaintItem({
    super.key,
    required this.hadith,
    required this.fontModel,
    required this.repaintKey
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: fontModel.contentFontSize
    );

    return RepaintBoundary(
      key: repaintKey,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 13, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  hadith.content,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
                const SizedBox(
                  height: 13,
                ),
                Text("- ${hadith.source}",
                  textAlign: TextAlign.center,
                  style: textStyle?.copyWith(
                    fontSize: fontModel.contentFontSize - 4
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
