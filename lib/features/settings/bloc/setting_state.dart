

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/entities/user_info_entity.dart';

class SettingState extends Equatable{

  final String?message;
  final SearchCriteriaEnum searchCriteria;
  final ArabicVerseUIEnum arabicVerseUI;
  final String fontText;
  final bool showSelectedListVerseIcons;
  final bool useArchiveAsSelectList;
  final UserInfoEntity? userInfoEntity;
  final String packageInfo;

  const SettingState({
    this.message,
    required this.searchCriteria,
    required this.arabicVerseUI,
    required this.fontText,
    required this.showSelectedListVerseIcons,
    required this.useArchiveAsSelectList,
    this.userInfoEntity,
    required this.packageInfo
  });

  SettingState copyWith({SearchCriteriaEnum? searchCriteria,ArabicVerseUIEnum? arabicVerseUI,
    String? fontText,bool? showSelectedListVerseIcons,bool? useArchiveAsSelectList,String?message,bool setMessage=false,
    UserInfoEntity? userInfoEntity,bool setUserInfo=false,String?packageInfo
  }){
    return SettingState(
        arabicVerseUI: arabicVerseUI??this.arabicVerseUI,
        searchCriteria: searchCriteria??this.searchCriteria,
        fontText: fontText??this.fontText,
        showSelectedListVerseIcons: showSelectedListVerseIcons??this.showSelectedListVerseIcons,
        useArchiveAsSelectList: useArchiveAsSelectList??this.useArchiveAsSelectList,
        message: setMessage?message:this.message,
        userInfoEntity: setUserInfo?userInfoEntity:this.userInfoEntity,
        packageInfo: packageInfo??this.packageInfo
    );
  }

  static SettingState init(){
    return SettingState(
      arabicVerseUI: ArabicVerseUIEnum.both,
      searchCriteria: SearchCriteriaEnum.multipleKeys,
      showSelectedListVerseIcons: false,
      useArchiveAsSelectList: false,
      fontText: FontSize.values[PrefConstants.fontSize.defaultValue].shortName,
        packageInfo: ""
    );
  }

  @override
  List<Object?> get props => [arabicVerseUI,searchCriteria,fontText,showSelectedListVerseIcons,useArchiveAsSelectList,
    message,userInfoEntity,packageInfo
  ];

}