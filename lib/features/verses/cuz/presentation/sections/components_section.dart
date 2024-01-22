import 'package:flutter/material.dart';
import 'package:hadith/core/features/topic_save_point/presentation/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/features/verses/cuz/presentation/cuz_page.dart';

extension CuzPageComponentsExt on CuzPageState{

  Widget getFab(){
    return TopicSavePointFloatingActionButton(
      showFab: true,
      controller: scrollController,
      onSavePointClick: (savePoint){
        itemScrollController.scrollTo(
            index: savePoint.pos,
            duration: const Duration(milliseconds: 300),
            alignment: 0.5
        );
      },
    );
  }
}