import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_topic_model.dart';

class CuzState extends Equatable{
  final List<VerseTopicModel<Cuz>> items;

  const CuzState({
    required this.items,
  });

  CuzState copyWith({
    List<VerseTopicModel<Cuz>>?items,
  }) {
    return CuzState(
        items: items ?? this.items,
    );
  }

  static CuzState init(){
    return const CuzState(
        items: [],
    );
  }

  @override
  List<Object?> get props => [items];

}