

import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';

abstract class EsmaulHusnaRepo{

  Future<void> addCounterFromEsmaulHusna(EsmaulHusna esmaulHusna);

  Future<List<EsmaulHusna>> getEsmaulHusnas();

  Stream<List<EsmaulHusna>> getStreamEsmaulHusnas();

  Future<List<EsmaulHusna>> getSearchedEsmaulHusnas(String query, SearchCriteriaEnum criteria);

  Stream<List<EsmaulHusna>> getStreamSearchedEsmaulHusnas(String query, SearchCriteriaEnum criteria);

}