

import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/counter/data/entity/counter_entity.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';

class Counter extends Equatable{
  final int? id;
  final String name;
  final String? content;
  final String? arabicContent;
  final String? meaning;
  final int order;
  final int lastCounter;
  final int? goal;
  final CounterType counterType;
  final bool isRemovable;

  const Counter({this.id,required this.name,this.content,this.arabicContent,required this.order,
    this.goal,required this.counterType,required this.lastCounter,this.isRemovable=true,
    this.meaning
  });


  Counter copyWith({int? id,String? name,int? order,CounterType? counterType,
    String? content,String? arabicContent,int? goal,bool setContent=false,
    bool setGoal=false,bool setArabicContent = false,bool setId=false,
    int?lastCounter,String? meaning,bool setMeaning=false
  }){
    return Counter(
        id: setId?id:this.id,
        name: name??this.name,
        content: setContent?content:this.content,
        arabicContent: setArabicContent?arabicContent:this.arabicContent,
        order: order??this.order,
        goal: setGoal?goal:this.goal,
        counterType: counterType??this.counterType,
        lastCounter: lastCounter??this.lastCounter,
        isRemovable: isRemovable,
        meaning: setMeaning?meaning:this.meaning
    );
  }

  CounterEntity toCounterEntity(){
    return CounterEntity(
        id: id,
        name: name,
        content: content,
        arabicContent: arabicContent,
        meaning: meaning,
        orderItem: order,
        goal: goal,
        type: counterType.type,
        lastCounter:lastCounter,
        isRemovable: isRemovable
    );
  }


  @override
  List<Object?> get props => [id,name,content,arabicContent,order,goal,
    counterType,lastCounter,isRemovable,meaning
  ];
}