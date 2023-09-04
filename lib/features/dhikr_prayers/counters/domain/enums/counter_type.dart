

import 'package:hadith/core/domain/models/i_menu_item.dart';

enum CounterType implements IMenuItem{
  classic(
    typeId: 1,
    title: "Klasik (99 lu)"
  ),
  unlimited(
    typeId: 2,
    title: "Sınırsız"
  );

  const CounterType({
    required this.typeId,
    required this.title
  });

  final int typeId;

  @override
  final String title;

  @override
  get iconInfo => null;

  static CounterType from(int typeId){
    if(CounterType.unlimited.typeId == typeId){
      return CounterType.unlimited;
    }
    return CounterType.classic;
  }
}
