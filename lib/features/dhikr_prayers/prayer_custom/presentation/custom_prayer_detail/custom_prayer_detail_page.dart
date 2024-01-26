
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/components/basic_audio_info_body_wrapper.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/components/custom_detail_prayer_item.dart';

import 'bloc/custom_prayer_detail_bloc.dart';
import 'bloc/custom_prayer_detail_event.dart';
import 'bloc/custom_prayer_detail_state.dart';
import './sections/header_section.dart';

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

    return AdCheckWidget(
      child: getListeners(
        child: Scaffold(
          body: SafeArea(
            child: DefaultNestedScrollableAppBar(
              title: const Text("Dualarım"),
              snap: true,
              floating: true,
              actions: getActions(context),
              child: BasicAudioInfoBodyWrapper(
                child: BlocBuilder<CustomPrayerDetailBloc,CustomPrayerDetailState>(
                  builder: (context,state){
                    return StackSecondContent(
                      getSecondChild: (){
                        return getLoadingOrEmptyResult(context, state);
                      },
                      child: DefaultAdaptiveLayout(
                        builder: (context, windowSizeClass){
                          return SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: CustomPrayerDetailItem(
                                  fontModel: state.fontModel,
                                  prayerUnit: state.prayerUnit,
                                  windowSizeClass: windowSizeClass,
                                )
                            ),
                          );
                        },
                      ),
                    );
                  }
                ),
              ),
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
    if(state.prayer?.hasAnyData == false){
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
}
