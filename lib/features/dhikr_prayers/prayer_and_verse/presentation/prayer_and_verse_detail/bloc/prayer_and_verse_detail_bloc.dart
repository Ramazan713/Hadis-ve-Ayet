
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_entity_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';
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

    on<PrayerAndVerseDetailEventListenFontSize>(_onListenFontSize,transformer: restartable());
    on<PrayerAndVerseDetailEventLoadData>(_onLoadData,transformer: restartable());
    on<PrayerAndVerseDetailEventClearMessage>(_onClearMessage,transformer: restartable());
    on<PrayerAndVerseDetailEventAddToCustomPrayer>(_onAddToCustomPrayer,transformer: restartable());

    add(PrayerAndVerseDetailEventListenFontSize());
  }

  void _onLoadData(PrayerAndVerseDetailEventLoadData event,Emitter<PrayerAndVerseDetailState>emit)async{
    emit(PrayerAndVerseDetailState.init().copyWith(
      isLoading: true,
      fontModel: _fontModelUseCase.call()
    ));

    final prayerStream = _prayerRepo.getStreamPrayerAndVerseUnitById(event.prayerId);
    await emit.forEach(prayerStream, onData: (data){
      return state.copyWith(prayerUnit: data,isLoading: false);
    });
  }

  void _onAddToCustomPrayer(PrayerAndVerseDetailEventAddToCustomPrayer event,Emitter<PrayerAndVerseDetailState>emit)async{
    final prayerUnit = state.prayerUnit;
    if(prayerUnit == null) return;
    _prayerRepo.insertCustomPrayerWithRelationForPrayerVerse(prayerUnit);
    emit(state.copyWith(message: "Başarıyla Eklendi"));
  }


  void _onClearMessage(PrayerAndVerseDetailEventClearMessage event,Emitter<PrayerAndVerseDetailState>emit){
    emit(state.copyWith(message: null));
  }

  void _onListenFontSize(PrayerAndVerseDetailEventListenFontSize event,Emitter<PrayerAndVerseDetailState>emit)async{
    final streamData = _appPreferences.listenerFiltered(
        [KPref.fontSizeContent,KPref.fontFamilyArabic, KPref.fontSizeArabic],
        initValue: null);

    emit(state.copyWith(fontModel: _fontModelUseCase()));

    await emit.forEach(streamData, onData: (key){
      return state.copyWith(fontModel: _fontModelUseCase());
    });
  }

}