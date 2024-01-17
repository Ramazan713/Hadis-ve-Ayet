

import 'package:hadith/core/domain/models/i_menu_item.dart';

class Cuz implements ISearchableSelectItem{
  final int no;
  final String name;

  Cuz({required this.no, required this.name});

  @override
  String get searchableText => title.toLowerCase();

  @override
  String get title => name;

}