
import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';

abstract class ISettingEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SettingEventInit extends ISettingEvent{}


class SettingEventResetSettings extends ISettingEvent{}


class SettingEventSetSearchCriteria extends ISettingEvent{
  final SearchCriteriaEnum searchCriteria;
  SettingEventSetSearchCriteria({required this.searchCriteria});
}


class SettingEventSetFontText extends ISettingEvent{
  final String fontText;
  SettingEventSetFontText({required this.fontText});
}

class SettingEventSetArabicUI extends ISettingEvent{
  final ArabicVerseUI2X arabicVerseUI;
  SettingEventSetArabicUI({required this.arabicVerseUI});
}

class SettingEventSetArchiveAsList extends ISettingEvent{
  final bool archiveAsList;
  SettingEventSetArchiveAsList({required this.archiveAsList});
}

class SettingEventSetShowListIcons extends ISettingEvent{
  final bool showListIcons;
  SettingEventSetShowListIcons({required this.showListIcons});
}

class SettingEventRequestUserInfo extends ISettingEvent{
  final String? userId;
  SettingEventRequestUserInfo({required this.userId});
  @override
  List<Object?> get props => [userId];
}


