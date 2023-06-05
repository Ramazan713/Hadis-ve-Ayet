import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_list_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

class HadithListPage extends StatelessWidget {

  final int listId;
  final String listName;
  final ListBookScope listBookScope;

  const HadithListPage({
    Key? key,
    required this.listId,
    required this.listName,
    required this.listBookScope
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final savePointDestination = DestinationList(
        listId: listId,
        listName: listName,
        listBookScope: listBookScope
    );

    final listPagingRepo = context.read<HadithListPagingRepo>()
        .init(listId);

    return HadithSharedPage(
        savePointDestination: savePointDestination,
        paginationRepo: listPagingRepo,
        title: "$listName - ${listBookScope.bookScopeEnum.sourceType.shortName}",
        listIdControlForSelectList: listId,
    );
  }
}
