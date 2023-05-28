

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';

class ListModel extends Equatable{

  final int? id;
  final String name;
  final bool isRemovable;
  final SourceTypeEnum sourceType;
  final bool isArchive;
  final int pos;

  const ListModel({this.id,required this.name,this.isArchive=false,
    required this.isRemovable,required this.sourceType,required this.pos});

  ListModel copyWith({
    int? id, bool setId = false,
    String? name,
    bool? isRemovable,
    SourceTypeEnum? sourceType,
    bool? isArchive,
    int? pos
  }){
    return ListModel(
        id: setId ? id : this.id,
        name: name ?? this.name,
        isRemovable: isRemovable ?? this.isRemovable,
        sourceType: sourceType ?? this.sourceType,
        isArchive: isArchive ?? this.isArchive,
        pos: pos??this.pos
    );
  }


  @override
  List<Object?> get props => [id, name, isRemovable, sourceType, isArchive, pos];
}