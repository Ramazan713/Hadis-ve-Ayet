import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/save_point/load_save_point/model/result_load_save_point.dart';

class LoadSavePointState extends Equatable{

  final ResultLoadSavePoint? resultLoadSavePoint;

  const LoadSavePointState({this.resultLoadSavePoint});

  LoadSavePointState copyWith({
    ResultLoadSavePoint? resultLoadSavePoint, bool setResult = false
  }){
    return LoadSavePointState(
        resultLoadSavePoint: setResult ? resultLoadSavePoint : this.resultLoadSavePoint
    );
  }

  static LoadSavePointState init(){
    return const LoadSavePointState(

    );
  }

  @override
  List<Object?> get props => [resultLoadSavePoint];

}