import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/db/entities/backup_meta.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'backup_meta_state.freezed.dart';

@freezed
class BackupMetaState with _$BackupMetaState{
  const factory BackupMetaState({
    required bool isLoading,
    required List<BackupMetaModel> items,
    required bool isRefreshDisabled,
    required String counter,
    BackupMetaModel? selectedItem,
    String? message
  }) = _BackupMetaState;

  static BackupMetaState init(){
    return const BackupMetaState(
      isLoading: false,
      items: [],
      counter: "",
      isRefreshDisabled: false,
    );
  }
}