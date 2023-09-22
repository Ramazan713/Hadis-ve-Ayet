import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';

import '../data/repo/verse_topic_paging_repo.dart';
import 'shared/bloc/verse_shared_bloc.dart';
import 'shared/bloc/verse_shared_event.dart';
import 'shared/bloc/verse_shared_state.dart';
import 'shared/shared_providers.dart';
import 'shared/verse_show_shared_page.dart';

class VerseShowTopicPage extends StatelessWidget {

  final int topicId;
  final int pos;
  final BookEnum bookEnum;

  const VerseShowTopicPage({
    Key? key,
    required this.topicId,
    required this.pos,
    required this.bookEnum
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<VerseSharedBloc>().add(VerseSharedEventSetTitle(
        itemId: topicId, titleEnum: TitleEnum.topic
    ));

    return VerseSharedProviders(
      child: BlocSelector<VerseSharedBloc, VerseSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){

          final surahPagingRepo = context.read<VerseTopicPagingRepo>()
              .init(topicId: topicId);

          final destination = DestinationTopic(topicId: topicId, topicName: currentTitle, bookEnum: bookEnum);

          return VerseShowSharedPage(
            savePointDestination: destination,
            paginationRepo: surahPagingRepo,
            showNavigateToActions: true,
            selectAudioOption: SelectAudioOption.verse,
            title: currentTitle,
            pos: pos,
          );
        }
      ),
    );



  }
}
