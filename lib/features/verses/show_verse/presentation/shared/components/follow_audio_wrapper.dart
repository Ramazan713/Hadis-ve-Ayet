
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FollowAudioWrapper extends StatelessWidget {
  final Widget child;
  final ItemScrollController itemScrollController;

  const FollowAudioWrapper({
    Key? key,
    required this.child,
    required this.itemScrollController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListenVerseAudioBloc, ListenVerseAudioState>(
      listenWhen: (prevState, nextState){
        return prevState.audio?.mealId != nextState.audio?.mealId ||
            prevState.followAudioText != nextState.followAudioText;
      },
      listener: (context, state){
        if(state.followAudioText){
          final items = context.read<PaginationBloc>().state.items;
          final mealId = state.audio?.mealId;
          final index = items.indexWhere((element) => element.pagingId == mealId);
          if(index!=-1){
            itemScrollController.scrollTo(
                index: index + 1, // +1 because paginationListView has two extra widget(in the start end end)
                duration: const Duration(milliseconds: 300),
            );
          }
        }
      },
      child: child,
    );
  }
}