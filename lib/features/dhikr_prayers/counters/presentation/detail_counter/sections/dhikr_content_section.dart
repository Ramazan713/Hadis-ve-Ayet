

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_detail_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/components/counter_complete_goal_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/components/dhikrmatic_classic.dart';
import '../detail_counter_shared_content_page.dart';

import '../components/dhikrmatic_unlimited.dart';

extension DetailCounterSharedContentDhikrExt on DetailCounterSharedContentPage{

  Widget getDhikr(){
    return BlocBuilder<DetailCounterBloc,DetailCounterState>(
      builder: (context,state){
        return state.counterType == CounterType.classic ?
        DhikrmaticClassic(
          counter: state.counterClassic,
          subCounter: state.counterSubClassic,
          onClick: (){
            context.read<DetailCounterBloc>()
                .add(DetailCounterEventIncrease());
          },
        ):
        DhikrmaticUnLimited(
          counter: state.counterUnLimited,
          onClick: (){
            context.read<DetailCounterBloc>()
                .add(DetailCounterEventIncrease());
          },
        );
      },
    );
  }

  Widget getCompletedWidget(){
    return BlocSelector<DetailCounterBloc,DetailCounterState,bool>(
        selector: (state)=>state.hasCompletedGoal,
        builder: (context,goalCompleted){
          if(goalCompleted){
            return CounterCompleteGoalItem(
              onClick: (){
                context.read<DetailCounterBloc>()
                    .add(DetailCounterEventReset());
              },
            );
          }
          return const SizedBox();
        }
    );
  }

}