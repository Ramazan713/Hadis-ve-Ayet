import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/extensions/string_ext.dart';
import 'package:hadith/core/features/share/domain/models/share_verse_content/share_verse_content.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';

class ShareVerseContentItem extends StatelessWidget {
  final ShareVerseContent item;
  final FontModel fontModel;
  final GlobalKey repaintKey;
  
  const ShareVerseContentItem({
    super.key,
    required this.item,
    required this.fontModel,
    required this.repaintKey
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getTitleWidget(context),

            getArabicContentItem(),

            getPronunciationContentItem(),

            getMeaningContentItem(),

            getOthers(context)
          ],
        ),
      ),
    );
  }

  Widget getTitleWidget(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8,top: 16,left: 8),
      child: Text(
        item.title ?? '',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }


  Widget getArabicContentItem(){
    final arabicContent = item.arabicContent;
    if(arabicContent.isEmptyString) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TitleSectionChild(
        title: "Arapça İçerik",
        useCard: false,
        contentFontSize: fontModel.contentFontSize,
        content: ArabicContentItem(
          content: arabicContent ?? "",
          fontSize: fontModel.arabicFontSize,
          fontFamily: fontModel.arabicFontFamilyEnum,
        )
      ),
    );
  }

  Widget getPronunciationContentItem(){
    final content = item.content;
    if(content.isEmptyString) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TitleSectionItem(
          title: "Okunuşu",
          useCard: false,
          contentFontSize: fontModel.contentFontSize,
          content: content ?? ""
      ),
    );
  }

  Widget getMeaningContentItem(){
    final meaningContent = item.meaningContent;
    if(meaningContent.isEmptyString) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TitleSectionItem(
        title: "Anlamı",
        useCard: false,
        contentFontSize: fontModel.contentFontSize,
        content: meaningContent ?? ""
      ),
    );
  }

  Widget getOthers(BuildContext context){
    final others = item.others;
    if(others == null || others.isEmpty) return const SizedBox.shrink();
    
    final keys = others.keys.toList();
    return Column(
      children: keys.map((key){
        final value = others[key];
        if(value.isEmptyString) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: TitleSectionItem(
              title: key,
              useCard: false,
              contentFontSize: fontModel.contentFontSize,
              content: value ?? ""
          ),
        );
      }).toList(),
    );
  }
}

