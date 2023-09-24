import 'package:floor/floor.dart';

@Entity(tableName: "AudioEditions")
class AudioEditionEntity{

  @primaryKey
  final String identifier;
  final String name;
  final bool isSelected;
  final String? fileName;

  const AudioEditionEntity({
    required this.identifier,
    required this.name,
    required this.isSelected,
    this.fileName
  });

  AudioEditionEntity copyWith({bool? isSelected}){
    return AudioEditionEntity(
        identifier: identifier,
        name: name,
        isSelected: isSelected ?? this.isSelected,
        fileName: fileName
    );
  }

}