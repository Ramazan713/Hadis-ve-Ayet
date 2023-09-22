

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

class TopicState extends Equatable{

  final bool searchBarVisible;
  final List<TopicViewModel> items;
  final bool isLoading;

  const TopicState({
    required this.searchBarVisible,
    required this.items,
    required this.isLoading
  });

  TopicState copyWith({
    bool? searchBarVisible,
    List<TopicViewModel>? items,
    bool? isLoading
  }){
    return TopicState(
        searchBarVisible: searchBarVisible ?? this.searchBarVisible,
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading
    );
  }

  static TopicState init(){
    return const TopicState(
        searchBarVisible: false,
        items: [],
        isLoading: false
    );
  }

  @override
  List<Object?> get props => [searchBarVisible, items, isLoading];
}