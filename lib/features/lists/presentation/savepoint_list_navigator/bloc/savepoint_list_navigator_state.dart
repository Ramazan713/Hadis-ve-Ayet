

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
part 'savepoint_list_navigator_state.freezed.dart';

@freezed
class SavePointListNavigatorState with _$SavePointListNavigatorState{
  const factory SavePointListNavigatorState({
    required bool hasError,
    ListModel? navigateToList
  }) = _SavePointListNavigatorState;

  static SavePointListNavigatorState init(){
    return const SavePointListNavigatorState(
      hasError: false
    );
  }

}