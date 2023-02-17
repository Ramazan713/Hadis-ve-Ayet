import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/dialogs/show_select_verse_ui_3x.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/widgets/menu_button.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../domain/model/quran_prayer.dart';
import 'bloc/show_quran_prayer_bloc.dart';
import 'bloc/show_quran_prayer_event.dart';
import 'bloc/show_quran_prayer_state.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';

import 'components/show_quran_prayer_item.dart';
import 'constant/show_quran_prayer_menu_enum.dart';

class ShowQuranPrayerPage extends StatelessWidget {
  static const id = "ShowQuranPrayerPage";

  ShowQuranPrayerPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowQuranPrayerBloc>();
    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(
            context,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                CustomSliverAppBar(
                  snap: true,
                  floating: true,
                  title: const Text("Kuranda geçen dua ayetleri"),
                  actions: [
                    IconButton(
                      onPressed: () async{
                          showSelectVerseUi2X(context,
                            callback: (selected){
                              bloc.add(ShowQuranPrayerEventSetUi(verseUIEnum: selected));
                            },
                            prefKeyType: PrefConstants.quranPrayerVerseUi
                          );
                      },
                      icon: const Icon(Icons.view_agenda),
                      tooltip: "Görünümü Değiştir",
                    ),
                    MenuButton<ShowQuranPrayerMenuEnum>(
                      items: ShowQuranPrayerMenuEnum.values.map((e){
                        return MenuModel(label: e.label, value: e,iconData: e.iconData);
                      }).toList(),
                      selectedFunc: (selected){
                        switch(selected){
                          case ShowQuranPrayerMenuEnum.selectFontSize:
                            showSelectFontSizeBottomDia(context);
                            break;
                        }
                      },
                    )
                  ],
                )
              ];
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                    child: Text("Kuranda geçen bazı dua ayetleri",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  BlocBuilder<ShowQuranPrayerBloc,ShowQuranPrayerState>(
                    builder: (context,state){
                      if(state.isLoading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final items = state.items;
                      if(items.isEmpty){
                        return const Text("empty");
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: items.length,
                        itemBuilder: (context,index){
                          final item = items[index];
                          return ShowQuranPrayerItem(
                            fontSize: state.fontSize.size,
                            prayerItem: item,
                            order: index + 1,
                            verseUIEnum: state.verseUi,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}








