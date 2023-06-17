import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';

import '../bloc/verse_shared_bloc.dart';
import '../bloc/verse_shared_event.dart';
import '../bloc/verse_shared_state.dart';


class PagingVerseConnect extends StatelessWidget {
  final Widget child;
  const PagingVerseConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hadithBloc = context.read<VerseSharedBloc>();
    final pagingBloc = context.read<PaginationBloc>();

    return MultiBlocListener(
        listeners: [
          BlocListener<VerseSharedBloc,VerseSharedState>(
            listener: (context,state){
              final invalidateEvent = state.invalidateEvent;
              if(invalidateEvent!=null){
                pagingBloc.add(PaginationEventInValidate(item: invalidateEvent.item, op: invalidateEvent.op));
                hadithBloc.add(VerseSharedEventClearInvalidateEvent());
              }
            },
          )
        ],
        child: child
    );
  }
}