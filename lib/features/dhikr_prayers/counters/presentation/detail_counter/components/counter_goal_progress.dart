import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/progress_content.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_state.dart';


class CounterGoalProgress extends StatelessWidget {
  final int goal;
  const CounterGoalProgress({Key? key,required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocSelector<DetailCounterBloc,DetailCounterState,int>(
      selector: (state)=>state.counterUnLimited,
      builder: (context,currCounter){

        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: ProgressContent(
                    current: currCounter,
                    total: goal,
                  ),
                ),
                Text(
                  "  ( $currCounter / $goal )  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
