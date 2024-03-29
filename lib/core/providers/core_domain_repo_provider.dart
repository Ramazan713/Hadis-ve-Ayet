import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/use_cases/list/copy_list.dart';
import 'package:hadith/core/domain/use_cases/list/delete_items_in_list.dart';
import 'package:hadith/core/domain/use_cases/list/delete_list.dart';
import 'package:hadith/core/domain/use_cases/list/get_lists.dart';
import 'package:hadith/core/domain/use_cases/list/insert_list.dart';
import 'package:hadith/core/domain/use_cases/list/list_use_cases.dart';
import 'package:hadith/core/domain/use_cases/list/search_lists.dart';
import 'package:hadith/core/domain/use_cases/list/update_list.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/delete_save_point.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/get_save_points.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/insert_or_update_auto_save_point.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/insert_save_point.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/save_point_use_cases.dart';
import 'package:hadith/core/features/save_point/domain/use_cases/update_save_point.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/add_favorite.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/add_list.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/get_favorite_list.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/get_selectable_list_view.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/insert_or_delete_list.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/select_list_use_cases.dart';
import 'package:hadith/core/features/topic_save_point/domain/repo/topic_save_point_repo.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/delete_topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/get_topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/insert_topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/topic_save_point_use_cases.dart';

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

    RepositoryProvider<SelectListUseCases>(create: (context){
      final insertOrDeleteListItem = InsertOrDeleteListItem(
        listVerseRepo: context.read(),
        listHadithRepo: context.read()
      );
      final getFavoriteList = GetFavoriteList(listRepo: context.read());

      return SelectListUseCases(
          addList: AddList(insertOrDeleteListItem: insertOrDeleteListItem),
          addFavoriteList: AddFavoriteList(getFavoriteList: getFavoriteList,
              insertOrDeleteListItem: insertOrDeleteListItem),
          getSelectableListView: GetSelectableListView(
              listHadithViewRepo: context.read(),
              listHadithRepo: context.read(),
              listVerseViewRepo: context.read(),
              listVerseRepo: context.read(),
          ),
          getFavoriteList: getFavoriteList
      );
    }),


    RepositoryProvider<SavePointUseCases>(create: (context){
      final savePointRepo = context.read<SavePointRepo>();
      return SavePointUseCases(
          insertSavePoint: InsertSavePoint(savePointRepo: savePointRepo),
          updateSavePoint: UpdateSavePoint(savePointRepo: savePointRepo),
          deleteSavePoint: DeleteSavePoint(savePointRepo: savePointRepo),
          getSavePoints: GetSavePoints(savePointRepo: savePointRepo),
          insertOrUpdateSavePoint: InsertOrUpdateAutoSavePoint(savePointRepo: savePointRepo),
      );
    }),

    RepositoryProvider<TopicSavePointUseCases>(create: (context){
      final topicSavePointRepo = context.read<TopicSavePointRepo>();
      return TopicSavePointUseCases(
        insertSavePoint: InsertTopicSavePoint(topicSavePointRepo: topicSavePointRepo),
        getSavePoint: GetTopicSavePoint(topicSavePointRepo: topicSavePointRepo),
        deleteSavePoint: DeleteTopicSavePoint(topicSavePointRepo: topicSavePointRepo)
      );
    }),

  ];
}
