

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/features/extra_features/quran_prayer/domain/model/quran_prayer.dart';

class ShowQuranPrayerState extends Equatable{
  final List<QuranPrayer> items;
  final bool isLoading;
  final ArabicVerseUI2X verseUi;
  final FontSize fontSize;

  const ShowQuranPrayerState({required this.items,required this.isLoading,
    required this.verseUi,required this.fontSize
  });

  ShowQuranPrayerState copyWith({List<QuranPrayer>?items,bool?isLoading,
    ArabicVerseUI2X? verseUi, FontSize? fontSize
  }){
    return ShowQuranPrayerState(
        items: items??this.items,
        isLoading: isLoading??this.isLoading,
        verseUi: verseUi??this.verseUi,
        fontSize: fontSize??this.fontSize
    );
  }

  static ShowQuranPrayerState init(){
    return const ShowQuranPrayerState(
        isLoading: false,
        items: [],
        verseUi: ArabicVerseUI2X.both,
        fontSize: FontSize.medium
    );
  }

  @override
  List<Object?> get props => [items,isLoading,verseUi,fontSize];

}