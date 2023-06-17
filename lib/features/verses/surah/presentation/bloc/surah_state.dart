

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/scroll_direction.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

class SurahState extends Equatable{

  final bool searchBarVisible;
  final List<Surah> items;
  final bool isLoading;

  const SurahState({
    required this.searchBarVisible,
    required this.items,
    required this.isLoading
  });

  SurahState copyWith({
    bool? searchBarVisible,
    List<Surah>? items,
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