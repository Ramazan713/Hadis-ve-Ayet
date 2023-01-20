

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/entities/verse_arabic.dart';
import 'package:path_provider/path_provider.dart';

@Entity(tableName: "verseAudio",foreignKeys: [
  ForeignKey(
      childColumns: ["mealId"],
      parentColumns: ["id"],
      entity: Verse
  ),
  ForeignKey(
      childColumns: ["identifier"],
      parentColumns: ["identifier"],
      entity: AudioEdition
  ),
],primaryKeys: ["mealId","identifier"])
class VerseAudio extends Equatable{
  final int mealId;
  final String identifier;
  final String? fileName;
  final bool hasEdited;

  const VerseAudio({required this.mealId,required this.identifier,required this.fileName,required this.hasEdited});



  VerseAudio copyWith({int? mealId,String?identifier,bool?hasEdited,String?fileName,bool setFileName=false}){
    return VerseAudio(mealId: mealId??this.mealId, identifier: identifier??this.identifier,
        fileName: setFileName?fileName:this.fileName, hasEdited: hasEdited??this.hasEdited);
  }

  @override
  String toString() {
    return "VerseAudio(mealId=$mealId, identifier=$identifier, fileName=$fileName, hasEdited=:$hasEdited)";
  }

  static String newFileName(String identifier,int mealId){
    return "arabic/$identifier/m$mealId.mp3";
  }

  static String headerFileName(String identifier,int mealId){
    return "$identifier/$mealId.mp3";
  }

  static Future<File> getAudioFile(String fileName)async{
    String appDocDir = (await getTemporaryDirectory()).path;
    return getAudioFileWithDir(appDocDir,fileName);
  }

  static Future<String> appDocDirPath()async{
    return (await getTemporaryDirectory()).path;
  }

  static File getAudioFileWithDir(String appDocDir,String fileName){
    return File("$appDocDir/$fileName");
  }

  @override
  List<Object?> get props => [mealId,identifier,fileName,hasEdited];
}