import 'package:equatable/equatable.dart';

import '../../../domain/enums/paging/paging_status.dart';
import '../../../domain/models/paging/i_paging_item.dart';

class PaginationState<T extends IPagingItem> extends Equatable{

  final int currentPage;
  final int prevPage;
  final int pageSize;
  final int totalItems;
  final List<T> items;
  final PagingStatus status;
  final int preFetchDistance;
  final int? jumpToPos;
  final double jumpToAlignment;

  final int visibleMinPos;
  final int visibleMaxPos;

  int get totalPages => totalItems ~/ pageSize;
  int get visibleMiddlePos => (visibleMaxPos + visibleMinPos) ~/ 2;
  T? get visibleMiddleItem => items.elementAtOrNull(visibleMiddlePos);


  const PaginationState({
    required this.currentPage,
    required this.prevPage,
    required this.pageSize,
    required this.totalItems,
    required this.items,
    required this.status,
    required this.preFetchDistance,
    this.jumpToPos,
    required this.jumpToAlignment,
    required this.visibleMinPos,
    required this.visibleMaxPos
  });

  PaginationState copyWith({
    int? currentPage,
    int? prevPage,
    int? pageSize,
    int? preFetchDistance,
    int? jumpToPos,
    bool setJumpToPos=false,
    double? jumpToAlignment,
    int? totalItems,
    List<T>? items,
    PagingStatus? status,
    int? visibleMinPos,
    int? visibleMaxPos
  }){
    return PaginationState(
        currentPage: currentPage??this.currentPage,
        prevPage: prevPage??this.prevPage,
        jumpToPos: setJumpToPos?jumpToPos:this.jumpToPos,
        jumpToAlignment: jumpToAlignment??this.jumpToAlignment,
        status: status??this.status,
        preFetchDistance: preFetchDistance??this.preFetchDistance,
        pageSize: pageSize??this.pageSize,
        totalItems: totalItems??this.totalItems,
        items: items??this.items,
        visibleMaxPos: visibleMaxPos??this.visibleMaxPos,
        visibleMinPos: visibleMinPos??this.visibleMinPos
    );
  }

  static PaginationState init(){
    return const PaginationState(
        prevPage: 0,
        currentPage: 0,
        pageSize: 1,
        totalItems: 0,
        preFetchDistance: 1,
        items: [],
        status: PagingStatus.init,
        jumpToPos: null,
        jumpToAlignment: 0,
        visibleMinPos: 0,
        visibleMaxPos: 0
    );
  }

  @override
  List<Object?> get props => [currentPage,pageSize,totalItems,prevPage,visibleMinPos, visibleMaxPos,
    jumpToPos,items,status, preFetchDistance, jumpToAlignment];

}