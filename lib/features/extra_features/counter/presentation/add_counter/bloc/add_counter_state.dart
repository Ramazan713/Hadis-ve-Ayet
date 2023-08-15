
import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

class AddCounterStateOld extends Equatable{
  final List<Counter> counters;
  final bool isLoading;
  final String?message;
  final bool navigationPop;

  const AddCounterStateOld({required this.counters,required this.isLoading,this.message,
    required this.navigationPop});

  AddCounterStateOld copyWith({List<Counter>?counters,bool? isLoading,
    bool?navigationPop,String?message,bool setMessage=false}){
    return AddCounterStateOld(
        counters: counters??this.counters,
        isLoading: isLoading??this.isLoading,
        message: setMessage?message:this.message,
        navigationPop: navigationPop??this.navigationPop
    );
  }

  static AddCounterStateOld init(){
    return const AddCounterStateOld(
        counters: [],
        isLoading: false,
        navigationPop: false
    );
  }

  @override
  List<Object?> get props => [counters,isLoading,navigationPop,message];

}