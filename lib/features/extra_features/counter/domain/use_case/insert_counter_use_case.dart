import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/domain/repo/counter_repo.dart';

class InsertCounterUseCase {
  late final CounterRepoOld _counterRepo;
  InsertCounterUseCase({required CounterRepoOld counterRepo}) {
    _counterRepo = counterRepo;
  }

  Future<int> operator({
    required String name,
    required CounterType counterType,
    String? content,
    String? arabicContent,
    String? meaning,
    int? goal,
    required int lastCounter
  }) async{
    final order = await _counterRepo.getMaxOrder();
    final counter = Counter(
        name: name,
        content: content,
        meaning: meaning,
        arabicContent: arabicContent,
        goal: goal,
        counterType: counterType,
        order: (order??0) + 1,
        lastCounter: lastCounter
    );
    return _counterRepo.insertCounter(counter);
  }
}
