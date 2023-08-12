
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

import 'prayer_and_verse_detail_event.dart';
import 'prayer_and_verse_detail_state.dart';

class PrayerAndVerseDetailBloc extends Bloc<IPrayerDetailEvent,PrayerAndVerseDetailState>{

  late final PrayerRepo _prayerRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  PrayerAndVerseDetailBloc({
    required PrayerRepo prayerRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase
  }): super(PrayerAndVerseDetailState.init()){

    _prayerRepo = prayerRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    on<PrayerDetailEventListenFontSize>(_onListenFontSize,transformer: restartable());
    on<PrayerDetailEventLoadData>(_onLoadData,transformer: restartable());
    on<PrayerDetailEventSetVisibilityArabic>(_onSetVisibilityArabic,transformer: restartable());
    on<PrayerDetailEventSetVisibilityMeaning>(_onSetVisibilityMeaning,transformer: restartable());
    on<PrayerDetailEventSetVisibilityPronunciation>(_onSetVisibilityPronunciation,transformer: restartable());
    on<PrayerDetailEventClearMessage>(_onClearMessage,transformer: restartable());

    add(PrayerDetailEventListenFontSize());
  }


  void _onLoadData(PrayerDetailEventLoadData event,Emitter<PrayerAndVerseDetailState>emit)async{
    final prayer = await _prayerRepo.getPrayerAndVerseById(event.prayerId);
    emit(PrayerAndVerseDetailState.init().copyWith(prayer: prayer));
  }

  void _onSetVisibilityArabic(PrayerDetailEventSetVisibilityArabic event,Emitter<PrayerAndVerseDetailState>emit){
    emit(state.copyWith(isExpandedArabic: event.isVisible));
  }

  void _onSetVisibilityMeaning(PrayerDetailEventSetVisibilityMeaning event,Emitter<PrayerAndVerseDetailState>emit){
    emit(state.copyWith(isExpandedMeaning: event.isVisible));
  }

  void _onSetVisibilityPronunciation(PrayerDetailEventSetVisibilityPronunciation event,Emitter<PrayerAndVerseDetailState>emit){
    emit(state.copyWith(isExpandedPronunciation: event.isVisible));

  }

  void _onClearMessage(PrayerDetailEventClearMessage event,Emitter<PrayerAndVerseDetailState>emit){
    emit(state.copyWith(message: null));
  }

  void _onListenFontSize(PrayerDetailEventListenFontSize event,Emitter<PrayerAndVerseDetailState>emit)async{
    final streamData = _appPreferences.listenerFiltered(
        [KPref.fontSizeContent,KPref.fontFamilyArabic, KPref.fontSizeArabic],
        initValue: null);

    emit(state.copyWith(fontModel: _fontModelUseCase()));

    await emit.forEach(streamData, onData: (key){
      return state.copyWith(fontModel: _fontModelUseCase());
    });
  }

}