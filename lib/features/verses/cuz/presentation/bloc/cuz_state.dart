import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_topic_model.dart';

class CuzState extends Equatable{
  final List<VerseTopicModel<Cuz>> items;
  final bool isLoading;

  const CuzState({
    required this.items,
    required this.isLoading
  });

  CuzState copyWith({
    List<VerseTopicModel<Cuz>>?items,
    bool? isLoading
  }) {
    return CuzState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading
    );
  }

  static CuzState init(){
    return const CuzState(
        items: [],
        isLoading: false
    );
  }

  @override
  List<Object?> get props => [items,isLoading];

}