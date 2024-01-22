
import 'package:hadith/core/features/select_list/domain/use_cases/add_favorite.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/add_list.dart';
import 'package:hadith/core/features/select_list/domain/use_cases/get_selectable_list_view.dart';

import 'get_favorite_list.dart';

class SelectListUseCases{
  final AddList addList;
  final AddFavoriteList addFavoriteList;
  final GetSelectableListView getSelectableListView;
  final GetFavoriteList getFavoriteList;

  SelectListUseCases({
    required this.addList,
    required this.addFavoriteList,
    required this.getSelectableListView,
    required this.getFavoriteList
  });
}