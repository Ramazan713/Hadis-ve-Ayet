

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';

import '../section_model.dart';

class SectionState extends Equatable{

  final bool searchBarVisible;
  final List<SectionModel> items;
  final bool isLoading;

  const SectionState({
    required this.searchBarVisible,
    required this.items,
    required this.isLoading
  });

  SectionState copyWith({
    bool? searchBarVisible,
    List<SectionModel>? items,
    bool? isLoading
  }){
    return SectionState(
        searchBarVisible: searchBarVisible ?? this.searchBarVisible,
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading
    );
  }

  static SectionState init(){
    return const SectionState(
        searchBarVisible: false,
        items: [],
        isLoading: false
    );
  }

  @override
  List<Object?> get props => [searchBarVisible, items, isLoading];
}