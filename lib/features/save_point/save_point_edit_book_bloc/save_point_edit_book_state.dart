

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';

class SavePointEditBookState extends Equatable{
  final DataStatus status;
  final List<SavePoint>savePoints;
  final SavePoint? selectedSavePoint;
  final OriginTag? selectedOriginTag;

  const SavePointEditBookState({required this.status,required this.savePoints,this.selectedSavePoint,this.selectedOriginTag});

  SavePointEditBookState copyWith({
    DataStatus? status,
    List<SavePoint>?savePoints,
    SavePoint?selectedSavePoint,
    bool setSavePoint=false,
    OriginTag? selectedOriginTag,
    bool setOriginTag=false
  }) {
    return SavePointEditBookState(
        status: status ?? this.status,
        savePoints:savePoints??this.savePoints,
        selectedSavePoint : setSavePoint?selectedSavePoint:this.selectedSavePoint,
        selectedOriginTag: setOriginTag?selectedOriginTag:this.selectedOriginTag
    );
  }

  static SavePointEditBookState init(){
    return const SavePointEditBookState(status: DataStatus.initial,savePoints: []);
  }

  @override
  List<Object?> get props => [status,savePoints,selectedSavePoint,selectedOriginTag];

}