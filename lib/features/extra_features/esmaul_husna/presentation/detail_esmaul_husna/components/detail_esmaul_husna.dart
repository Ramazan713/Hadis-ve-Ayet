import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/title_section_item.dart';


class DetailEsmaulHusna extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final Function() onSaveAsDhikr;
  final Function() onGotoDhikr;
  final double fontSize;
  const DetailEsmaulHusna({Key? key,required this.esmaulHusna,
    required this.onGotoDhikr,required this.onSaveAsDhikr,
    required this.fontSize
  }) :
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(esmaulHusna.order.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: fontSize - 3
                ),
              ),
              getArabicContentWidget(esmaulHusna.arabicName,fontSize + 23,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge
              ),
              const SizedBox(height: 8,),
              Text(esmaulHusna.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: fontSize + 7
                ),
              ),
              const SizedBox(height: 32,),
              TitleSectionItem(
                title: "Açıklaması",
                titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: fontSize
                ),
                child: Text(esmaulHusna.meaning,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: fontSize
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TitleSectionItem(
                  title: "Zikir",
                  titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: fontSize
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(esmaulHusna.virtue,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: fontSize
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Text("${esmaulHusna.dhikr} adet",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: fontSize
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 32,),
              CustomButtonPositive(
                label: "Zikir'e başla",
                onTap: onGotoDhikr,
              ),
              const SizedBox(height: 16,),
              CustomButtonPositive(
                label: "Zikir olarak kaydet",
                onTap: onSaveAsDhikr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}