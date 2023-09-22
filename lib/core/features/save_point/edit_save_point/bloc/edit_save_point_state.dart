import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/local_destination_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/save_point.dart';

class EditSavePointState extends Equatable{

  final LocalDestinationScope localScope;
  final String? message;
  final SavePointDestination destination;
  final int position;
  final List<SavePoint> savePoints;
  final int? selectedSavePointId;

  const EditSavePointState({required this.selectedSavePointId,
    required this.savePoints, required this.localScope,
    this.message, required this.destination, required this.position
  });

  SavePoint? get selectedSavePoint {
    return savePoints.firstWhereOrNull((e) => e.id == selectedSavePointId);
  }

  EditSavePointState copyWith({
    int?selectedSavePointId, bool setSelectedSavePointId = false,
    List<SavePoint>? savePoints,
    LocalDestinationScope? localScope,
    String? message, bool setMessage = false,
    SavePointDestination? destination,
    int? position
  }) {
    return EditSavePointState(
        selectedSavePointId: setSelectedSavePointId ? selectedSavePointId : this.selectedSavePointId,
        savePoints: savePoints ?? this.savePoints,
        localScope: localScope ?? this.localScope,
        message: setMessage ? message : this.message,
        destination: destination ?? this.destination,
        position: position ?? this.position
    );
  }

  static EditSavePointState init(){
    return EditSavePointState(
        savePoints: const [],
        selectedSavePointId: null,
        localScope: LocalDestinationScope.restrict,
        position: 0,
        destination: DestinationAll(bookEnum: BookEnum.serlevha)
    );
  }

  @override
  List<Object?> get props => [
    position,destination,selectedSavePointId,message,savePoints, localScope];

}