import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';

class ShowSavePointState extends Equatable{
  final List<SavePoint> savePoints;
  final DataStatus status;
  final SavePointType selectedMenuItem;
  final SavePoint? selectedSavePoint;

  const ShowSavePointState({required this.status,required this.selectedSavePoint,
    required this.savePoints, required this.selectedMenuItem
  });

  ShowSavePointState copyWith({
    DataStatus? status,
    SavePoint?selectedSavePoint,
    bool setSavePoint=false,
    List<SavePoint>? savePoints,
    SavePointType? selectedMenuItem
  }) {
    return ShowSavePointState(
        status: status ?? this.status,
        selectedSavePoint: setSavePoint?selectedSavePoint??this.selectedSavePoint:selectedSavePoint,
        savePoints: savePoints??this.savePoints,
        selectedMenuItem: selectedMenuItem??this.selectedMenuItem
    );
  }

  static ShowSavePointState init(){
    return const ShowSavePointState(
        status: DataStatus.initial,
        savePoints: [],
        selectedSavePoint: null,
        selectedMenuItem: SavePointType.all
    );
  }

  @override
  List<Object?> get props => [status,selectedSavePoint,savePoints, selectedMenuItem];

}