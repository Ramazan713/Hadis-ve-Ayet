import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_state.dart';
import 'package:hadith/widgets/progress_content.dart';


class ShowCounterGoalProgress extends StatelessWidget {
  final int goal;
  const ShowCounterGoalProgress({Key? key,required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocSelector<CounterDetailBloc,CounterDetailState,int>(
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
                  Text("  ( $currCounter / $goal )  ")
                ],
              ),
            ),
          );
        }
    );
  }
}
