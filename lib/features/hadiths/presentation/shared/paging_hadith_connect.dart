
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';

import 'bloc/hadith_shared_bloc.dart';
import 'bloc/hadith_shared_event.dart';


class PagingHadithConnect extends StatelessWidget {
  final Widget child;
  const PagingHadithConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hadithBloc = context.read<HadithSharedBloc>();
    final pagingBloc = context.read<PaginationBloc>();

    return MultiBlocListener(
        listeners: [
          BlocListener<HadithSharedBloc,HadithSharedState>(
            listener: (context,state){
              final invalidateEvent = state.invalidateEvent;
              if(invalidateEvent!=null){
                pagingBloc.add(PaginationEventInValidate(item: invalidateEvent.item, op: invalidateEvent.op));
                hadithBloc.add(HadithSharedEventClearInvalidateEvent());
              }
            },
          )
        ],
        child: child
    );
  }
}