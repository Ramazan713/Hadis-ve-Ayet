
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/domain/prayer_and_verse_top_bar_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_event.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';

import 'bloc/prayer_and_verse_detail_state.dart';

class PrayerAndVerseDetailPage extends StatelessWidget {

  final int prayerId;

  const PrayerAndVerseDetailPage({
    Key? key,
    required this.prayerId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<PrayerAndVerseDetailBloc>()
        .add(PrayerAndVerseDetailEventLoadData(prayerId: prayerId));

    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: getTitle(),
          pinned: true,
          actions: getActions(context),
          appBarType: AppBarType.mediumBar,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: BlocBuilder<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState>(
                builder: (context,state){
                  if(state.isLoading){
                    return const SharedLoadingIndicator();
                  }

                  final prayer = state.prayer;
                  final fontModel = state.fontModel;
                  if(prayer == null){
                    return const SharedEmptyResult(
                      content: "herhangi bir sonuç bulunamadı",
                    );
                  }
                  return Column(
                    children: [
                      getArabicContentItem(prayer: prayer, fontModel: fontModel),
                      const SizedBox(height: 8,),
                      getPronunciationContentItem(prayer: prayer, fontModel: fontModel),
                      const SizedBox(height: 8,),
                      getMeaningContentItem(prayer: prayer, fontModel: fontModel),
                      const SizedBox(height: 8,),
                    ],
                  );
                }
              )
            ),
          ),
        ),
      ),
    );
  }


  Widget getTitle(){
    return BlocBuilder<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState>(
      buildWhen: (prevState, nextState){
        return prevState.prayer != nextState.prayer;
      },
      builder: (context,state){
        return Text(state.prayer?.name ?? "");
      }
    );
  }

  Widget getArabicContentItem({
    required PrayerAndVerse prayer,
    required FontModel fontModel
  }){
    return TitleSectionChild(
        title: "Arapça İçerik",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: ArabicContentItem(
          content: prayer.arabicContent,
          fontSize: fontModel.arabicFontSize,
          fontFamily: fontModel.arabicFontFamilyEnum,
        )
    );
  }

  Widget getPronunciationContentItem({
    required PrayerAndVerse prayer,
    required FontModel fontModel
  }){
    if(prayer.pronunciationContent == null) {
      return const SizedBox();
    }
    return TitleSectionItem(
        title: "Okunuşu",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer.pronunciationContent ?? ""
    );
  }

  Widget getMeaningContentItem({
    required PrayerAndVerse prayer,
    required FontModel fontModel
  }){
    return TitleSectionItem(
        title: "Anlamı",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer.meaningContent
    );
  }


  List<Widget> getActions(BuildContext context){
    return [
      CustomDropdownIconMenu(
        items: PrayerAndVerseTopBarMenuItems.values,
        onSelected: (menuItem){
          switch(menuItem){
            case PrayerAndVerseTopBarMenuItems.selectFontSize:
              showSelectFontSizeDia(context);
              break;
          }
        })
    ];
  }

}
