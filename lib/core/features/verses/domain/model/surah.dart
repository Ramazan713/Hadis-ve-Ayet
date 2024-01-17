

import 'package:hadith/core/domain/models/i_menu_item.dart';

class Surah implements ISearchableSelectItem{
  final int id;
  final String name;
  final String searchName;

  Surah({
    required this.id,
    required this.name,
    required this.searchName
  });

  @override
  String get title => "$id $name";

  @override
  String get searchableText => "$id $searchName".toLowerCase();
}