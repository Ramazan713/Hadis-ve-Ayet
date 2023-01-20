

import 'package:floor/floor.dart';

@Entity(tableName: "AudioEdition")
class AudioEdition{
  @primaryKey
  final String identifier;
  final String name;
  final bool isSelected;
  final String? fileName;

  AudioEdition({required this.identifier,required this.name,required this.isSelected,
    this.fileName});


  AudioEdition copyWith({String? identifier,String? name,bool? isSelected,String? fileName,
    bool setFileName=false}){
    return AudioEdition(identifier: identifier??this.identifier, name: name??this.name,
        isSelected: isSelected??this.isSelected,fileName: setFileName?fileName??this.fileName:this.fileName);
  }

}