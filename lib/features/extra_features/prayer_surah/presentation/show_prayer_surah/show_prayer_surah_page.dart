import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/detail_prayer_page.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/show_prayer_surah/bloc/show_prayer_state.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/show_prayer_surah/components/show_prayer_item.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';

import 'bloc/show_prayer_bloc.dart';

class ShowPrayerSurahPage extends StatelessWidget {
  static const id = "ShowPrayerSurahPage";
  ShowPrayerSurahPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(
            context,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const CustomSliverAppBar(
                  title: Text("Namaz Duaları ve Ayetleri"),
                  snap: true,
                  floating: true,
                )
              ];
            },
            child: SingleChildScrollView(
              child: BlocBuilder<ShowPrayerBloc,ShowPrayerState>(
                builder: (context,state){

                  if(state.isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final prayers = state.prayers;

                  return ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: prayers.length,
                    itemBuilder: (context,index){
                      final prayer = prayers[index];
                      return ShowPrayerItem(
                        prayer: prayer,
                        onClick: (){
                          Navigator.pushNamed(context,DetailPrayerPage.id,
                              arguments: prayer
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
