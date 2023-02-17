

import 'package:equatable/equatable.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info.dart';

class DetailIslamicInfoState extends Equatable{
  final List<IslamicInfo> items;
  final IslamicInfoType infoType;
  final bool isLoading;

  const DetailIslamicInfoState({required this.items,required this.isLoading,
    required this.infoType
  });

  DetailIslamicInfoState copyWith({List<IslamicInfo>? items,bool?isLoading,
    IslamicInfoType? infoType
  }){
    return DetailIslamicInfoState(
        isLoading: isLoading??this.isLoading,
        items: items??this.items,
        infoType: infoType??this.infoType
    );
  }

  static DetailIslamicInfoState init(){
    return const DetailIslamicInfoState(
        isLoading: false,
        items: [],
        infoType: IslamicInfoType.none
    );
  }

  @override
  List<Object?> get props => [items,isLoading,infoType];

}