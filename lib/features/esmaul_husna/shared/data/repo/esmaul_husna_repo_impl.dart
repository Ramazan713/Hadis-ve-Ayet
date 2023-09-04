

import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';
import 'package:hadith/core/data/local/services/counter_dao.dart';
import 'package:hadith/core/data/local/services/esmaul_husna_dao.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/esmaul_husna/shared/data/mapper/esmaul_husna_mapper.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/repo/esmaul_husna_repo.dart';

class EsmaulHusnaRepoImpl extends EsmaulHusnaRepo{

  late final EsmaulHusnaDao _esmaulHusnaDao;
  late final CounterDao _counterDao;

  EsmaulHusnaRepoImpl({
    required EsmaulHusnaDao esmaulHusnaDao,
    required CounterDao counterDao
  }){
    _esmaulHusnaDao = esmaulHusnaDao;
    _counterDao = counterDao;
  }

  @override
  Future<void> addCounterFromEsmaulHusna(EsmaulHusna esmaulHusna) async{
    final maxPos = (await _counterDao.getMaxOrder()) ?? 0;
    final counterEntity = esmaulHusna.toCounterEntity(orderItem: maxPos + 1);
    final counterId = await _counterDao.insertCounterEntity(counterEntity);
    final updatedEsmaulHusna = esmaulHusna.copyWith(counterId: counterId);
    await _esmaulHusnaDao.updateEsmaulHusna(updatedEsmaulHusna.toEsmaulHusnaEntity());
  }

  @override
  Stream<List<EsmaulHusna>> getStreamEsmaulHusnas(){
    return _esmaulHusnaDao.getStreamEsmaulHusnas()
        .map((items) => items.map((e) => e.toEsmaulHusna()).toList());
  }

  @override
  Future<List<EsmaulHusna>> getEsmaulHusnas() async{
    return (await _esmaulHusnaDao.getEsmaulHusnas())
        .map((e) => e.toEsmaulHusna()).toList();
  }

  @override
  Future<List<EsmaulHusna>> getSearchedEsmaulHusnas(String query, SearchCriteriaEnum criteria) async{
    final queryExp = criteria.getQuery(query);
    final List<EsmaulHusnaEntity> entities;
    if(criteria.isRegex){
      entities = await _esmaulHusnaDao.getEsmaulHusnasSearchedRegEx(queryExp);
    }else{
      entities = await _esmaulHusnaDao.getEsmaulHusnasSearchedLike(queryExp);
    }
    return entities.map((e) => e.toEsmaulHusna()).toList();
  }

}