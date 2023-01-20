

import 'package:equatable/equatable.dart';

class Progress extends Equatable{
  final int received;
  final int total;
  final int currentCount;
  final int totalCount;

  const Progress({required this.received,required this.total,
    this.currentCount=0,this.totalCount=0});

  Progress copyWith({int? received,int? total,int? currentCount,int?totalCount}){
    return Progress(received: received??this.received, total: total??this.total,
      currentCount: currentCount??this.currentCount,
      totalCount: totalCount??this.totalCount
    );
  }

  static Progress init(){
    return const Progress(received: 0, total: 0);
  }

  String getDownloadedMB(){
    return "${(received/(1024*1024)).toStringAsFixed(3)} MB";
  }

  int getPercentage(){
    if(total<0.1) {
      return 0;
    }
    return (double.parse((received/total).toStringAsFixed(1))*100).toInt();
  }

  int getPercentageCount(){
    if(currentCount==0){
      return 0;
    }
    return (double.parse((currentCount/totalCount).toStringAsFixed(1))*100).toInt();
  }

  double getPercentageNorm(){
    if(total<0.1) {
      return 0.0;
    }
    return double.parse((received/total).toStringAsFixed(1))*100;
  }

  String getProgressCount(){
    return "( $currentCount/$totalCount )";
  }

  String getProgressInfo(){
    return "${getProgressCount()} ${getDownloadedMB()}";
  }

  @override
  List<Object?> get props => [received,total,currentCount,totalCount];
}