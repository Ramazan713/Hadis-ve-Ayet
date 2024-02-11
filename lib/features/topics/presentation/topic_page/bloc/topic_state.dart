

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

part 'topic_state.freezed.dart';

@freezed
class TopicState with _$TopicState{

  const TopicState._();

  const factory TopicState({
    required bool searchBarVisible,
    required List<TopicViewModel> items,
    required bool isLoading,
    required bool isDetailOpen,
    TopicViewModel? selectedItem
  }) = _TopicState;

  TopicViewModel? get currentSelectedItem => items.firstWhereOrNull((e) => e.id == selectedItem?.id);

  static TopicState init(){
    return const TopicState(
      isDetailOpen: false,
      isLoading: false,
      items: [],
      searchBarVisible: false
    );
  }
}
