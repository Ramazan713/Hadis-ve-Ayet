


import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/audio_edition_entity.dart';

@dao
abstract class AudioEditionDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEditions(List<AudioEditionEntity>items);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void>updateAudioEditions(List<AudioEditionEntity>editions);

  @Query("""select * from audioEdition""")
  Future<List<AudioEditionEntity>> getEditions();

  @Query("""select * from audioEdition""")
  Stream<List<AudioEditionEntity>> getStreamEditions();

  @Query("""select * from audioEdition where isSelected = 1""")
  Stream<AudioEditionEntity?> getSelectedStreamEdition();

  @Query("""select * from audioEdition where isSelected = 1""")
  Future<AudioEditionEntity?> getSelectedEdition();




  @Query("""select exists(select 1 from audioEdition) as data""")
  Future<bool?> isEditionNotEmpty();

  @Query("""
    select * from audioEdition where identifier = :identifier
  """)
  Future<AudioEditionEntity?> getEditionByIdentifier(String identifier);

  @Query("""
    select name from audioEdition where identifier = :identifier
  """)
  Future<String?> getEditionNameByIdentifier(String identifier);

}