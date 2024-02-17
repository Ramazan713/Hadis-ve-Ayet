import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';

part 'archive_list_state.freezed.dart';

@freezed
class ArchiveListState with _$ArchiveListState{
  const factory ArchiveListState({
    required List<ListViewModel> listModels,
    required bool isDetailOpen,
    ListViewModel? selectedItem,
    String? message
  }) = _ArchiveListState;

  static ArchiveListState init(){
    return const ArchiveListState(
      isDetailOpen: false,
      listModels: []
    );
  }
}