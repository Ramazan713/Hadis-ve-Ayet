

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "BackupMetas")
class BackupMetaEntity{

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String fileName;
  final String updatedDate;
  final bool isAuto;

  const BackupMetaEntity({
    this.id,
    required this.fileName,
    required this.updatedDate,
    required this.isAuto
  });
}