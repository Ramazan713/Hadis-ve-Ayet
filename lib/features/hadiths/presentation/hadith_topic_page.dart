import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_topic_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_event.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';

import 'shared/bloc/hadith_shared_bloc.dart';
import 'shared/bloc/hadith_shared_state.dart';


class HadithTopicPage extends StatelessWidget {

  final BookEnum bookEnum;
  final int topicId;
  final int pos;

  const HadithTopicPage({
    Key? key,
    required this.bookEnum,
    required this.topicId,
    required this.pos
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    context.read<HadithSharedBloc>().add(HadithSharedEventSetTitle(
        titleEnum: TitleEnum.topic,
        itemId: topicId
    ));

    return BlocSelector<HadithSharedBloc, HadithSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){

          final savePointDestination = DestinationTopic(
              topicId: topicId,
              topicName: currentTitle,
              bookEnum: bookEnum
          );

          final hadithTopicPagingRepo = context.read<HadithTopicPagingRepo>()
              .init(topicId);

          return HadithSharedPage(
              pos: pos,
              savePointDestination: savePointDestination,
              paginationRepo: hadithTopicPagingRepo,
              title: "$currentTitle - ${bookEnum.sourceType.shortName}"
          );
        });
  }
}
