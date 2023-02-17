
import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

class CounterDetailState extends Equatable{
  final int counterClassic;
  final int counterSubClassic;
  final int counterUnLimited;
  final Counter? counter;
  final bool hasCompletedGoal;
  final double fontSize;
  final bool hasVibrator;
  final String?message;
  final CounterType counterType;
  final ArabicVerseUI3X verseUi3X;

  const CounterDetailState({required this.counterClassic,required this.counterSubClassic,
    required this.counterUnLimited,this.counter,required this.hasCompletedGoal,
    required this.fontSize,required this.hasVibrator,this.message,
    required this.counterType,required this.verseUi3X,
  });

  CounterDetailState copyWith ({int? counterClassic,int? counterSubClassic,
    int? counterUnLimited,bool? hasCompletedGoal,Counter? counter,bool setCounter=false,
    double?fontSize,bool?hasVibrator,String?message,bool setMessage=false,
    CounterType? counterType,ArabicVerseUI3X? verseUi3X
  }){
    return CounterDetailState(
        counterClassic: counterClassic??this.counterClassic,
        counterSubClassic: counterSubClassic??this.counterSubClassic,
        counterUnLimited: counterUnLimited??this.counterUnLimited,
        hasCompletedGoal: hasCompletedGoal??this.hasCompletedGoal,
        counter: setCounter?counter:this.counter,
        fontSize: fontSize??this.fontSize,
        hasVibrator: hasVibrator??this.hasVibrator,
        message: setMessage?message:this.message,
        counterType: counterType??this.counterType,
        verseUi3X: verseUi3X??this.verseUi3X,

    );
  }

  static CounterDetailState init(){
    return CounterDetailState(
        counterClassic: 0,
        counterSubClassic: 0,
        counterUnLimited: 0,
        hasCompletedGoal: false,
        fontSize: FontSize.values[PrefConstants.fontSize.defaultValue].size,
        hasVibrator: false,
        counterType: CounterType.classic,
        verseUi3X: ArabicVerseUI3X.arabicPronunciation,
    );
  }

  int? getGoal() => counter?.goal;

  bool hasNotSavedCounter() => counter!=null && counter?.id == null;
  bool hasSavedCounter() => counter!=null && counter?.id != null;
  bool hasAnyContent() => (counter?.arabicContent?.isNotEmpty??false) ||
      (counter?.content?.isNotEmpty??false) || (counter?.meaning?.isNotEmpty??false);

  @override
  List<Object?> get props => [counterClassic,counterSubClassic,hasVibrator,verseUi3X,
    counterUnLimited,counter,hasCompletedGoal,fontSize,message,counterType,
  ];
}