


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'backup_meta_model.freezed.dart';

@freezed
class BackupMetaModel with _$BackupMetaModel{
  const factory BackupMetaModel({
    int? id,
    required String fileName,
    required String updatedDate,
    required bool isAuto
  }) = _BackupMetaModel;
}