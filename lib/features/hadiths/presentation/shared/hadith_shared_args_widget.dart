import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';

abstract class HadithSharedArgsWidget extends StatelessWidget {
  final SavePointDestination savePointDestination;
  final HadithPaginationRepo paginationRepo;
  final String title;
  final SearchParam? searchParam;
  final int pos;
  final int? listIdControlForSelectList;
  final EditSavePointHandler? editSavePointHandler;
  final bool? useWideScopeNaming;

  const HadithSharedArgsWidget({
    Key? key,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.title,
    this.searchParam,
    this.listIdControlForSelectList,
    this.editSavePointHandler,
    this.useWideScopeNaming,
    required this.pos
  }) : super(key: key);

}
