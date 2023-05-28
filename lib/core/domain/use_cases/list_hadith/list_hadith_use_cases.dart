

import 'package:hadith/core/domain/use_cases/list_hadith/add_favorite_list_hadith.dart';
import 'package:hadith/core/domain/use_cases/list_hadith/add_list_hadith.dart';

class ListHadithUseCases{
  final AddFavoriteListHadith addFavoriteList;
  final AddListHadith addList;

  ListHadithUseCases({required this.addFavoriteList, required this.addList});
}