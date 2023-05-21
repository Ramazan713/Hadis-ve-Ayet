

import 'package:equatable/equatable.dart';
import 'package:hadith/features/hadiths/presentation/model/hadith_invalidate_event.dart';

class HadithState extends Equatable{

  final HadithInvalidateEvent? invalidateEvent;

  const HadithState({this.invalidateEvent});

  HadithState copyWith({
    HadithInvalidateEvent? invalidateEvent,
    bool setInvalidateEvent=false
  }){
    return HadithState(
      invalidateEvent: setInvalidateEvent?invalidateEvent:this.invalidateEvent
    );
  }

  static HadithState init(){
    return const HadithState(
    );
  }

  @override
  List<Object?> get props => [invalidateEvent];
}