import 'package:floor/floor.dart';

@entity
class CuzEntity{
  @PrimaryKey(autoGenerate: false)
  final int cuzNo;
  final String name;

  CuzEntity({required this.cuzNo,required this.name});
}