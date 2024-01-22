import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/handler/save_point_navigate_handler.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_state.dart';

class NavigateAutoSavePointWrapper extends StatelessWidget {

  final Widget child;

  const NavigateAutoSavePointWrapper({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocListener<LoadSavePointBloc, LoadSavePointState>(
      listenWhen: (prevState, nextState){
        return prevState.resultLoadSavePoint != nextState.resultLoadSavePoint;
      },
      listener: (context, state){
        final result = state.resultLoadSavePoint;
        if(result!=null){

          savePointNavigateHandler(
              context,
              destination: result.destination,
              itemIndexPos: result.itemIndexPos
          );

          context.read<LoadSavePointBloc>()
              .add(LoadSavePointEventClearResult());
        }
      },
      child: child,
    );
  }
}
