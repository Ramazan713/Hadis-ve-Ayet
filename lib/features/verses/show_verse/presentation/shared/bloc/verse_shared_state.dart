import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';
import 'package:hadith/core/domain/models/font_model.dart';


class VerseSharedState extends Equatable{

  final FontModel fontModel;
  final ArabicVerseUI2X arabicVerseUIEnum;
  final bool showListVerseIcons;
  final PagingModifiedItem? invalidateEvent;
  final int favListId;
  final String title;

  const VerseSharedState({
    required this.fontModel,
    required this.arabicVerseUIEnum,
    required this.showListVerseIcons,
    this.invalidateEvent,
    required this.favListId,
    required this.title
  });

  VerseSharedState copyWith({
    FontModel? fontModel,
    ArabicVerseUI2X? arabicVerseUIEnum,
    bool? showListVerseIcons,
    PagingModifiedItem? invalidateEvent, bool setInvalidateEvent=false,
    int? favListId,
    String? title
  }){
    return VerseSharedState(
        invalidateEvent: setInvalidateEvent?invalidateEvent:this.invalidateEvent,
        fontModel: fontModel ?? this.fontModel,
        arabicVerseUIEnum: arabicVerseUIEnum ?? this.arabicVerseUIEnum,
        showListVerseIcons: showListVerseIcons ?? this.showListVerseIcons,
        favListId: favListId ?? this.favListId,
        title: title ?? this.title
    );
  }

  static VerseSharedState init(){
    return VerseSharedState(
        fontModel: FontModel.init(),
        arabicVerseUIEnum: ArabicVerseUI2X.both,
        showListVerseIcons: false,
        favListId: 0,
        title: ""
    );
  }

  @override
  List<Object?> get props => [fontModel, arabicVerseUIEnum,favListId, title, showListVerseIcons, invalidateEvent];
}