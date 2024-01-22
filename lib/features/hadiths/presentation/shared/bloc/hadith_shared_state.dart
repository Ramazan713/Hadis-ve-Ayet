

import 'package:equatable/equatable.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_modified_item.dart';

class HadithSharedState extends Equatable{

  final PagingModifiedItem? invalidateEvent;
  final double contentFontSize;
  final int favListId;
  final String title;

  const HadithSharedState({
    this.invalidateEvent,
    required this.contentFontSize,
    required this.favListId,
    required this.title
  });

  HadithSharedState copyWith({
    PagingModifiedItem? invalidateEvent,
    bool setInvalidateEvent=false,
    double? contentFontSize,
    int? favListId,
    String? title
  }){
    return HadithSharedState(
        invalidateEvent: setInvalidateEvent?invalidateEvent:this.invalidateEvent,
        contentFontSize: contentFontSize??this.contentFontSize,
        favListId: favListId??this.favListId,
        title: title??this.title
    );
  }

  static HadithSharedState init(){
    return HadithSharedState(
        contentFontSize: KPref.fontSizeContent.defaultPrefEnum.size,
        favListId: 0,
        title: ""
    );
  }

  @override
  List<Object?> get props => [invalidateEvent, contentFontSize, favListId, title];
}