
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:hadith/core/presentation/controllers/custom_page_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_sing_position_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FollowAudioWrapperByPage extends StatelessWidget {
  final Widget child;
  final CustomPageController pageController;

  const FollowAudioWrapperByPage({
    Key? key,
    required this.child,
    required this.pageController
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
          final items = context.read<PaginationBloc>().state.itemsByPage[pageController.currentPageIndex + 1];
          final mealId = state.audio?.mealId;
          final index = items?.indexWhere((element) => element.pagingId == mealId);
          if(index != null && index != -1){
            pageController.positionController.setPos(index);
          }
        }
      },
      child: child,
    );
  }
}