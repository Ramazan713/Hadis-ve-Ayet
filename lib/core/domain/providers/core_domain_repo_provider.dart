

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/core/domain/use_cases/list/delete_items_in_list.dart';
import 'package:hadith/core/domain/use_cases/list/delete_list.dart';
import 'package:hadith/core/domain/use_cases/list/get_lists.dart';
import 'package:hadith/core/domain/use_cases/list/insert_list.dart';
import 'package:hadith/core/domain/use_cases/list/list_use_cases.dart';
import 'package:hadith/core/domain/use_cases/list/search_lists.dart';
import 'package:hadith/core/domain/use_cases/list/update_list.dart';
import 'package:hadith/core/domain/use_cases/list_hadith/add_favorite_list_hadith.dart';
import 'package:hadith/core/domain/use_cases/list_hadith/add_list_hadith.dart';
import 'package:hadith/core/domain/use_cases/list_hadith/list_hadith_use_cases.dart';
import 'package:hadith/core/domain/use_cases/list_verse/add_favorite_list_verse.dart';
import 'package:hadith/core/domain/use_cases/list_verse/add_list_verse.dart';
import 'package:hadith/core/domain/use_cases/list_verse/list_verse_use_cases.dart';
import 'package:hadith/core/domain/use_cases/save_point/delete_save_point.dart';
import 'package:hadith/core/domain/use_cases/save_point/get_save_points.dart';
import 'package:hadith/core/domain/use_cases/save_point/insert_save_point.dart';
import 'package:hadith/core/domain/use_cases/save_point/save_point_use_cases.dart';
import 'package:hadith/core/domain/use_cases/save_point/update_save_point.dart';
import 'package:hadith/db/database.dart';

import '../use_cases/list/copy_list.dart';

List<RepositoryProvider> pCoreDomainRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<ListUseCases>(create: (context) => ListUseCases(
        insertList: InsertList(listRepo: context.read()),
        updateList: UpdateList(listRepo: context.read()),
        deleteList: DeleteList(listRepo: context.read(),savePointRepo: context.read()),
        copyList: CopyList(listRepo: context.read(),listHadithRepo: context.read(),listVerseRepo: context.read()),
        getLists: GetLists(listHadithViewRepo: context.read(), listVerseViewRepo: context.read()),
        searchLists: SearchLists(listHadithViewRepo: context.read(), listVerseViewRepo: context.read()),
        deleteItemsInList: DeleteItemsInList(listHadithRepo: context.read(), listVerseRepo: context.read())
    )),

    RepositoryProvider<ListHadithUseCases>(create: (context)=> ListHadithUseCases(
        addFavoriteList: AddFavoriteListHadith(listRepo: context.read(), listHadithRepo: context.read()),
        addList: AddListHadith(listHadithRepo: context.read())
    )),

    RepositoryProvider<ListVerseUseCases>(create: (context)=> ListVerseUseCases(
        addFavoriteList: AddFavoriteListVerse(listRepo: context.read(), listVerseRepo: context.read()),
        addList: AddListVerse(listVerseRepo: context.read())
    )),

    RepositoryProvider<SavePointUseCases>(create: (context){
      final savePointRepo = context.read<SavePointRepo>();
      return SavePointUseCases(
          insertSavePoint: InsertSavePoint(savePointRepo: savePointRepo),
          updateSavePoint: UpdateSavePoint(savePointRepo: savePointRepo),
          deleteSavePoint: DeleteSavePoint(savePointRepo: savePointRepo),
          getSavePoints: GetSavePoints(savePointRepo: savePointRepo),
      );
    }),

  ];
}
