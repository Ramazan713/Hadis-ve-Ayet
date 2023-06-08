import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';

class CuzState extends Equatable{
  final List<Cuz>items;

  const CuzState({
    required this.items,
  });

  CuzState copyWith({
    List<Cuz>?items,
  }) {
    return CuzState(
        items:items??this.items,
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