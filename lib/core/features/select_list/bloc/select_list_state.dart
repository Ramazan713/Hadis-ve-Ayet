

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';

class SelectListState extends Equatable{

  final List<SelectableListViewModel> items;
  final int itemId;
  final SourceTypeEnum sourceType;
  final int? listIdControl;
  final String? message;

  const SelectListState({
    required this.items,
    required this.itemId,
    required this.sourceType,
    this.listIdControl,
    this.message
  });

  SelectListState copyWith({
    List<SelectableListViewModel>? items,
    int? itemId,
    SourceTypeEnum? sourceType,
    int? listIdControl, bool setListIdControl = false,
    String? message, bool setMessage = false,
  }){
    return SelectListState(
        items: items ?? this.items,
        itemId: itemId ?? this.itemId,
        sourceType: sourceType ?? this.sourceType,
        listIdControl: setListIdControl ? listIdControl : this.listIdControl,
        message: setMessage ? message : this.message,
    );
  }


  static SelectListState init(){
    return const SelectListState(
        items: [],
        sourceType: SourceTypeEnum.hadith,
        itemId: 0,
    );
  }


  @override
  List<Object?> get props => [items, sourceType, itemId, listIdControl, message];
}