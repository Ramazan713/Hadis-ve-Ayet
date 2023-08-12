
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/expandable_title_section_item.dart';
import 'package:hadith/core/presentation/components/title_text_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
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
        .add(PrayerDetailEventLoadData(prayerId: prayerId));

    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: Text("Detail Page"),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  getNameItem(),
                  getArabicContentItem(),
                  getPronunciationContentItem(),
                  getMeaningContentItem(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget getNameItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState>(
        buildWhen: (prevState, nextState){
          return prevState.fontModel != nextState.fontModel ||
              prevState.prayer != nextState.prayer;
        },
        builder: (context,state){
          return TitleTextItem(
            title: "İsim:",
            content: state.prayer?.name ?? "",
            margin: const EdgeInsets.symmetric(vertical: 5),
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: state.fontModel.contentFontSize
            ),
            contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: state.fontModel.contentFontSize
            ),
          );
        }
      ),
    );
  }

  Widget getArabicContentItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: BlocSelector<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState,_SelectorItem>(
        selector: (state) => _SelectorItem.from(expanded: state.isExpandedArabic, state: state),
        builder: (context,state){
          return ExpandableTitleSectionItem(
            title: "Arapça İçerik",
            isExpanded: state.expanded,
            onClickExpand: (expanded){
              context.read<PrayerAndVerseDetailBloc>()
                  .add(PrayerDetailEventSetVisibilityArabic(isVisible: expanded));
            },
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: state.fontModel.contentFontSize
            ),
            child: ArabicContentItem(
                content: state.prayer?.arabicContent??"",
                fontSize: state.fontModel.arabicFontSize,
                fontFamily: state.fontModel.arabicFontFamilyEnum,
            ),
            // child: getArabicContentWidget(prayerArg.arabicContent,state.isExpandedArabic,
            //     textAlign: TextAlign.end
            // ),
          );
        },
      ),
    );
  }

  Widget getPronunciationContentItem(){
    return BlocSelector<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState,_SelectorItem>(
      selector: (state)=> _SelectorItem.from(expanded: state.isExpandedPronunciation, state: state),
      builder: (context,stateSelector){
        if(stateSelector.prayer?.pronunciationContent == null) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ExpandableTitleSectionItem(
            title: "Okunuşu",
            isExpanded: stateSelector.expanded,
            onClickExpand: (expanded){
              context.read<PrayerAndVerseDetailBloc>()
                  .add(PrayerDetailEventSetVisibilityPronunciation(isVisible: expanded));
            },
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: stateSelector.fontModel.contentFontSize
            ),
            child: Text(stateSelector.prayer?.pronunciationContent ?? "",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: stateSelector.fontModel.contentFontSize),
            ),
          ),
        );
      },
    );
  }

  Widget getMeaningContentItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: BlocSelector<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState,_SelectorItem>(
        selector: (state)=> _SelectorItem.from(expanded: state.isExpandedMeaning, state: state),
        builder: (context,stateSelector){
          return ExpandableTitleSectionItem(
            title: "Anlamı",
            isExpanded: stateSelector.expanded,
            onClickExpand: (expanded){
              context.read<PrayerAndVerseDetailBloc>()
                  .add(PrayerDetailEventSetVisibilityMeaning(isVisible: expanded));
            },
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: stateSelector.fontModel.contentFontSize
            ),
            child: Text(stateSelector.prayer?.meaningContent ?? "",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: stateSelector.fontModel.contentFontSize),
            ),
          );
        },
      ),
    );
  }
}


class _SelectorItem extends Equatable{
  final FontModel fontModel;
  final bool expanded;
  final PrayerAndVerse? prayer;

  const _SelectorItem({required this.fontModel, required this.expanded, required this.prayer});

  static _SelectorItem from({required bool expanded, required PrayerAndVerseDetailState state}){
    return _SelectorItem(fontModel: state.fontModel, expanded: expanded, prayer: state.prayer);
  }

  @override
  List<Object?> get props => [fontModel, expanded, prayer];
}

