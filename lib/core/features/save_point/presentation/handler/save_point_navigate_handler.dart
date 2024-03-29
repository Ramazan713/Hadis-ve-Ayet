import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/savepoint_list_navigator_page.dart';

void savePointNavigateHandlerWithSavePoint(
BuildContext context,
{
  required SavePoint savePoint
}
){
  savePointNavigateHandler(
      context,
      destination: savePoint.destination,
      itemIndexPos: savePoint.itemPos
  );
}


void savePointNavigateHandler(
    BuildContext context,
{
  required SavePointDestination destination,
  required int itemIndexPos
}
){
  duplicateDialogHandler(func: ()async{
    switch(destination){
      case DestinationAll _:
        _loadAndGoAll(context, destination, itemIndexPos);
        break;
      case DestinationTopic _:
        _loadAndGoTopic(context, destination, itemIndexPos);
        break;
      case DestinationList _:
        _loadAndGoList(context, destination, itemIndexPos);
        break;
      case DestinationSearch _:
        _loadAndGoSearch(context, destination, itemIndexPos);
        break;
      case DestinationSurah _:
        _loadAndGoSurah(context, destination, itemIndexPos);
        break;
      case DestinationCuz _:
        _loadAndGoCuz(context, destination, itemIndexPos);
        break;
      case DestinationPage _:
        _loadAndGoPage(context, destination,itemIndexPos);
        break;
    }
  });
}


void _loadAndGoAll(BuildContext context, DestinationAll destination, int itemIndexPos){
  final sourceType = destination.getBookScope().sourceType;

  switch(sourceType){
    case SourceTypeEnum.hadith:
      HadithAllRoute(
          hadithBookId: destination.bookEnum.bookId,
          pos: itemIndexPos
      ).push(context);
      break;
    case SourceTypeEnum.verse:
      break;
  }
}

void _loadAndGoList(BuildContext context, DestinationList destination, int itemIndexPos){
  ListForSavePointNavigationRoute(pos: itemIndexPos,listId: destination.listId,)
      .push(context);
}

void _loadAndGoTopic(BuildContext context, DestinationTopic destination, int itemIndexPos){
  TopicListDetailRoute(
    bookId: destination.bookEnum.bookId,
    sectionId: 0,
    sectionTitle: "Tüm Başlıklar",
    useBookAllSections: true,
    selectedTopicId: destination.topicId,
    listPos: itemIndexPos
  ).push(context);
}

void _loadAndGoSearch(BuildContext context, DestinationSearch destination, int itemIndexPos){
  final sourceType = destination.getBookScope().sourceType;

  switch(sourceType){
    case SourceTypeEnum.hadith:
      HadithSearchRoute(
          query: destination.query,
          bookScopeId: destination.bookScope.binaryId,
          criteriaId: destination.criteria.enumValue,
          pos: itemIndexPos
      ).push(context);
      break;
    case SourceTypeEnum.verse:
      VerseShowSearchRoute(
          query: destination.query,
          bookScopeId: destination.bookScope.binaryId,
          criteriaId: destination.criteria.enumValue,
          pos: itemIndexPos
      ).push(context);
      break;
  }
}

void _loadAndGoSurah(BuildContext context, DestinationSurah destination, int itemIndexPos){
  final sourceType = destination.getBookScope().sourceType;

  switch(sourceType){
    case SourceTypeEnum.hadith:
      break;
    case SourceTypeEnum.verse:
      VerseShowSurahRoute(
          surahId: destination.surahId,
          pos: itemIndexPos
      ).push(context);
      break;
  }
}

void _loadAndGoCuz(BuildContext context, DestinationCuz destination, int itemIndexPos){
  final sourceType = destination.getBookScope().sourceType;

  switch(sourceType){
    case SourceTypeEnum.hadith:
      break;
    case SourceTypeEnum.verse:
      VerseShowCuzRoute(
          cuzNo: destination.cuzId,
          pos: itemIndexPos
      ).push(context);
      break;
  }
}

void _loadAndGoPage(BuildContext context, DestinationPage destination, int itemIndexPos){
  final sourceType = destination.getBookScope().sourceType;

  switch(sourceType){
    case SourceTypeEnum.hadith:
      break;
    case SourceTypeEnum.verse:
      VersePageShowRoute(
        pageIndex: destination.pageNo - 1,
        pagePos: itemIndexPos
      ).push(context);
      break;
  }
}