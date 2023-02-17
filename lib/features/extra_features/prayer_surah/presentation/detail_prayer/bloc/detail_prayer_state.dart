

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';

class DetailPrayerState extends Equatable{
  final bool isExpandedArabic;
  final bool isExpandedPronunciation;
  final bool isExpandedMeaning;
  final double fontSize;
  final String?message;

  const DetailPrayerState({required this.isExpandedArabic,required this.isExpandedMeaning,
    required this.isExpandedPronunciation,required this.fontSize,this.message
  });

  DetailPrayerState copyWith({bool?isExpandedArabic,bool?isExpandedPronunciation,
    bool?isExpandedMeaning,double? fontSize,String?message,bool setMessage=false
  }){
    return DetailPrayerState(
        isExpandedArabic: isExpandedArabic??this.isExpandedArabic,
        isExpandedPronunciation: isExpandedPronunciation??this.isExpandedPronunciation,
        isExpandedMeaning: isExpandedMeaning??this.isExpandedMeaning,
        fontSize: fontSize??this.fontSize,
        message: setMessage?message:this.message
    );
  }

  static DetailPrayerState init(){
    return DetailPrayerState(
        isExpandedArabic: true,
        isExpandedPronunciation: true,
        isExpandedMeaning: true,
        fontSize: FontSize.medium.size
    );
  }

  @override
  List<Object?> get props => [isExpandedArabic,isExpandedPronunciation,isExpandedMeaning,
    fontSize,message
  ];
}