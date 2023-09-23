
import 'package:floor/floor.dart';

@DatabaseView("""select E.name editionName , E.identifier, V.surahId, S.name surahName,
  case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded
  from  verse V, VerseAudio A, AudioEdition E, Surah S
  where V.id=A.mealId and A.identifier = E.identifier and S.id = V.surahId
  group by E.identifier,V.surahId, S.name
  """, viewName: "SurahAudioView")
class SurahAudioView{
  final String editionName;
  final String identifier;
  final int surahId;
  final String surahName;
  final bool isDownloaded;

  SurahAudioView({
    required this.editionName,
    required this.identifier,
    required this.isDownloaded,
    required this.surahName,
    required this.surahId
  });
}