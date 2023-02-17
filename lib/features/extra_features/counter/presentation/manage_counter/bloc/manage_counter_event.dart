
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class IManageCounterEvent{}

class ManageCounterEventUpdate extends IManageCounterEvent{
  final Counter? counter;
  final String newName;
  final String? newContent;
  final String? newArabicContent;
  final String? newGoal;
  final String? newMeaning;
  ManageCounterEventUpdate({this.counter,required this.newName,
  this.newArabicContent,this.newContent,this.newGoal,this.newMeaning});
}

class ManageCounterEventSetType extends IManageCounterEvent{
  final CounterType type;
  ManageCounterEventSetType({required this.type});
}



