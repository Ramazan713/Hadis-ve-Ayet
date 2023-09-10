
import 'package:collection/collection.dart';
import 'package:hadith/core/data/local/services/counter_dao.dart';
import 'package:hadith/core/data/local/services/prayer_dao.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';

class PrayerCustomRepoImpl extends PrayerCustomRepo{
  late final PrayerDao _prayerDao;
  late final CounterDao _counterDao;
  late final QueryExtUseCase _queryUseCase;

  PrayerCustomRepoImpl({
    required PrayerDao prayerDao,
    required CounterDao counterDao,
    required QueryExtUseCase queryExtUseCase
  }){
    _prayerDao = prayerDao;
    _counterDao = counterDao;
    _queryUseCase = queryExtUseCase;
  }

  @override
  Future<void> insertPrayerCustom(PrayerCustom prayer) async{
    await _prayerDao.insertPrayerWithOrder(prayer.toPrayerEntity());
  }

  @override
  Future<void> updatePrayerCustom(PrayerCustom prayer) async{
    await _prayerDao.updatePrayer(prayer.toPrayerEntity());
  }

  @override
  Future<void> deletePrayerCustom(PrayerCustom prayer) async{
    await _prayerDao.deletePrayer(prayer.toPrayerEntity());
  }


  @override
  Future<void> addToCounter(PrayerCustom prayer) async{
    final maxPos = (await _counterDao.getMaxOrder() ?? 0) + 1;
    final counterEntity = prayer.toCounterEntity(orderItem: maxPos + 1);
    final counterId = await _counterDao.insertCounterEntity(counterEntity);
    final updatedPrayer = prayer.copyWith(counterId: counterId).toPrayerEntity();
    _prayerDao.updatePrayer(updatedPrayer);
  }

  @override
  Future<void> updateToCounter(PrayerCustom prayer) async{
    final counterId = prayer.counterId;
    if(counterId == null) return;

    final counterEntity = await _counterDao.getCounterById(counterId);
    if(counterEntity == null) return;

    final updatedCounterEntity = prayer.toCounterEntity(
        orderItem: counterEntity.orderItem,
        typeId: counterEntity.typeId,
        lastCounter: counterEntity.lastCounter,
        counterId: counterEntity.id,
        goal: counterEntity.goal
    );

    await _counterDao.updateCounterEntity(updatedCounterEntity);

    final updatedPrayer = prayer.copyWith(updateCounter: false).toPrayerEntity();
    await _prayerDao.updatePrayer(updatedPrayer);
  }

  @override
  Future<List<PrayerCustom>> getPrayerCustoms() async{
    return (await _prayerDao.getPrayersWithTypeId(PrayerTypeEnum.custom.typeId))
        .map((e) => e.tryToPrayerCustom()).whereNotNull().toList();
  }

  @override
  Stream<List<PrayerCustom>> getStreamPrayerCustoms(){
    return _prayerDao.getStreamPrayersWithTypeId(PrayerTypeEnum.custom.typeId)
        .map((items) => items.map((e) => e.tryToPrayerCustom())
        .whereNotNull().toList());
  }

  @override
  Stream<PrayerCustom?> getStreamPrayerCustomById(int id) {
    return _prayerDao.getStreamPrayersWithId(id).map((e){
      return e?.tryToPrayerCustom();
    });
  }

  @override
  Future<PrayerCustom?> getPrayerCustomById(int id) async{
    return (await _prayerDao.getPrayersWithId(id))?.tryToPrayerCustom();
  }

  @override
  Stream<List<PrayerCustom>> getStreamSearchedCustomPrayers(String query){
    final queryResult = _queryUseCase.call(query);
    final entities = _prayerDao.getPrayersSearchedWithTypeIdAndTitle(
        PrayerTypeEnum.custom.typeId,
        queryResult.queryLikeForSearch,
        queryResult.queryLikeForOrder,
        queryResult.queryRaw
    );
    return entities
        .map((items) => items.map((e) => e.tryToPrayerCustom()).whereNotNull().toList());
  }
}