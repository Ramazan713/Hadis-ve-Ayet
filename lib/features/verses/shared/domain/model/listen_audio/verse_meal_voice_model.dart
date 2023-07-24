import 'package:json_annotation/json_annotation.dart';
part 'verse_meal_voice_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VerseMealVoiceModel{

  final int mealId;
  final String surahName;
  final int surahId;
  final String identifier;
  final String editionName;
  final String? fileName;
  final int cuzNo;
  final String cuzName;
  final int pageNo;
  final String verseNumbers;

  const VerseMealVoiceModel({
    required this.surahName,
    required this.surahId,
    required this.identifier,
    required this.fileName,
    required this.cuzNo,
    required this.pageNo,
    required this.verseNumbers,
    required this.mealId,
    required this.editionName,
    required this.cuzName
  });

  factory VerseMealVoiceModel.fromJson(Map<String, dynamic> json) => _$VerseMealVoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerseMealVoiceModelToJson(this);
}