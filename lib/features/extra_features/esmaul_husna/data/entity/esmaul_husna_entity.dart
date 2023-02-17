

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';

@Entity(tableName: "EsmaulHusna")
class EsmaulHusnaEntity{
  @PrimaryKey(autoGenerate: false)
  final int? id;
  final int orderItem;
  final String name;
  final String arabicName;
  final String meaning;
  final String dhikr;
  final String virtue;

  EsmaulHusnaEntity({this.id,required this.orderItem,required this.name,
    required this.arabicName,required this.meaning, required this.dhikr,
    required this.virtue
  });


  EsmaulHusna toEsmaulHusna(){
    return EsmaulHusna(
      id: id,
      order: orderItem,
      name: name,
      arabicName: arabicName,
      meaning: meaning,
      dhikr: dhikr,
      virtue: virtue
    );
  }


}