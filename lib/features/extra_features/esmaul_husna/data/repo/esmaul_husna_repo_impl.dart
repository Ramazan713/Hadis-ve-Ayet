

import 'package:hadith/features/extra_features/esmaul_husna/data/esmaul_husna_dao.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';

class EsmaulHusnaRepoImpl extends EsmaulHusnaRepo{
  late final EsmaulHusnaDaoOld _esmaulHusnaDao;

  EsmaulHusnaRepoImpl({required EsmaulHusnaDaoOld esmaulHusnaDao}){
    _esmaulHusnaDao = esmaulHusnaDao;
  }

  @override
  Future<List<EsmaulHusna>> getAllEsmaulHusna() async{
    return (await _esmaulHusnaDao.getAllEsmaulHusna()).map((e) => e.toEsmaulHusna()).toList();
  }

  @override
  Future<EsmaulHusna?> getEsmaulHusnaWithId(int id) async{
    return (await _esmaulHusnaDao.getEsmaulHusnaWithId(id))?.toEsmaulHusna();
  }
}