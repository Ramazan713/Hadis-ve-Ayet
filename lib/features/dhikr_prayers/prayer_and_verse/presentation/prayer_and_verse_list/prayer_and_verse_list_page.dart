
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/bloc/prayer_and_verse_list_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/bloc/prayer_and_verse_list_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/component/prayer_and_verse_item.dart';

class PrayerAndVerseListPage extends StatelessWidget {
  const PrayerAndVerseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: Text("Namaz Duaları ve Ayetleri"),
          snap: true,
          floating: true,
          child: Column(
            children: [
             Expanded(
               child: BlocBuilder<PrayerAndVerseListBloc,PrayerAndVerseListState>(
                 builder: (context, state){
                   final items = state.items;

                   if(state.isLoading){
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                   return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index){
                      final item = items[index];
                      return PrayerAndVerseItem(
                        prayer: item,
                        onClick: (){
                          PrayerAndVerseDetailRoute(prayerId: item.id).push(context);
                        },
                      );
                    },
                   );
                 },
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}