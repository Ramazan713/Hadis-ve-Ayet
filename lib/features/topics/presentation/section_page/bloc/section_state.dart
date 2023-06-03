

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';

import '../section_model.dart';

class SectionState extends Equatable{

  final bool searchBarVisible;
  final List<SectionModel> items;


  const SectionState({
    required this.searchBarVisible,
    required this.items
  });

  SectionState copyWith({
    bool? searchBarVisible,
    List<SectionModel>? items
  }){
    return SectionState(
        searchBarVisible: searchBarVisible ?? this.searchBarVisible,
        items: items ?? this.items
    );
  }

  static SectionState init(){
    return const SectionState(
        searchBarVisible: false,
        items: []
    );
  }

  @override
  List<Object?> get props => [searchBarVisible, items];
}