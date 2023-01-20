import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/features/save_point/constants/scope_filter_enum.dart';

class SavePointEditState extends Equatable{
  final DataStatus status;
  final List<SavePoint>savePoints;
  final ScopeFilterEnum? scopeFilter;
  final SavePoint? selectedSavePoint;
  final String?message;

  const SavePointEditState({required this.status,required this.savePoints,this.scopeFilter,this.selectedSavePoint,this.message});

  SavePointEditState copyWith({
    DataStatus? status,
    List<SavePoint>?savePoints,
    ScopeFilterEnum?scopeFilter,
    bool setScopeFilter=false,
    SavePoint?selectedSavePoint,
    bool setSelectedSavePoint=false,
    String?message,
    bool setMessage=false

  }) {
    return SavePointEditState(
        status: status ?? this.status,
        savePoints:savePoints??this.savePoints,
        scopeFilter: setScopeFilter?scopeFilter:this.scopeFilter,
        selectedSavePoint: setSelectedSavePoint ? selectedSavePoint : this.selectedSavePoint,
        message: setMessage ? message :this.message
    );
  }

  static SavePointEditState init(){
    return const SavePointEditState(status: DataStatus.initial, savePoints: []);
  }

  @override
  List<Object?> get props => [status,savePoints,scopeFilter,selectedSavePoint,message];

}