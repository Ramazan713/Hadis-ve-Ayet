
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/save_point_entity.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';

@dao
abstract class SavePointDaoOld{

  @Query("""select * from savePoints where savePointType=:savePointType
   and parentKey=:parentKey and autoType=:autoType order by modifiedDate desc limit 1""")
  Future<SavePointEntityOld?> getSavePoint(int savePointType,String parentKey,int autoType);


  @Query("""select * from savePoints where id=:id""")
  Future<SavePointEntityOld?> getSavePointWithId(int id);

  @Query("""select * from savePoints where
   savePointType=:savePointType and parentKey=:parentKey
   order by modifiedDate desc""")
  Stream<List<SavePointEntityOld>>getStreamSavePoints(int savePointType,String parentKey);

  @Query("""select * from savePoints where
   savePointType=:savePointType and bookScope=:bookScope
   order by modifiedDate desc""")
  Stream<List<SavePointEntityOld>>getStreamSavePointsWithBookIdBinary(int savePointType,int bookScope);

  @Query("""select * from savePoints where savePointType=:savePointType
   and bookScope=:bookScope and autoType=:autoType order by modifiedDate desc limit 1""")
  Future<SavePointEntityOld?> getAutoSavePointWithBookIdBinary(int savePointType,int bookScope,int autoType);

  @Query("""select * from savePoints where bookScope in(:bookScopes)
   order by modifiedDate desc""")
  Stream<List<SavePointEntityOld>>getStreamSavePointsWithBook(List<int> bookScopes);

  @Query("""select * from savePoints where bookScope in(:bookScopes) 
    and savePointType=:savePointType order by modifiedDate desc""")
  Stream<List<SavePointEntityOld>>getStreamSavePointsWithBookFilter(List<int> bookScopes,
      int savePointType);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertSavePoint(SavePointEntityOld savePoint);

  @delete
  Future<int>deleteSavePoint(SavePointEntityOld savePoint);

  @update
  Future<int>updateSavePoint(SavePointEntityOld savePoint);

  @Query("""delete from savePoints where savePointType=:savePointType and parentKey=:parentKey""")
  Future<void>deleteSavePointWithQuery(int savePointType,String parentKey);

}