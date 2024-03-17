import 'package:floor/floor.dart';

@DatabaseView("""
    select E.name editionName , E.identifier, V.pageNo, 
    case when count(A.mealId) = (select count(VX.id) from verses VX where VX.pageNo=V.pageNo) then 1 else 0 end isDownloaded
    from  verses V, verseAudios A, audioEditions E
    where V.id = A.mealId and A.identifier = E.identifier 
    group by E.identifier,V.pageNo
""",
    viewName: "PageAudioView"
)
class PageAudioView{
  final String editionName;
  final String identifier;
  final int pageNo;
  final bool isDownloaded;

  PageAudioView({
    required this.editionName,
    required this.identifier,
    required this.isDownloaded,
    required this.pageNo,
  });
}
