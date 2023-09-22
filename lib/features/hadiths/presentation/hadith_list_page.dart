import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_list_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_event.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';

import 'shared/bloc/hadith_shared_bloc.dart';

class HadithListPage extends StatelessWidget {

  final int listId;
  final ListBookScope listBookScope;
  final int pos;

  const HadithListPage({
    Key? key,
    required this.listId,
    required this.listBookScope,
    required this.pos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<HadithSharedBloc>().add(HadithSharedEventSetTitle(
      itemId: listId,
      titleEnum: TitleEnum.list
    ));

    return BlocSelector<HadithSharedBloc, HadithSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){

          final savePointDestination = DestinationList(
              listId: listId,
              listName: currentTitle,
              listBookScope: listBookScope
          );

          final listPagingRepo = context.read<HadithListPagingRepo>()
              .init(listId);

          return HadithSharedPage(
            pos: pos,
            savePointDestination: savePointDestination,
            paginationRepo: listPagingRepo,
            title: "$currentTitle - ${listBookScope.bookScopeEnum.sourceType.shortName}",
            listIdControlForSelectList: listId,
          );
        }
    );
  }
}
