

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';

class ShowEsmaulHusnaState extends Equatable{
  final List<EsmaulHusna> items;
  final FontSize fontSize;

  const ShowEsmaulHusnaState({required this.items,required this.fontSize});

  ShowEsmaulHusnaState copyWith({List<EsmaulHusna>? items,FontSize?fontSize}){
    return ShowEsmaulHusnaState(
        items: items??this.items,
        fontSize: fontSize??this.fontSize
    );
  }

  static ShowEsmaulHusnaState init(){
    return const ShowEsmaulHusnaState(
        items: [],
        fontSize: FontSize.medium
    );
  }

  @override
  List<Object?> get props => [items,fontSize];
}