

import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';

class ShowPrayerState extends Equatable{
  final List<Prayer> prayers;
  final bool isLoading;

  const ShowPrayerState({required this.prayers,required this.isLoading});

  ShowPrayerState copyWith({List<Prayer>? prayers,bool? isLoading}){
    return ShowPrayerState(
        prayers: prayers??this.prayers,
        isLoading: isLoading??this.isLoading
    );
  }

  static ShowPrayerState init(){
    return const ShowPrayerState(
      isLoading: false,
      prayers: []
    );
  }

  @override
  List<Object?> get props => [prayers,isLoading];

}