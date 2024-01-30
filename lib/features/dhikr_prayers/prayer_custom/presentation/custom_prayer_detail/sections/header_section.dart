
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/select_edition/show_select_edition.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/custom_prayer_detail_top_bar_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/bloc/custom_prayer_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/bloc/custom_prayer_detail_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/bloc/custom_prayer_detail_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/shared/show_prayer_share_dia.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';
import '../custom_prayer_detail_page.dart';

extension CustomPrayerDetailPageHeaderExt on CustomPrayerDetailPage{

  List<Widget> getActions(BuildContext context){
    return [
      _getShareIcon(context),
      IconButton(
        tooltip: "Düzenle",
        onPressed: (){
          UpdateCustomPrayerRoute(prayerId: prayerId).push(context);
        },
        icon: const Icon(Icons.edit),
      ),
      _getTopBarIconMenu(context)
    ];
  }

  Widget _getTopBarIconMenu(BuildContext context){
    final bloc = context.read<CustomPrayerDetailBloc>();
    return BlocSelector<CustomPrayerDetailBloc, CustomPrayerDetailState, PrayerUnit<PrayerCustom>?>(
      selector: (state) => state.prayerUnit,
      builder: (context, currentPrayer){
        return CustomDropdownIconMenu(
            items: CustomPrayerDetailTopBarMenuItems.getItems(currentPrayer),
            onSelected: (menuItem){
              switch(menuItem){
                case CustomPrayerDetailTopBarMenuItems.selectFontSize:
                  showSelectFontSizeDia(context);
                  break;
                case CustomPrayerDetailTopBarMenuItems.addToDhikr:
                  if(currentPrayer != null) {
                    bloc.add(CustomPrayerDetailEventAddDhikr(prayer: currentPrayer.item));
                  }
                  break;
                case CustomPrayerDetailTopBarMenuItems.goToDhikr:
                  final counterId = currentPrayer?.item.counterId;
                  if(counterId != null){
                    DetailCounterRoute(id: counterId).push(context);
                  }
                  break;
                case CustomPrayerDetailTopBarMenuItems.selectEdition:
                  showSelectEdition(context);
                  break;
                case CustomPrayerDetailTopBarMenuItems.navToSurah:
                  final mealId = currentPrayer?.getVerseIds.firstOrNull;
                  if(mealId == null) return;
                  context.read<LoadSavePointBloc>()
                      .add(LoadSavePointEventNavigateToSurahDestinationWithMealId(mealId: mealId));
                  break;
              }
            }
        );
      },
    );
  }


  Widget _getShareIcon(BuildContext context){
    return BlocBuilder<CustomPrayerDetailBloc, CustomPrayerDetailState>(
      builder: (context, state){
        final prayer = state.prayer;
        if(prayer == null || !prayer.hasAnyData) return const SizedBox.shrink();
        return IconButton(
          tooltip: "Paylaş",
          onPressed: (){
            showCustomPrayerShareDia(context,
              prayer: state.prayer
            );
          },
          icon: const Icon(Icons.share),
        );
      },
    );
  }
}