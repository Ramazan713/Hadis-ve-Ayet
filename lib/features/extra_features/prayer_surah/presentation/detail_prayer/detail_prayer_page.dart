import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/bloc/detail_prayer_bloc.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/bloc/detail_prayer_state.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/constants/detail_prayer_menu_item.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/prayer_state_selector.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/show_prayer_surah/components/expandable_title_section_item.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/widgets/menu_button.dart';
import 'package:hadith/widgets/title_section_item.dart';
import 'package:hadith/widgets/title_text_item.dart';

import 'bloc/detail_prayer_event.dart';

class DetailPrayerPage extends StatelessWidget {
  static const id = "DetailPrayerPage";

  const DetailPrayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Prayer? prayerArg = (ModalRoute.of(context)?.settings.arguments as Prayer?);
    if(prayerArg==null) {
      return const Text("empty");
    }

    final bloc = context.read<DetailPrayerBloc>();
    bloc.add(DetailPrayerEventInitExpanding());

    return BlocListener<DetailPrayerBloc,DetailPrayerState>(
      listener: (context,state){
        if(state.message!=null){
          ToastUtils.showLongToast(state.message??"");
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(
            context,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                CustomSliverAppBar(
                  title: Text(prayerArg.name),
                  actions: [
                    MenuButton(
                      items: DetailPrayerMenuItem.values.map((e){
                        return MenuModel(label: e.label, value: e,iconData: e.iconData);
                      }).toList(),
                      selectedFunc: (selected){
                        switch(selected){
                          case DetailPrayerMenuItem.fontSize:
                            showSelectFontSizeBottomDia(context);
                            break;
                          case DetailPrayerMenuItem.addCounter:
                            bloc.add(DetailPrayerEventAddCounter(prayer: prayerArg));
                            break;
                        }
                      },
                    )
                  ],
                )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocSelector<DetailPrayerBloc,DetailPrayerState,double>(
                        selector: (state)=> state.fontSize,
                        builder: (context,fontSize){
                          return TitleTextItem(
                            title: "İsim:",
                            content: prayerArg.name,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: fontSize + 2
                            ),
                            contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: fontSize
                            ),
                          );
                        }
                    ),
                    const SizedBox(height: 16,),

                    BlocSelector<DetailPrayerBloc,DetailPrayerState,PrayerStateSelector>(
                      selector: (state)=>PrayerStateSelector(expanded: state.isExpandedArabic,
                          fontSize: state.fontSize),
                      builder: (context,stateSelector){
                        return ExpandableTitleSectionItem(
                          title: "Arapça İçerik",
                          isExpanded: stateSelector.expanded,
                          onClickExpand: (expanded){
                            bloc.add(DetailPrayerEventVisibilityArabic(isVisible: expanded));
                          },
                          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: stateSelector.fontSize + 2
                          ),
                          child: getArabicContentWidget(prayerArg.arabicContent,stateSelector.fontSize,
                              textAlign: TextAlign.end
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8,),

                    prayerArg.pronunciationContent!=null?
                      Column(
                        children: [
                          BlocSelector<DetailPrayerBloc,DetailPrayerState,PrayerStateSelector>(
                            selector: (state)=>PrayerStateSelector(expanded: state.isExpandedPronunciation,
                                fontSize: state.fontSize),
                            builder: (context,stateSelector){
                              return ExpandableTitleSectionItem(
                                title: "Okunuşu",
                                isExpanded: stateSelector.expanded,
                                onClickExpand: (expanded){
                                  bloc.add(DetailPrayerEventVisibilityPronunciation(isVisible: expanded));
                                },
                                titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: stateSelector.fontSize + 2
                                ),
                                child: Text(prayerArg.pronunciationContent??"",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: stateSelector.fontSize),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8,),
                        ],
                      ): const SizedBox(),

                    BlocSelector<DetailPrayerBloc,DetailPrayerState,PrayerStateSelector>(
                      selector: (state)=>PrayerStateSelector(expanded: state.isExpandedMeaning,
                          fontSize: state.fontSize),
                      builder: (context,stateSelector){
                        return ExpandableTitleSectionItem(
                          title: "Anlamı",
                          isExpanded: stateSelector.expanded,
                          onClickExpand: (expanded){
                            bloc.add(DetailPrayerEventVisibilityMeaning(isVisible: expanded));
                          },
                          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: stateSelector.fontSize + 2
                          ),
                          child: Text(prayerArg.meaningContent,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: stateSelector.fontSize),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
