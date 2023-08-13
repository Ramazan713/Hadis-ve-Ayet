import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';

class EsmaulHusnaItem extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final FontModel fontModel;
  final void Function() onClick;

  const EsmaulHusnaItem({
    Key? key,
    required this.esmaulHusna,
    required this.onClick,
    required this.fontModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final contentStyle = Theme.of(context).textTheme.bodyLarge;

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                esmaulHusna.order.toString(),
                textAlign: TextAlign.start,
                style: contentStyle?.copyWith(
                  fontSize: fontModel.contentFontSize - 3
                ),
              ),
              ArabicContentItem(
                content: esmaulHusna.arabicName,
                fontSize: fontModel.arabicFontSize + 13,
                fontFamily: fontModel.arabicFontFamilyEnum,
                textAlign: TextAlign.center,
              ),
              Text(
                esmaulHusna.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: fontModel.contentFontSize
                ),
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 16,),
              Text(
                esmaulHusna.meaning,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
                style: contentStyle?.copyWith(
                  fontSize: fontModel.contentFontSize
                ),
              ),
              const SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
