
import 'package:floor/floor.dart';

@DatabaseView("""select E.name editionName , E.identifier, V.surahId,
  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded
  from  verse V, VerseAudio A, AudioEdition E
  where V.id=A.mealId and A.identifier = E.identifier group by E.identifier,V.surahId""",
    viewName: "surahAudioView")
class SurahAudioView{
  final String editionName;
  final String identifier;
  final int surahId;
  final bool isDownloaded;

  SurahAudioView({required this.editionName,required this.identifier,
    required this.isDownloaded,required this.surahId});
}