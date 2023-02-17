import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';

class EsmaulHusnaItem extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final double fontSize;
  final Function()onClick;
  const EsmaulHusnaItem({Key? key,required this.esmaulHusna,
    required this.onClick,required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
              Text(esmaulHusna.order.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: fontSize - 3
                ),
              ),
              getArabicContentWidget(esmaulHusna.arabicName,fontSize + 13,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center
              ),
              Text(esmaulHusna.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: fontSize + 3
                  ),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 9,),
              Text(esmaulHusna.meaning,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: fontSize - 1
                ),
              ),
              const SizedBox(height: 3,),
            ],
          ),
        ),
      ),
    );
  }
}
