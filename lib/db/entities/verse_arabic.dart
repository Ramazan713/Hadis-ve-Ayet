

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:json_annotation/json_annotation.dart';

@Entity(tableName: "verseArabic",foreignKeys: [
  ForeignKey(childColumns: ["mealId"], parentColumns: ["id"], entity: Verse)
])
class VerseArabic extends Equatable{
  @primaryKey
  final int? id;
  final int mealId;
  final String verse;
  final String verseNumber;
  final int verseNumberTr;
  const VerseArabic({required this.id,required this.mealId,required this.verse,required this.verseNumber,required this.verseNumberTr});

  @override
  List<Object?> get props => [id,mealId,verse,verseNumber,verseNumberTr];
}