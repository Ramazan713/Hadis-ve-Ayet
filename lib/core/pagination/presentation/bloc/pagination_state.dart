

import 'package:equatable/equatable.dart';
import 'package:hadith/core/pagination/domain/model/paging_data.dart';

class PaginationState extends Equatable{

  final PagingData pagingData;

  const PaginationState({required this.pagingData});

  PaginationState copyWith({PagingData? pagingData}){
    return PaginationState(
      pagingData: pagingData??this.pagingData
    );
  }

  static PaginationState init(){
    return PaginationState(
      pagingData: PagingData.init()
    );
  }

  @override
  List<Object?> get props => [pagingData];
}