

import 'package:equatable/equatable.dart';

import '../enums/paging_status.dart';
import 'i_paging_item.dart';

class PagingData<T extends IPagingItem> extends Equatable{

  final int currentPage;
  final int prevPage;
  final int pageSize;
  final int totalItems;
  final List<T> items;
  final PagingStatus status;
  final int preFetchDistance;
  final int? jumpToPos;
  final double jumpToAlignment;


  const PagingData({
    required this.currentPage,
    required this.prevPage,
    required this.pageSize,
    required this.totalItems,
    required this.items,
    required this.status,
    required this.preFetchDistance,
    this.jumpToPos,
    required this.jumpToAlignment
  });

  PagingData copyWith({
    int? currentPage,
    int? prevPage,
    int? pageSize,
    int? preFetchDistance,
    int? jumpToPos,
    bool setJumpToPos=false,
    double? jumpToAlignment,
    int? totalItems,
    List<T>? items,
    PagingStatus? status
  }){
    return PagingData(
        currentPage: currentPage??this.currentPage,
        prevPage: prevPage??this.prevPage,
        jumpToPos: setJumpToPos?jumpToPos:this.jumpToPos,
        jumpToAlignment: jumpToAlignment??this.jumpToAlignment,
        status: status??this.status,
        preFetchDistance: preFetchDistance??this.preFetchDistance,
        pageSize: pageSize??this.pageSize,
        totalItems: totalItems??this.totalItems,
        items: items??this.items
    );
  }

  static PagingData init(){
    return const PagingData(currentPage: 0, pageSize: 1, totalItems: 0,preFetchDistance: 1,
        items: [],status: PagingStatus.init,jumpToPos: null,prevPage: 0,
        jumpToAlignment: 0
    );
  }

  @override
  List<Object?> get props => [currentPage,pageSize,totalItems,prevPage,
    jumpToPos,items,status, preFetchDistance, jumpToAlignment];

}