import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';


class HadithAllPage extends StatelessWidget {
  static String id = "HadithAllPage";

  final HadithBookEnum hadithBookEnum;
  final int pos;

  const HadithAllPage({
    super.key,
    required this.hadithBookEnum,
    required this.pos
  });

  @override
  Widget build(BuildContext context) {

    final destination = DestinationAll(bookEnum: hadithBookEnum.toBookEnum());
    
    final hadithPagingRepo = context.read<HadithAllPagingRepo>().init(hadithBookEnum);

    return HadithSharedPage(
        savePointDestination: destination,
        paginationRepo: hadithPagingRepo,
        pos: pos,
        title: "Tümü - ${hadithBookEnum.toBookEnum().title}"
    );
  }
}




