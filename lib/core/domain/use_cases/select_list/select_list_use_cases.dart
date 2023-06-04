

import 'package:hadith/core/domain/use_cases/select_list/add_favorite.dart';
import 'package:hadith/core/domain/use_cases/select_list/add_list.dart';
import 'package:hadith/core/domain/use_cases/select_list/get_selectable_list_view.dart';

class SelectListUseCases{
  final AddList addList;
  final AddFavoriteList addFavoriteList;
  final GetSelectableListView getSelectableListView;

  SelectListUseCases({
    required this.addList,
    required this.addFavoriteList,
    required this.getSelectableListView
  });
}