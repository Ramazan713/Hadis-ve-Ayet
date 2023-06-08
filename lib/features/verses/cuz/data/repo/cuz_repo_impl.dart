
import 'package:hadith/core/data/local/services/cuz_dao.dart';
import 'package:hadith/features/verses/cuz/data/mapper/cuz_mapper.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';

import '../../domain/repo/cuz_repo.dart';

class CuzRepoImpl extends CuzRepo{
  late final CuzDao _cuzDao;

  CuzRepoImpl({required CuzDao cuzDao}){
    _cuzDao = cuzDao;
  }

  @override
  Future<List<Cuz>>getAllCuz()async{
    return (await _cuzDao.getAllCuz())
        .map((e) => e.toCuz()).toList();
  }

  @override
  Future<Cuz?>getCuz(int cuzNo)async{
    return (await _cuzDao.getCuz(cuzNo))?.toCuz();
  }
}