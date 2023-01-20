
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/savepoint.dart';

@dao
abstract class SavePointDao{

  @Query("""select * from `savepoint` where savePointType=:savePointType
   and parentKey=:parentKey and autoType=:autoType order by modifiedDate desc limit 1""")
  Future<SavePoint?> getSavePoint(int savePointType,String parentKey,int autoType);


  @Query("""select * from `savepoint` where id=:id""")
  Future<SavePoint?> getSavePointWithId(int id);

  @Query("""select * from `savepoint` where
   savePointType=:savePointType and parentKey=:parentKey
   order by modifiedDate desc""")
  Stream<List<SavePoint>>getStreamSavePoints(int savePointType,String parentKey);


  @Query("""select * from `savepoint` where
   savePointType=:savePointType and bookScope=:bookScope
   order by modifiedDate desc""")
  Stream<List<SavePoint>>getStreamSavePointsWithBookIdBinary(int savePointType,int bookScope);

  @Query("""select * from `savepoint` where savePointType=:savePointType
   and bookScope=:bookScope and autoType=:autoType order by modifiedDate desc limit 1""")
  Future<SavePoint?> getAutoSavePointWithBookIdBinary(int savePointType,int bookScope,int autoType);

  @Query("""select * from `savepoint` where bookScope in(:bookScopes)
   order by modifiedDate desc""")
  Stream<List<SavePoint>>getStreamSavePointsWithBook(List<int> bookScopes);

  @Query("""select * from `savepoint` where bookScope in(:bookScopes) 
    and savePointType=:savePointType order by modifiedDate desc""")
  Stream<List<SavePoint>>getStreamSavePointsWithBookFilter(List<int> bookScopes,
      int savePointType);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertSavePoint(SavePoint savePoint);

  @delete
  Future<int>deleteSavePoint(SavePoint savePoint);

  @update
  Future<int>updateSavePoint(SavePoint savePoint);

  @Query("""delete from `savepoint` where savePointType=:savePointType and parentKey=:parentKey""")
  Future<void>deleteSavePointWithQuery(int savePointType,String parentKey);

}