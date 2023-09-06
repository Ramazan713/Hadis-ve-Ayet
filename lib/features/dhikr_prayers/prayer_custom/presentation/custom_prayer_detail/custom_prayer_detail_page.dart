
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/custom_prayer_detail_top_bar_menu.dart';
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
            title: getTitle(),
            pinned: true,
            actions: getActions(context),
            appBarType: AppBarType.mediumBar,
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: BlocBuilder<CustomPrayerDetailBloc,CustomPrayerDetailState>(
                    builder: (context,state){
                      if(state.isLoading){
                        return const SharedLoadingIndicator();
                      }
                      final prayer = state.prayer;
                      if(prayer == null){
                        return const SharedEmptyResult(
                          content: "herhangi bir sonuç bulunamadı",
                        );
                      }
                      return getContent(state: state);
                    }
                )
              ),
            ),
          ),
        ),
      ),
    );
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

  Widget getContent({ required CustomPrayerDetailState state,}){
    if(!state.hasAnyData){
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: SharedEmptyResult(
          content: "Eklenmiş herhangi bir veri yok. Veri eklemeyi deneyin.",
        ),
      );
    }
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

  Widget getTitle(){
    return BlocBuilder<CustomPrayerDetailBloc,CustomPrayerDetailState>(
      buildWhen: (prevState, nextState){
        return prevState.prayer != nextState.prayer;
      },
      builder: (context,state){
        return Text(state.prayer?.name ?? "");
      }
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


  List<Widget> getActions(BuildContext context){
    return [
      _getTopBarIconMenu(context)
    ];
  }

  Widget _getTopBarIconMenu(BuildContext context){
    final bloc = context.read<CustomPrayerDetailBloc>();
    return BlocSelector<CustomPrayerDetailBloc, CustomPrayerDetailState, PrayerCustom?>(
      selector: (state) => state.prayer,
      builder: (context, currentPrayer){
        return CustomDropdownIconMenu(
          items: CustomPrayerDetailTopBarMenuItems.getItems(currentPrayer),
          onSelected: (menuItem){
            switch(menuItem){
              case CustomPrayerDetailTopBarMenuItems.selectFontSize:
                showSelectFontSizeDia(context);
                break;
              case CustomPrayerDetailTopBarMenuItems.edit:
                UpdateCustomPrayerRoute(prayerId: prayerId).push(context);
                break;
              case CustomPrayerDetailTopBarMenuItems.addToDhikr:
                if(currentPrayer != null) {
                  bloc.add(CustomPrayerDetailEventAddDhikr(prayer: currentPrayer));
                }
                break;
              case CustomPrayerDetailTopBarMenuItems.goToDhikr:
                final counterId = currentPrayer?.counterId;
                if(counterId != null){
                  DetailCounterRoute(id: counterId).push(context);
                }
                break;
            }
          }
        );
      },
    );
  }

}
