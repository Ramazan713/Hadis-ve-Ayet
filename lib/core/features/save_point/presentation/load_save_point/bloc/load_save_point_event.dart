
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';

abstract class ILoadSavePointEvent{}

class LoadSavePointEventClearResult extends ILoadSavePointEvent{}


class LoadSavePointEventLoadLastOrDefault extends ILoadSavePointEvent{
  final SavePointDestination destination;
  final SaveAutoType autoType;
  final int defaultPos;
  LoadSavePointEventLoadLastOrDefault({
    required this.destination,
    required this.autoType,
    this.defaultPos = 0
  });
}

class LoadSavePointEventLoadLast extends ILoadSavePointEvent{
  final SavePointDestination destination;
  final SaveAutoType autoType;

  LoadSavePointEventLoadLast({
    required this.destination,
    required this.autoType,
  });
}


class LoadSavePointEventNavigateWithSurahDestination extends ILoadSavePointEvent{
  final DestinationSurah destination;
  final int mealId;

  LoadSavePointEventNavigateWithSurahDestination({
    required this.destination,
    required this.mealId,
  });
}


class LoadSavePointEventNavigateToSurahDestinationWithMealId extends ILoadSavePointEvent{
  final int mealId;

  LoadSavePointEventNavigateToSurahDestinationWithMealId({
    required this.mealId,
  });
}
