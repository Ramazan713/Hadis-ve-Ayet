import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';

mixin HadithSharedPageArgs {

  SavePointDestination? get savePointDestination;
  HadithPaginationRepo get paginationRepo;
  String get title;
  SearchParam? get searchParam;
  int get pos;
  int? get listIdControlForSelectList;
  EditSavePointHandler? get editSavePointHandler;
  bool? get useWideScopeNaming;
}



abstract class HadithSharedBasePageStateful extends StatefulWidget implements HadithSharedPageArgs {
  @override
  final SavePointDestination savePointDestination;
  @override
  final HadithPaginationRepo paginationRepo;
  @override
  final String title;
  @override
  final SearchParam? searchParam;
  @override
  final int pos;
  @override
  final int? listIdControlForSelectList;
  @override
  final EditSavePointHandler? editSavePointHandler;
  @override
  final bool? useWideScopeNaming;


  const HadithSharedBasePageStateful({
    super.key,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.title,
    required this.pos,
    this.searchParam,
    this.listIdControlForSelectList,
    this.editSavePointHandler,
    this.useWideScopeNaming,
  });

}

abstract class HadithSharedBasePageStateless extends StatelessWidget implements HadithSharedPageArgs {

  @override
  final SavePointDestination savePointDestination;
  @override
  final HadithPaginationRepo paginationRepo;
  @override
  final String title;
  @override
  final SearchParam? searchParam;
  @override
  final int pos;
  @override
  final int? listIdControlForSelectList;
  @override
  final EditSavePointHandler? editSavePointHandler;
  @override
  final bool? useWideScopeNaming;

  const HadithSharedBasePageStateless({
    super.key,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.title,
    required this.pos,
    this.searchParam,
    this.listIdControlForSelectList,
    this.editSavePointHandler,
    this.useWideScopeNaming,
  });

}
