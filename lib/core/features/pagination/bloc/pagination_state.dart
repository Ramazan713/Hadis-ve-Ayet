import 'dart:collection';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';
import '../../../domain/enums/paging/paging_status.dart';
import '../../../domain/models/paging/i_paging_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pagination_state.freezed.dart';

@freezed
class PaginationState<T extends IPagingItem> with _$PaginationState{
  const factory PaginationState({
    required int currentPage,
    required int prevPage,
    required int pageSize,
    required int totalItems,
    required int totalStaticPages,
    required List<T> items,
    required HashMap<int, List<T>> itemsByPage,
    required PagingStatus status,
    required int preFetchDistance,
    required double jumpToAlignment,
    required int visibleMinPos,
    required int visibleMaxPos,
    PagingModifiedItem? lastModifiedItem,
    int? jumpToPos,
  }) = _PaginationState;


  int get totalDynamicPages => totalItems ~/ pageSize;
  int get visibleMiddlePos => (visibleMaxPos + visibleMinPos) ~/ 2;
  IPagingItem? get visibleMiddleItem => items.elementAtOrNull(visibleMiddlePos);

  const PaginationState._();

  static PaginationState init(){
    return PaginationState(
      prevPage: 0,
      currentPage: 0,
      pageSize: 1,
      totalItems: 0,
      preFetchDistance: 1,
      items: [],
      itemsByPage: HashMap(),
      status: PagingStatus.init,
      jumpToPos: null,
      jumpToAlignment: 0,
      visibleMinPos: 0,
      visibleMaxPos: 0,
      totalStaticPages: 0
    );
  }
}