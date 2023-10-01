


import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/extensions/date_time_ext.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/save_point/save_auto_type.dart';

class SavePoint extends Equatable{
  final int? id;
  final int itemPos;
  final String title;
  final SaveAutoType autoType;
  final String modifiedDate;
  final SavePointDestination destination;

  const SavePoint({
    this.id,
    required this.itemPos,
    required this.title,
    required this.autoType,
    required this.modifiedDate,
    required this.destination
  });

  SavePoint copyWith({
    int? id, bool setId = false,
    int? itemIndexPos,
    String? title,
    SaveAutoType? autoType,
    String? modifiedDate,
    SavePointDestination? destination
  }){
    return SavePoint(
        itemPos: itemIndexPos ?? this.itemPos,
        title: title ?? this.title,
        autoType: autoType ?? this.autoType,
        id: setId ? id : this.id,
        destination: destination ?? this.destination,
        modifiedDate: modifiedDate ?? this.modifiedDate
    );
  }

  @override
  List<Object?> get props => [id,itemPos,title,autoType,modifiedDate,destination];



  static String getAutoSavePointTitle(
      SavePointDestination destination, {
        required String date,
        SaveAutoType autoType = SaveAutoType.none,
        bool useLocalWideScope = false
  }){

    final saveLabel = autoType.label != "" ? "${autoType.label} -" : "";
    final name = useLocalWideScope ? destination.getType().title : destination.getParentName();
    final sourceName = destination.getBookScope().sourceType.shortName;
    final readableDate = DateTimeFormats.formatDate1(date);

    return "$saveLabel $name - $sourceName - $readableDate";
  }
}