

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

class SurahState extends Equatable{

  final bool searchBarVisible;
  final List<VerseTopicModel<Surah>> items;
  final bool isLoading;

  const SurahState({
    required this.searchBarVisible,
    required this.items,
    required this.isLoading
  });

  SurahState copyWith({
    bool? searchBarVisible,
    List<VerseTopicModel<Surah>>? items,
    bool? isLoading
  }){
    return SurahState(
        searchBarVisible: searchBarVisible ?? this.searchBarVisible,
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading
    );
  }

  static SurahState init(){
    return const SurahState(
        searchBarVisible: false,
        items: [],
        isLoading: false
    );
  }

  @override
  List<Object?> get props => [searchBarVisible, items, isLoading];
}