

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

  @Query("""
    select * from savePoints where id = :id
  """)
  Future<SavePointEntity?> getSavePointById(int id);

  @Query("""
    select * from savePoints where id = :id
  """)
  Stream<SavePointEntity?> getStreamSavePointById(int id);

  @Query("""delete from savePoints where savePointType=:savePointType and parentKey=:parentKey""")
  Future<void>deleteSavePointsWithQuery(int savePointType,String parentKey);


  @Query("""
    select * from savePoints where bookScope = :bookScope and savePointType = :typeId and
    parentKey = :parentKey and autoType = :autoType order by modifiedDate desc limit 1
  """)
  Future<SavePointEntity?> getLastSavePointByDestinationAndAutoType(
      int bookScope, int typeId, String parentKey, int autoType
  );

  @Query("""
    select * from savePoints where bookScope = :bookScope and savePointType = :typeId and
    autoType = :autoType order by modifiedDate desc limit 1
  """)
  Future<SavePointEntity?> getLastSavePointByBookScopeAndType(
      int bookScope, int typeId, int autoType);




  @Query("select * from savePoints where bookScope in(:bookScopes) order by modifiedDate desc")
  Stream<List<SavePointEntity>> getStreamSavePointsWithScopes(List<int> bookScopes);

  @Query("""
    select * from savePoints where bookScope in(:bookScopes) and savePointType in (:typeIds)
    order by modifiedDate desc
  """)
  Stream<List<SavePointEntity>> getStreamSavePointsWithScopesAndTypeId(List<int> bookScopes, List<int> typeIds);

  @Query("""
    select * from savePoints where savePointType in (:typeIds) order by modifiedDate desc
  """)
  Stream<List<SavePointEntity>> getStreamSavePointsWithTypeIds(List<int> typeIds);

  @Query("""
    select * from savePoints where savePointType in (:typeIds) and parentKey=:parentKey order by modifiedDate desc
  """)
  Stream<List<SavePointEntity>> getStreamSavePointsWithTypeIdAndParentKey(List<int> typeIds, String parentKey);

}