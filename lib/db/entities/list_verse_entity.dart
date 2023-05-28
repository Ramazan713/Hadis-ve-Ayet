import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/verse.dart';


@Entity(tableName: "listVerse",foreignKeys: [
  ForeignKey(
      childColumns: ["listId"],
      parentColumns: ["id"],
      entity: List
  ),
  ForeignKey(
      childColumns: ["verseId"],
      parentColumns: ["id"],
      entity: Verse
  )
],primaryKeys: ["listId","verseId"])
class ListVerseEntityOld extends Equatable{
  final int listId;
  final int verseId;
  final int pos;


  const ListVerseEntityOld({required this.listId,required this.verseId,required this.pos});

  @override
  List<Object?> get props => [listId,verseId];

  String toJson(){
    return json.encode({"listId":listId,"verseId":verseId,"pos":pos});
  }
  static ListVerseEntityOld fromJson(String data){
    final map=json.decode(data);
    return ListVerseEntityOld(listId: map["listId"], verseId: map["verseId"],pos:map["pos"]);
  }

}