


import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/esmaul_husna/data/entity/esmaul_husna_entity.dart';

class EsmaulHusna extends Equatable{
  final int? id;
  final int order;
  final String name;
  final String arabicName;
  final String meaning;
  final String dhikr;
  final String virtue;

  const EsmaulHusna({this.id,required this.order,required this.name,
    required this.arabicName,required this.meaning, required this.dhikr,
    required this.virtue
  });

  @override
  List<Object?> get props => [id,order,name,arabicName,meaning,dhikr,virtue];
}