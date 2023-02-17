

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/preference_constants.dart';

class CounterSettingState extends Equatable{

  final bool eachDhikrVibration;
  final bool eachEndOfTourVibration;

  const CounterSettingState({required this.eachDhikrVibration,required this.eachEndOfTourVibration});

  CounterSettingState copyWith({bool?eachDhikrVibration,bool?eachEndOfTourVibration}){
    return CounterSettingState(
        eachDhikrVibration: eachDhikrVibration??this.eachDhikrVibration,
        eachEndOfTourVibration: eachEndOfTourVibration??this.eachEndOfTourVibration
    );
  }

  static CounterSettingState init(){
    return CounterSettingState(
        eachDhikrVibration: PrefConstants.eachDhikrVibration.defaultValue,
        eachEndOfTourVibration: PrefConstants.eachEndOfTourVibration.defaultValue
    );
  }

  @override
  List<Object?> get props => [eachDhikrVibration,eachEndOfTourVibration];
}