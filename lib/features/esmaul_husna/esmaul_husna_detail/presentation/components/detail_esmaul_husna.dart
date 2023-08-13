import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/title_section_item.dart';


class DetailEsmaulHusna extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final void Function() onSaveAsDhikr;
  final void Function() onGotoDhikr;
  final FontModel fontModel;

  const DetailEsmaulHusna({
    Key? key,
    required this.esmaulHusna,
    required this.onGotoDhikr,
    required this.onSaveAsDhikr,
    required this.fontModel
  }) :super(key: key);

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
                    fontSize: fontModel.contentFontSize - 3
                ),
              ),
              ArabicContentItem(
                content: esmaulHusna.arabicName,
                fontSize: fontModel.arabicFontSize + 13,
                fontFamily: fontModel.arabicFontFamilyEnum,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8,),

              Text(esmaulHusna.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: fontModel.contentFontSize
                ),
              ),
              const SizedBox(height: 32,),
              TitleSectionItem(
                title: "Açıklaması",
                titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: fontModel.contentFontSize
                ),
                child: Text(esmaulHusna.meaning,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: fontModel.contentFontSize
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TitleSectionItem(
                  title: "Zikir",
                  titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: fontModel.contentFontSize
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(esmaulHusna.virtue,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: fontModel.contentFontSize
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Text("${esmaulHusna.dhikr} adet",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: fontModel.contentFontSize
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