import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';

class EsmaulHusnaRepaintItem extends StatelessWidget {

  final GlobalKey repaintKey;
  final EsmaulHusna esmaulHusna;
  final FontModel fontModel;

  const EsmaulHusnaRepaintItem({
    Key? key,
    required this.repaintKey,
    required this.esmaulHusna,
    required this.fontModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: _SharedEsmaulHusnaItem(
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        esmaulHusna: esmaulHusna,
        fontModel: fontModel,
        useForShare: true,
      ),
    );
  }
}

class EsmaulHusnaItem extends StatelessWidget {

  final EsmaulHusna esmaulHusna;
  final FontModel fontModel;
  final void Function() onClick;
  final void Function() onShareClick;
  final bool isSelected;
  final EdgeInsets? margin;

  const EsmaulHusnaItem({
    Key? key,
    required this.esmaulHusna,
    required this.fontModel,
    required this.onClick,
    required this.onShareClick,
    this.isSelected = false,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SharedEsmaulHusnaItem(
      esmaulHusna: esmaulHusna,
      fontModel: fontModel,
      useForShare: false,
      onClick: onClick,
      onShareClick: onShareClick,
      isSelected: isSelected,
    );
  }
}


class _SharedEsmaulHusnaItem extends StatelessWidget {
  final EsmaulHusna esmaulHusna;
  final FontModel fontModel;
  final void Function()? onClick;
  final void Function()? onShareClick;
  final bool useForShare;
  final bool isSelected;
  final EdgeInsets? margin;

  const _SharedEsmaulHusnaItem({
    Key? key,
    required this.esmaulHusna,
    required this.fontModel,
    this.isSelected = false,
    this.useForShare = false,
    this.onClick,
    this.onShareClick,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final contentStyle = Theme.of(context).textTheme.bodyLarge;
    final selectedColor = isSelected ? Theme.of(context).colorScheme.secondaryContainer:
      Theme.of(context).colorScheme.surface;

    return Card(
      margin: margin ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      color: selectedColor,
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getHeader(context),
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

  Widget getHeader(BuildContext context){
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            esmaulHusna.order.toString(),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: fontModel.contentFontSize - 3
            ),
          ),
        ),
        if(!useForShare)Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onShareClick,
            icon: const Icon(Icons.share),
          ),
        )
      ],
    );
  }
}
