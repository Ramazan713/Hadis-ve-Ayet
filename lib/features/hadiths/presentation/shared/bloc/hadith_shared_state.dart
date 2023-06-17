

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';

class HadithSharedState extends Equatable{

  final PagingModifiedItem? invalidateEvent;
  final FontSize fontSize;
  final int favListId;
  final String name;

  const HadithSharedState({
    this.invalidateEvent,
    required this.fontSize,
    required this.favListId,
    required this.name
  });

  HadithSharedState copyWith({
    PagingModifiedItem? invalidateEvent,
    bool setInvalidateEvent=false,
    FontSize? fontSize,
    int? favListId,
    String? name
  }){
    return HadithSharedState(
        invalidateEvent: setInvalidateEvent?invalidateEvent:this.invalidateEvent,
        fontSize: fontSize??this.fontSize,
        favListId: favListId??this.favListId,
        name: name??this.name
    );
  }

  static HadithSharedState init(){
    return const HadithSharedState(
        fontSize: FontSize.medium,
        favListId: 0,
        name: ""
    );
  }

  @override
  List<Object?> get props => [invalidateEvent,fontSize, favListId, name];
}