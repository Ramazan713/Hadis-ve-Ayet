
import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/bloc/custom_prayer_detail_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/custom_prayer_detail_page.dart';

extension CustomPrayerDetailPageContentsExt on CustomPrayerDetailPage{

  Widget getContentItems({ required CustomPrayerDetailState state,}){

    return Column(
      children: [
        getArabicContentItem(state: state),
        if(state.hasArabicContent)const SizedBox(height: 8,),

        getPronunciationContentItem(state: state),
        if(state.hasContent)const SizedBox(height: 8,),

        getMeaningContentItem(state: state),
        if(state.hasMeaning)const SizedBox(height: 8,),

        getSourceContentItem(state: state),
        const SizedBox(height: 8,),
      ],
    );
  }


  Widget getArabicContentItem({
    required CustomPrayerDetailState state,
  }){
    if(!state.hasArabicContent) return const SizedBox.shrink();
    return TitleSectionChild(
        title: "Arapça İçerik",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: state.fontModel.contentFontSize,
        elevation: 3,
        content: ArabicContentItem(
          content: state.prayer?.arabicContent ?? "",
          fontSize: state.fontModel.arabicFontSize,
          fontFamily: state.fontModel.arabicFontFamilyEnum,
        )
    );
  }

  Widget getPronunciationContentItem({
    required CustomPrayerDetailState state
  }){
    if(!state.hasContent) return const SizedBox();
    return TitleSectionItem(
        title: "Okunuşu",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: state.fontModel.contentFontSize,
        elevation: 3,
        content: state.prayer?.pronunciationContent ?? ""
    );
  }

  Widget getMeaningContentItem({
    required CustomPrayerDetailState state
  }){
    if(!state.hasMeaning) return const SizedBox.shrink();
    return TitleSectionItem(
        title: "Anlamı",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: state.fontModel.contentFontSize,
        elevation: 3,
        content: state.prayer?.meaningContent ?? ""
    );
  }

  Widget getSourceContentItem({
    required CustomPrayerDetailState state
  }){
    if(!state.hasSource) return const SizedBox.shrink();
    return TitleSectionItem(
        title: "Kaynak",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: state.fontModel.contentFontSize,
        elevation: 3,
        content: state.prayer?.source ?? ""
    );
  }

}