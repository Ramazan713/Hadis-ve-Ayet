
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/custom_prayer_detail_top_bar_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/sections/contents_section.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/sections/header_section.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
import 'package:hadith/utils/toast_utils.dart';

import 'bloc/custom_prayer_detail_bloc.dart';
import 'bloc/custom_prayer_detail_event.dart';
import 'bloc/custom_prayer_detail_state.dart';

class CustomPrayerDetailPage extends StatelessWidget {

  final int prayerId;

  const CustomPrayerDetailPage({
    Key? key,
    required this.prayerId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<CustomPrayerDetailBloc>()
        .add(CustomPrayerDetailLoadData(prayerId: prayerId));

    return getListeners(
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            title: const Text("Dualarım"),
            snap: true,
            floating: true,
            actions: getActions(context),
            child: BlocBuilder<CustomPrayerDetailBloc,CustomPrayerDetailState>(
              builder: (context,state){
                return StackSecondContent(
                  getSecondChild: (){
                    return getLoadingOrEmptyResult(context, state);
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          getPrayerName(),
                          getContentItems(state: state)
                        ],
                      )
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget? getLoadingOrEmptyResult(BuildContext context, CustomPrayerDetailState state){
    final prayer = state.prayer;
    if(state.isLoading){
      return const SharedLoadingIndicator();
    }
    if(prayer == null){
      return const SharedEmptyResult(
        content: "herhangi bir sonuç bulunamadı",
      );
    }
    if(!state.hasAnyData){
      return const SharedEmptyResult(
        paddings: EdgeInsets.symmetric(horizontal: 10),
        content: "Eklenmiş herhangi bir veri yok. Veri eklemeyi deneyin.",
      );
    }
    return null;
  }


  Widget getListeners({required Widget child}){
    return BlocListener<CustomPrayerDetailBloc,CustomPrayerDetailState>(
      listenWhen: (prevState, nextState){
        return prevState.message != nextState.message;
      },
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          context.read<CustomPrayerDetailBloc>()
              .add(CustomPrayerDetailEventClearMessage());
        }
      },
      child: child,
    );
  }

  Widget getPrayerName(){
    return BlocBuilder<CustomPrayerDetailBloc,CustomPrayerDetailState>(
      buildWhen: (prevState, nextState){
        return prevState.prayer != nextState.prayer;
      },
      builder: (context,state){
        return Padding(
          padding: const EdgeInsets.only(bottom: 12,top: 4,left: 8),
          child: Text(
            "${state.prayer?.name}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      }
    );
  }




}
