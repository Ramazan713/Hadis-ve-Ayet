import 'package:floor/floor.dart';

final migration6To7 = Migration(6, 7, (database)async{

  database.transaction((txn)async{
    txn.execute("""
      create view PageAudioView as select E.name editionName , E.identifier, V.pageNo, 
      case when count(A.mealId) = (select count(VX.id) from verses VX where VX.pageNo=V.pageNo) then 1 else 0 end isDownloaded
      from  verses V, verseAudios A, audioEditions E
      where V.id = A.mealId and A.identifier = E.identifier 
      group by E.identifier,V.pageNo
    """);
  });

});