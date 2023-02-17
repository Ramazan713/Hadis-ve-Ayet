

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/insert_counter_use_case.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/bloc/detail_prayer_event.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/bloc/detail_prayer_state.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPrayerBloc extends Bloc<IDetailPrayerEvent,DetailPrayerState>{

  late final InsertCounterUseCase _insertCounterUseCase;

  DetailPrayerBloc({required InsertCounterUseCase insertCounterUseCase}) :
        super(DetailPrayerState.init()){

    _insertCounterUseCase = insertCounterUseCase;

    on<DetailPrayerEventVisibilityArabic>(_onSetVisibilityArabic,transformer: restartable());
    on<DetailPrayerEventVisibilityPronunciation>(_onSetVisibilityPronunciation,transformer: restartable());
    on<DetailPrayerEventVisibilityMeaning>(_onSetVisibilityMeaning,transformer: restartable());
    on<DetailPrayerEventInit>(_onInit,transformer: restartable());
    on<DetailPrayerEventInitExpanding>(_onInitExpanding,transformer: restartable());
    on<DetailPrayerEventAddCounter>(_onAddCounter,transformer: restartable());

    add(DetailPrayerEventInit());
  }

  void _onInit(DetailPrayerEventInit event,Emitter<DetailPrayerState>emit)async{
    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize,
        onData: (data)=>state.copyWith(fontSize: data.size));
  }

  void _onInitExpanding(DetailPrayerEventInitExpanding event,Emitter<DetailPrayerState>emit)async {
    emit(state.copyWith(
      isExpandedArabic: true,
      isExpandedMeaning: true,
      isExpandedPronunciation: true
    ));
  }

  void _onAddCounter(DetailPrayerEventAddCounter event,Emitter<DetailPrayerState>emit)async{
    final prayer = event.prayer;
    await _insertCounterUseCase.operator(
        name: prayer.name,
        counterType: CounterType.classic,
        lastCounter: 0,
        meaning: prayer.meaningContent,
        content: prayer.pronunciationContent,
        arabicContent: prayer.arabicContent
    );
    _addMessage("Zikr olarak kaydedildi", emit);
  }

  void _onSetVisibilityArabic(DetailPrayerEventVisibilityArabic event,Emitter<DetailPrayerState>emit)async{
    emit(state.copyWith(isExpandedArabic: event.isVisible));
  }

  void _onSetVisibilityPronunciation(DetailPrayerEventVisibilityPronunciation event,Emitter<DetailPrayerState>emit)async{
    emit(state.copyWith(isExpandedPronunciation: event.isVisible));
  }

  void _onSetVisibilityMeaning(DetailPrayerEventVisibilityMeaning event,Emitter<DetailPrayerState>emit)async{
    emit(state.copyWith(isExpandedMeaning: event.isVisible));
  }

  void _addMessage(String message,Emitter<DetailPrayerState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }

}