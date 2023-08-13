

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';

class ShowEsmaulHusnaStateOld extends Equatable{
  final List<EsmaulHusna> items;
  final FontSize fontSize;

  const ShowEsmaulHusnaStateOld({required this.items,required this.fontSize});

  ShowEsmaulHusnaStateOld copyWith({List<EsmaulHusna>? items,FontSize?fontSize}){
    return ShowEsmaulHusnaStateOld(
        items: items??this.items,
        fontSize: fontSize??this.fontSize
    );
  }

  static ShowEsmaulHusnaStateOld init(){
    return const ShowEsmaulHusnaStateOld(
        items: [],
        fontSize: FontSize.medium
    );
  }

  @override
  List<Object?> get props => [items,fontSize];
}