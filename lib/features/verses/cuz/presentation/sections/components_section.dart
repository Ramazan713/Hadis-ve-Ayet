import 'package:flutter/material.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/verses/cuz/presentation/cuz_page.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

extension CuzPageComponentsExt on CuzPage{

  Widget getFab(BuildContext context,{
    required CustomScrollController scrollController,
    required ItemScrollController itemScrollController
  }){
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