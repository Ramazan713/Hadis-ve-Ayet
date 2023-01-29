
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/save_point_entity.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';

@dao
abstract class SavePointDao{

  @Query("""select * from `savepoint` where savePointType=:savePointType
   and parentKey=:parentKey and autoType=:autoType order by modifiedDate desc limit 1""")
  Future<SavePointEntity?> getSavePoint(int savePointType,String parentKey,int autoType);


  @Query("""select * from `savepoint` where id=:id""")
  Future<SavePointEntity?> getSavePointWithId(int id);

  @Query("""select * from `savepoint` where
   savePointType=:savePointType and parentKey=:parentKey
   order by modifiedDate desc""")
  Stream<List<SavePointEntity>>getStreamSavePoints(int savePointType,String parentKey);


  @Query("""select * from `savepoint` where
   savePointType=:savePointType and bookScope=:bookScope
   order by modifiedDate desc""")
  Stream<List<SavePointEntity>>getStreamSavePointsWithBookIdBinary(int savePointType,int bookScope);

  @Query("""select * from `savepoint` where savePointType=:savePointType
   and bookScope=:bookScope and autoType=:autoType order by modifiedDate desc limit 1""")
  Future<SavePointEntity?> getAutoSavePointWithBookIdBinary(int savePointType,int bookScope,int autoType);

  @Query("""select * from `savepoint` where bookScope in(:bookScopes)
   order by modifiedDate desc""")
  Stream<List<SavePointEntity>>getStreamSavePointsWithBook(List<int> bookScopes);

  @Query("""select * from `savepoint` where bookScope in(:bookScopes) 
    and savePointType=:savePointType order by modifiedDate desc""")
  Stream<List<SavePointEntity>>getStreamSavePointsWithBookFilter(List<int> bookScopes,
      int savePointType);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertSavePoint(SavePointEntity savePoint);

  @delete
  Future<int>deleteSavePoint(SavePointEntity savePoint);

  @update
  Future<int>updateSavePoint(SavePointEntity savePoint);

  @Query("""delete from `savepoint` where savePointType=:savePointType and parentKey=:parentKey""")
  Future<void>deleteSavePointWithQuery(int savePointType,String parentKey);

}