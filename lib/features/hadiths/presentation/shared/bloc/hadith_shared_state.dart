

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';

import '../model/hadith_invalidate_event.dart';

class HadithSharedState extends Equatable{

  final HadithInvalidateEventModel? invalidateEvent;
  final FontSize fontSize;
  final int favListId;

  const HadithSharedState({
    this.invalidateEvent,
    required this.fontSize,
    required this.favListId
  });

  HadithSharedState copyWith({
    HadithInvalidateEventModel? invalidateEvent,
    bool setInvalidateEvent=false,
    FontSize? fontSize,
    int? favListId
  }){
    return HadithSharedState(
        invalidateEvent: setInvalidateEvent?invalidateEvent:this.invalidateEvent,
        fontSize: fontSize??this.fontSize,
        favListId: favListId??this.favListId
    );
  }

  static HadithSharedState init(){
    return const HadithSharedState(
        fontSize: FontSize.medium,
        favListId: 0
    );
  }

  @override
  List<Object?> get props => [invalidateEvent,fontSize, favListId];
}