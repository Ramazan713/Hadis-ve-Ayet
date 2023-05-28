

import 'package:hadith/core/domain/use_cases/list_verse/add_favorite_list_verse.dart';
import 'package:hadith/core/domain/use_cases/list_verse/add_list_verse.dart';

class ListVerseUseCases{
  final AddFavoriteListVerse addFavoriteList;
  final AddListVerse addList;

  ListVerseUseCases({required this.addList, required this.addFavoriteList});
}