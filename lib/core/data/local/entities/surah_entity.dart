

import 'package:floor/floor.dart';

@entity
class SurahEntity{
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final String searchName;

  SurahEntity({required this.id,required this.name,required this.searchName});
}