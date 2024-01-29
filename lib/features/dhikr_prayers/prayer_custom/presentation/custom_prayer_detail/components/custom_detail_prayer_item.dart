import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

class CustomPrayerDetailItem extends StatelessWidget {
  final PrayerUnit<PrayerCustom>? prayerUnit;
  final FontModel fontModel;
  final WindowSizeClass windowSizeClass;

  const CustomPrayerDetailItem({
    super.key,
    required this.prayerUnit,
    required this.fontModel,
    required this.windowSizeClass
  });

  PrayerCustom? get prayer => prayerUnit?.item;
  bool get expandable => true;
  bool get useCard => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getPrayerName(context),
        getListenItem(context),
        getContentItems()
      ],
    );
  }

  Widget getListenItem(BuildContext context){
    final verseIds = prayerUnit?.getVerseIds;
    if(verseIds == null || verseIds.isEmpty == true) return const SizedBox.shrink();
    final audioBloc = context.read<BasicAudioBloc>();
    return Padding(
      padding: const EdgeInsets.only(right: 4,bottom: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: FilledButton(
          onPressed: (){
            audioBloc.add(BasicAudioEventStartWithCustomVerseIds(verseIds: verseIds??[]));
          },
          child: const Text("Dinle"),
        ),
      ),
    );
  }

  Widget getPrayerName(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8,top: 16,left: 8),
      child: Text(
        prayer?.name ?? '',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget getContentItems(){
    final axisCount = windowSizeClass.isExpanded ? 2 : 1;
    return StaggeredGrid.count(
      crossAxisCount: axisCount,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        getArabicContentItem(),
        getPronunciationContentItem(),
        getMeaningContentItem(),
        getSourceContentItem(),
      ],
    );
  }


  Widget getArabicContentItem(){
    if(prayer?.hasArabicContent == false) return const SizedBox.shrink();
    return TitleSectionChild(
        title: "Arapça İçerik",
        expandable: expandable,
        initExpand: true,
        useDefaultColor: true,
        useCard: useCard,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: ArabicContentItem(
          content: prayer?.arabicContent ?? "",
          fontSize: fontModel.arabicFontSize,
          fontFamily: fontModel.arabicFontFamilyEnum,
        )
    );
  }

  Widget getPronunciationContentItem(){
    if(prayer?.hasContent == false) return const SizedBox();
    return TitleSectionItem(
        title: "Okunuşu",
        expandable: expandable,
        initExpand: true,
        useDefaultColor: true,
        useCard: useCard,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer?.pronunciationContent ?? ""
    );
  }

  Widget getMeaningContentItem(){
    if(prayer?.hasMeaning == false) return const SizedBox.shrink();
    return TitleSectionItem(
        title: "Anlamı",
        expandable: expandable,
        initExpand: true,
        useDefaultColor: true,
        useCard: useCard,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer?.meaningContent ?? ""
    );
  }

  Widget getSourceContentItem(){
    if(prayer?.hasSource == false) return const SizedBox.shrink();
    return TitleSectionItem(
        title: "Kaynak",
        expandable: expandable,
        initExpand: true,
        useDefaultColor: true,
        useCard: useCard,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer?.source ?? ""
    );
  }
}
