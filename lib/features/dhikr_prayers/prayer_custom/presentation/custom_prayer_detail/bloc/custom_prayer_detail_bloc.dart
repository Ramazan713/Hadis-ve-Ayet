
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';

import 'custom_prayer_detail_event.dart';
import 'custom_prayer_detail_state.dart';

class CustomPrayerDetailBloc extends Bloc<ICustomPrayerDetailEvent,CustomPrayerDetailState>{

  late final PrayerCustomRepo _prayerRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  CustomPrayerDetailBloc({
    required PrayerCustomRepo prayerRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase
  }): super(CustomPrayerDetailState.init()){

    _prayerRepo = prayerRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    on<CustomPrayerDetailEventListenFontSize>(_onListenFontSize,transformer: restartable());
    on<CustomPrayerDetailLoadData>(_onLoadData,transformer: restartable());
    on<CustomPrayerDetailEventAddDhikr>(_onAddDhikr,transformer: restartable());
    on<CustomPrayerDetailEventClearMessage>(_onClearMessage,transformer: restartable());

    add(CustomPrayerDetailEventListenFontSize());
  }

  void _onAddDhikr(CustomPrayerDetailEventAddDhikr event,Emitter<CustomPrayerDetailState>emit)async{
    if(event.prayer.counterId != null) return;
    await _prayerRepo.addToCounter(event.prayer);
    emit(state.copyWith(
        message: "Başarıyla kaydedildi"
    ));
  }

  void _onLoadData(CustomPrayerDetailLoadData event,Emitter<CustomPrayerDetailState>emit)async{
    emit(CustomPrayerDetailState.init().copyWith(isLoading: true));
    final prayerStream = _prayerRepo.getStreamPrayerCustomUnitById(event.prayerId);

    await emit.forEach(prayerStream, onData: (data){
      return state.copyWith(prayerUnit: data,isLoading: false);
    });
  }

  void _onClearMessage(CustomPrayerDetailEventClearMessage event,Emitter<CustomPrayerDetailState>emit){
    emit(state.copyWith(message: null));
  }

  void _onListenFontSize(CustomPrayerDetailEventListenFontSize event,Emitter<CustomPrayerDetailState>emit)async{
    final streamData = _appPreferences.listenerFiltered(
        [KPref.fontSizeContent,KPref.fontFamilyArabic, KPref.fontSizeArabic],
        initValue: null);

    emit(state.copyWith(fontModel: _fontModelUseCase()));

    await emit.forEach(streamData, onData: (key){
      return state.copyWith(fontModel: _fontModelUseCase());
    });
  }

}