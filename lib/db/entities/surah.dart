import 'package:floor/floor.dart';

@entity
class Surah{
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final String searchName;

  Surah({required this.id,required this.name,required this.searchName});
}