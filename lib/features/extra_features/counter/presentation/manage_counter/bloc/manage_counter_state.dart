

import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';

class ManageCounterState extends Equatable{
  final CounterType type;
  final String? message;
  final bool navigatePop;

  const ManageCounterState({required this.type,this.message,required this.navigatePop});

  ManageCounterState copyWith({CounterType?type,String?message,bool setMessage=false,
    bool?navigatePop
  }){
    return ManageCounterState(
        type: type??this.type,
        message: setMessage?message:this.message,
        navigatePop: navigatePop??this.navigatePop
    );
  }

  static ManageCounterState init(){
    return const ManageCounterState(
        type: CounterType.classic,
        navigatePop: false
    );
  }

  @override
  List<Object?> get props => [type,message,navigatePop];

}