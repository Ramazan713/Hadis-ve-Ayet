

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/components/counter_content.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/components/counter_goal_progress.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/detail_counter_shared_content_page.dart';

extension DetailCounterSharedContentCounterExt on DetailCounterSharedContentPage{

  Widget getCounterContent(){
    return BlocBuilder<DetailCounterBloc,DetailCounterState>(
      buildWhen: (prevState, nextState){
        return prevState.currentCounter != nextState.currentCounter ||
            prevState.fontModel != nextState.fontModel ||
            prevState.verseUi != nextState.verseUi;
      },
      builder: (context, state){
        return Column(
          children: _getCounterInfoChildren(context,state),
        );
      },
    );
  }

  List<Widget> _getCounterInfoChildren(BuildContext context, DetailCounterState state){
    final counter = state.currentCounter;
    if(counter == null){
      return [];
    }
    final items = <Widget> [];
    if(counter.goal!=null ){
      items.add(CounterGoalProgress(goal: counter.goal??1,));
    }
    if(state.hasArabicContent){
      items.add(CounterContent(
        title: "Arapça İçerik",
        fontModel: state.fontModel,
        content: counter.arabicContent??"",
        isArabic: true,
      ));
    }
    if(state.hasPronunciation){
      items.add(CounterContent(
          title: "İçerik",
          fontModel: state.fontModel,
          content: counter.content??""
      ));
    }

    if(state.hasMeaning){
      items.add(CounterContent(
          title: "Anlamı",
          fontModel: state.fontModel,
          content: counter.meaning??""
      ));
    }
    return items;
  }

}