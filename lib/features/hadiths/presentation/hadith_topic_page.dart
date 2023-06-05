import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_topic_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';


class HadithTopicPage extends StatelessWidget {

  final BookEnum bookEnum;
  final int topicId;
  final String topicName;

  const HadithTopicPage({
    Key? key,
    required this.bookEnum,
    required this.topicId,
    required this.topicName
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final savePointDestination = DestinationTopic(
        topicId: topicId,
        topicName: topicName,
        bookEnum: bookEnum
    );

    final hadithTopicPagingRepo = context.read<HadithTopicPagingRepo>()
        .init(topicId);

    return HadithSharedPage(
        savePointDestination: savePointDestination,
        paginationRepo: hadithTopicPagingRepo,
        title: "$topicName - ${bookEnum.bookScope?.sourceType.shortName}"
    );
  }
}
