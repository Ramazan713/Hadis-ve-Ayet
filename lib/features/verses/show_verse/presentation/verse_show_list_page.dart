
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_list_paging_repo.dart';

import 'shared/bloc/verse_shared_bloc.dart';
import 'shared/bloc/verse_shared_event.dart';
import 'shared/bloc/verse_shared_state.dart';
import 'shared/verse_show_shared_page.dart';

class VerseShowListPage extends StatelessWidget {

  final int listId;
  final int pos;
  final ListBookScope listBookScope;

  const VerseShowListPage({
    Key? key,
    required this.listId,
    required this.pos,
    required this.listBookScope
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<VerseSharedBloc>().add(VerseSharedEventSetTitle(
        itemId: listId, titleEnum: TitleEnum.list
    ));

    return BlocSelector<VerseSharedBloc, VerseSharedState, String>(
        selector: (state) => state.title,
        builder: (context, currentTitle){

          final listPagingRepo = context.read<VerseListPagingRepo>()
              .init(listId: listId);

          final destination = DestinationList(
              listId: listId,
              listName: currentTitle,
              listBookScope: listBookScope
          );

          return VerseShowSharedPage(
            savePointDestination: destination,
            paginationRepo: listPagingRepo,
            listIdControlForSelectList: listId,
            title: "$currentTitle - ${listBookScope.bookScopeEnum.sourceType.shortName}",
            pos: pos,
          );
        }
    );


  }
}
