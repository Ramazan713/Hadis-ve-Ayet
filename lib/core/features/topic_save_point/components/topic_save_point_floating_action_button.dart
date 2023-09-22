import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';

class TopicSavePointFloatingActionButton extends StatelessWidget {

  final CustomScrollController controller;
  final void Function(TopicSavePoint) onSavePointClick;
  final bool showFab;

  const TopicSavePointFloatingActionButton({
    Key? key,
    required this.controller,
    required this.onSavePointClick,
    required this.showFab
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TopicSavePointBloc,TopicSavePointState, TopicSavePoint?>(
        selector: (state) => state.topicSavePoint,
        builder: (context, currentTopicSavePoint){
          return ListenableBuilder(
              listenable: controller,
              builder: (context, child){

                final isFabVisible = currentTopicSavePoint != null &&
                    controller.scrollDirection == CustomScrollDirection.up &&
                    controller.isTopBarVisible &&
                    showFab;

                return CustomAnimatedVisibility(
                  visible: isFabVisible,
                  child: FloatingActionButton(
                    onPressed: (){
                      final topicSavePoint = currentTopicSavePoint;
                      if(topicSavePoint!=null){
                        onSavePointClick(topicSavePoint);
                      }
                    },
                    child: const Icon(Icons.beenhere),
                  ),
                );
              }
          );
        }
    );
  }
}
