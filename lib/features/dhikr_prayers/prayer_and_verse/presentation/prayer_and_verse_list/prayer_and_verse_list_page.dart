
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
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
        child: AdaptivePadding(
          child: DefaultNestedScrollableAppBar(
            title: const Text(
              "Namaz Duaları ve Ayetler",
              overflow: TextOverflow.ellipsis,
            ),
            pinned: true,
            appBarType: AppBarType.mediumBar,
            child: Column(
              children: [
               Expanded(
                 child: BlocBuilder<PrayerAndVerseListBloc,PrayerAndVerseListState>(
                   builder: (context, state){
                     final items = state.items;

                     if(state.isLoading){
                       return const SharedLoadingIndicator();
                     }
                     return LazyAlignedGridView(
                      itemCount: items.length,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      padding: K.defaultLazyListPadding,
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
      ),
    );
  }
}
