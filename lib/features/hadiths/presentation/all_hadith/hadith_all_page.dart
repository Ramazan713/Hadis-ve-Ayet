import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/presentation/components/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_book_enum.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';


class HadithAllPage extends StatelessWidget {
  static String id = "HadithAllPage";

  final HadithBookEnum hadithBookEnum;

  const HadithAllPage({Key? key, required this.hadithBookEnum}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final destination = DestinationAll(bookEnum: hadithBookEnum.toBookEnum());
    
    final hadithPagingRepo = context.read<HadithAllPagingRepo>().init(hadithBookEnum);

    return HadithSharedPage(
        savePointDestination: destination,
        fontSize: FontSize.medium,
        paginationRepo: hadithPagingRepo,
        title: "All Hadiths"
    );
  }
}




