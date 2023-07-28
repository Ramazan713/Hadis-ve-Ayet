
import 'package:floor/floor.dart';

@DatabaseView("""
  select E.name editionName, E.identifier,  V.cuzNo, 
  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded,
  C.name cuzName
  from  verse V, VerseAudio A, AudioEdition E, Cuz C
  where  A.identifier = E.identifier and A.mealId=V.id and C.cuzNo = V.cuzNo
  group by E.identifier, C.name, V.cuzNo
  """, viewName: "cuzAudioView")
class CuzAudioView{
  final String editionName;
  final String identifier;
  final int cuzNo;
  final String cuzName;
  final bool isDownloaded;

  CuzAudioView({
    required this.editionName,
    required this.identifier,
    required this.isDownloaded,
    required this.cuzNo,
    required this.cuzName
  });
}