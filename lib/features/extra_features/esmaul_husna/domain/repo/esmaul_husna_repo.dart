

import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';

abstract class EsmaulHusnaRepo{

  Future<List<EsmaulHusna>>getAllEsmaulHusna();
  Future<EsmaulHusna?>getEsmaulHusnaWithId(int id);

}
