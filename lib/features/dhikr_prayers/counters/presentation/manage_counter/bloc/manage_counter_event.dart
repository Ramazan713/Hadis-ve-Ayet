

import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

abstract class IManageCounterEvent{}

class ManageCounterEventLoadData extends IManageCounterEvent{
  final int? counterId;
  ManageCounterEventLoadData({required this.counterId});
}

class ManageCounterEventClearMessage extends IManageCounterEvent{}

class ManageCounterEventClearNavigateBack extends IManageCounterEvent{}


class ManageCounterEventUpdate extends IManageCounterEvent{
  final String newName;
  final String? newContent;
  final String? newArabicContent;
  final String? newGoal;
  final String? newMeaning;
  final String? description;

  ManageCounterEventUpdate({
    required this.newName,
    this.newArabicContent,
    this.newContent,
    this.newGoal,
    this.newMeaning,
    this.description
  });
}

class ManageCounterEventSetType extends IManageCounterEvent{
  final CounterType type;
  ManageCounterEventSetType({required this.type});
}



