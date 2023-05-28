import 'package:floor/floor.dart';

import '../entities/views/hadith_info_list_view.dart';

@dao
abstract class HadithInfoListDao{

  @Query("""
      select * from hadithInfoListView where hadithId = :hadithId
  """)
  Future<HadithInfoListView?> getHadithInfoList(int hadithId);
}