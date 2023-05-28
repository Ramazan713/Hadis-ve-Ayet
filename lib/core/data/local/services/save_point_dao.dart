

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/save_point_entity.dart';

@dao
abstract class SavePointDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertSavePoint(SavePointEntity savePoint);

  @delete
  Future<void> deleteSavePoint(SavePointEntity savePoint);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSavePoint(SavePointEntity savePoint);

  @Query("""delete from savePoints where savePointType=:savePointType and parentKey=:parentKey""")
  Future<void>deleteSavePointsWithQuery(int savePointType,String parentKey);


  @Query("select * from savePoints where bookScope in(:bookScopes) order by modifiedDate desc")
  Stream<List<SavePointEntity>> getStreamSavePointsWithScopes(List<int> bookScopes);

  @Query("select * from savePoints where bookScope in(:bookScopes) and savePointType=:typeId order by modifiedDate desc")
  Stream<List<SavePointEntity>> getStreamSavePointsWithScopesAndTypeId(List<int> bookScopes, int typeId);

}