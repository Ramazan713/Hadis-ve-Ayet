import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';

class ShowSavePointState extends Equatable{
  final List<SavePoint> savePoints;
  final bool isLoading;
  final SavePointType? selectedMenuItem;
  final SavePoint? selectedSavePoint;
  final String? message;

  const ShowSavePointState({
    required this.isLoading,
    required this.selectedSavePoint,
    required this.savePoints,
    this.selectedMenuItem,
    this.message
  });

  ShowSavePointState copyWith({
    bool? isLoading,
    SavePoint?selectedSavePoint,
    bool setSavePoint=false,
    List<SavePoint>? savePoints,
    SavePointType? selectedMenuItem, bool setSelectedMenuItem = false,
    String? message, bool setMessage=false
  }) {
    return ShowSavePointState(
        isLoading: isLoading ?? this.isLoading,
        selectedSavePoint: setSavePoint?selectedSavePoint??this.selectedSavePoint:selectedSavePoint,
        savePoints: savePoints??this.savePoints,
        message: setMessage ? message : this.message,
        selectedMenuItem: setSelectedMenuItem ? selectedMenuItem : this.selectedMenuItem
    );
  }

  static ShowSavePointState init(){
    return const ShowSavePointState(
      isLoading: false,
      savePoints: [],
      selectedSavePoint: null,
    );
  }

  @override
  List<Object?> get props => [isLoading,selectedSavePoint,savePoints, message, selectedMenuItem];

}