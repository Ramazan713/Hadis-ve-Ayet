

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/entities/helper/int_data.dart';

@dao
abstract class AudioEditionDao{

  @Query("""select * from audioEdition""")
  Stream<List<AudioEdition>> getStreamEditions();

  @Query("""select * from audioEdition where isSelected = 1""")
  Stream<AudioEdition?>getSelectedStreamEdition();

  @Query("""select * from audioEdition""")
  Future<List<AudioEdition>> getEditions();

  @Query("""select exists(select 1 from audioEdition) as data""")
  Future<IntData?>isEditionNotEmpty();

  @Query("""select * from audioEdition where isSelected = 1""")
  Future<AudioEdition?> getSelectedEdition();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertEditions(List<AudioEdition>items);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int>updateAudioEditions(List<AudioEdition>editions);

}