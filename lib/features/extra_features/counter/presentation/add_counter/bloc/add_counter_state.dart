
import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

class AddCounterState extends Equatable{
  final List<Counter> counters;
  final bool isLoading;
  final String?message;
  final bool navigationPop;

  const AddCounterState({required this.counters,required this.isLoading,this.message,
    required this.navigationPop});

  AddCounterState copyWith({List<Counter>?counters,bool? isLoading,
    bool?navigationPop,String?message,bool setMessage=false}){
    return AddCounterState(
        counters: counters??this.counters,
        isLoading: isLoading??this.isLoading,
        message: setMessage?message:this.message,
        navigationPop: navigationPop??this.navigationPop
    );
  }

  static AddCounterState init(){
    return const AddCounterState(
        counters: [],
        isLoading: false,
        navigationPop: false
    );
  }

  @override
  List<Object?> get props => [counters,isLoading,navigationPop,message];

}