
import 'package:floor/floor.dart';

// @DatabaseView("""select E.name editionName , E.identifier, V.cuzNo,
//   case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded
//   from  verse V, VerseAudio A, AudioEdition E
//   where  A.identifier = E.identifier and A.mealId=V.id group by E.identifier,V.cuzNo""",
//     viewName: "cuzAudioView")
class CuzAudioViewOld{
  final String editionName;
  final String identifier;
  final int cuzNo;
  final bool isDownloaded;

  CuzAudioViewOld({required this.editionName,required this.identifier,
    required this.isDownloaded,required this.cuzNo});
}