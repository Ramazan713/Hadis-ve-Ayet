import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';

class ShowSavePointState extends Equatable{
  final List<SavePoint> savePoints;
  final DataStatus status;
  final SavePointType? selectedMenuItem;
  final SavePoint? selectedSavePoint;
  final String? message;

  const ShowSavePointState({
    required this.status,
    required this.selectedSavePoint,
    required this.savePoints,
    this.selectedMenuItem,
    this.message
  });

  ShowSavePointState copyWith({
    DataStatus? status,
    SavePoint?selectedSavePoint,
    bool setSavePoint=false,
    List<SavePoint>? savePoints,
    SavePointType? selectedMenuItem, bool setSelectedMenuItem = false,
    String? message, bool setMessage=false
  }) {
    return ShowSavePointState(
        status: status ?? this.status,
        selectedSavePoint: setSavePoint?selectedSavePoint??this.selectedSavePoint:selectedSavePoint,
        savePoints: savePoints??this.savePoints,
        message: setMessage ? message : this.message,
        selectedMenuItem: setSelectedMenuItem ? selectedMenuItem : this.selectedMenuItem
    );
  }

  static ShowSavePointState init(){
    return const ShowSavePointState(
        status: DataStatus.initial,
        savePoints: [],
        selectedSavePoint: null,
    );
  }

  @override
  List<Object?> get props => [status,selectedSavePoint,savePoints, message, selectedMenuItem];

}