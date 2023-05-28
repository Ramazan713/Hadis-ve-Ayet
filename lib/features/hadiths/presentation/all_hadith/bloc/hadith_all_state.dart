

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';

import '../model/hadith_invalidate_event.dart';

class HadithAllState extends Equatable{

  final HadithInvalidateEvent? invalidateEvent;
  final FontSize fontSize;

  const HadithAllState({this.invalidateEvent, required this.fontSize});

  HadithAllState copyWith({
    HadithInvalidateEvent? invalidateEvent,
    bool setInvalidateEvent=false,
    FontSize? fontSize
  }){
    return HadithAllState(
        invalidateEvent: setInvalidateEvent?invalidateEvent:this.invalidateEvent,
        fontSize: fontSize??this.fontSize
    );
  }

  static HadithAllState init(){
    return const HadithAllState(
        fontSize: FontSize.medium
    );
  }

  @override
  List<Object?> get props => [invalidateEvent,fontSize];
}