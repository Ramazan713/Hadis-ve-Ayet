
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/pagination/presentation/bloc/pagination_event.dart';

import '../../../../core/pagination/presentation/bloc/pagination_bloc.dart';
import '../bloc/hadith_bloc.dart';
import '../bloc/hadith_event.dart';
import '../bloc/hadith_state.dart';


class PagingHadithConnect extends StatelessWidget {
  final Widget child;
  const PagingHadithConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hadithBloc = context.read<HadithBloc>();
    final pagingBloc = context.read<PaginationBloc>();

    return MultiBlocListener(
        listeners: [
          BlocListener<HadithBloc,HadithState>(
            listener: (context,state){
              final invalidateEvent = state.invalidateEvent;
              if(invalidateEvent!=null){
                pagingBloc.add(PaginationEventInValidate(item: invalidateEvent.item, op: invalidateEvent.op));
                hadithBloc.add(HadithEventClearInvalidateEvent());
              }
            },
          )
        ],
        child: child
    );
  }
}