import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';


class DetailEsmaulHusnaRepaintItem extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final FontModel fontModel;
  final GlobalKey repaintKey;

  const DetailEsmaulHusnaRepaintItem({
    Key? key,
    required this.repaintKey,
    required this.esmaulHusna,
    required this.fontModel,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: _DetailEsmaulHusnaShared(
        esmaulHusna: esmaulHusna,
        fontModel: fontModel,
        useForShare: true,
      ),
    );
  }
}


class DetailEsmaulHusna extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final void Function() onSaveAsDhikr;
  final void Function() onGotoDhikr;
  final FontModel fontModel;

  const DetailEsmaulHusna({
    Key? key,
    required this.esmaulHusna,
    required this.fontModel,
    required this.onGotoDhikr,
    required this.onSaveAsDhikr,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DetailEsmaulHusnaShared(
      esmaulHusna: esmaulHusna,
      fontModel: fontModel,
      onGotoDhikr: onGotoDhikr,
      onSaveAsDhikr: onSaveAsDhikr,
      useForShare: false,
    );
  }
}



class _DetailEsmaulHusnaShared extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final void Function()? onSaveAsDhikr;
  final void Function()? onGotoDhikr;
  final FontModel fontModel;
  final bool useForShare;

  const _DetailEsmaulHusnaShared({
    Key? key,
    required this.esmaulHusna,
    required this.fontModel,
    this.onGotoDhikr,
    this.onSaveAsDhikr,
    this.useForShare = false
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getHeader(context),
              const SizedBox(height: 32,),
              getButton(context),
              TitleSectionItem(
                title: "Açıklaması",
                contentFontSize: fontModel.contentFontSize,
                content: esmaulHusna.meaning,
                useDefaultColor: true,
                elevation: 3,
                useCard: !useForShare,
              ),
              const SizedBox(height: 16,),

              getDhikrContent(context),
              const SizedBox(height: 32,),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Column(
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
        Text(
          esmaulHusna.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: fontModel.contentFontSize
          ),
        ),
      ],
    );
  }

  Widget getButton(BuildContext context){
    if(useForShare == true) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerRight,
      child: CustomAnimatedSwitcher(
        firstChild: OutlinedButton.icon(
          onPressed: onGotoDhikr,
          icon: const Icon(Icons.open_in_new),
          label: const Text("Zikre devam et"),
        ),
        secondChild: OutlinedButton.icon(
          onPressed: onSaveAsDhikr,
          icon: const Icon(Icons.add_box),
          label: const Text("Zikir olarak kaydet"),
        ),
        showFirstChild: esmaulHusna.counterId != null,
      ),
    );
  }

  Widget getDhikrContent(BuildContext context){
    return TitleSectionChild(
      title: "Zikir",
      contentFontSize: fontModel.contentFontSize,
      useDefaultColor: true,
      elevation: 3,
      useCard: !useForShare,
      content: Column(
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
    );
  }

}