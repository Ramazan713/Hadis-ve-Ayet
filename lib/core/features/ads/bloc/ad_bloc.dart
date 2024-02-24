
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/ads/bloc/ad_event.dart';
import 'package:hadith/core/features/ads/bloc/ad_state.dart';

class AdBloc extends Bloc<IAdEvent,AdState>{

  AdBloc(): super(AdState.init()){
    on<AdEventStartClock>(_onStartClock,transformer: restartable());
    on<AdEventStopClock>(_onStopClock,transformer: restartable());
    on<AdEventIncreaseCounter>(_onIncreaseCounter, transformer: restartable());
    on<AdEventIncreaseConsumeSeconds>(_onIncreaseConsumeSeconds, transformer: restartable());
    on<AdEventResetValues>(_onResetValues,transformer: restartable());
    on<AdEventClearLoadAd>(_onClearLoadAd,transformer: restartable());
    on<AdEventSetAdd>(_onSetAdd,transformer: restartable());
    on<AdEventClearShowAd>(_onClearShowAd,transformer: restartable());
    on<AdEventCheckShowStatus>(_onCheckShowStatus,transformer: restartable());
    on<AdEventLoadAdFailure>(_onLoadAdFailure,transformer: restartable());
  }

  Timer? _adTimer;
  int retry = 0;

  void _onLoadAdFailure(AdEventLoadAdFailure event, Emitter<AdState> emit)async{
    if(retry >= 3){
      emit(state.copyWith(
        loadAd: false, ad: null, showAd: false,
      ));
    }
    emit(state.copyWith(
      loadAd: true,
      ad: null,
      showAd: false,
    ));
    retry += 1;
  }

  void _onSetAdd(AdEventSetAdd event, Emitter<AdState> emit)async{
    emit(state.copyWith(ad: event.ad));
    _stopClock();
  }

  void _onStartClock(AdEventStartClock event, Emitter<AdState> emit)async{
    _startClock();
  }

  void _onStopClock(AdEventStopClock event, Emitter<AdState> emit)async{
    _stopClock();
  }

  void _onIncreaseCounter(AdEventIncreaseCounter event, Emitter<AdState> emit)async{
    if(!canUpdateState()) return;
    emit(state.copyWith(counterOpening: state.counterOpening + 1));

    if(_checkLoadAdStatus()){
      emit(state.copyWith(loadAd: true));
    }
  }

  void _onIncreaseConsumeSeconds(AdEventIncreaseConsumeSeconds event, Emitter<AdState> emit)async{
    if(!canUpdateState()) return;
    emit(state.copyWith(totalConsumeSeconds: state.totalConsumeSeconds + K.ad.tickIntervalSeconds));

    if(_checkLoadAdStatus()){
      emit(state.copyWith(loadAd: true));
    }
  }

  void _onResetValues(AdEventResetValues event, Emitter<AdState> emit)async{
    emit(AdState.init());
    retry = 0;
  }

  void _onClearLoadAd(AdEventClearLoadAd event, Emitter<AdState> emit)async{
    emit(state.copyWith(loadAd: false));
  }

  void _onClearShowAd(AdEventClearShowAd event, Emitter<AdState> emit)async{
    emit(state.copyWith(showAd: false));
  }

  void _onCheckShowStatus(AdEventCheckShowStatus event, Emitter<AdState> emit)async{
    EasyThrottle.throttle("_onCheckShowStatus", const Duration(milliseconds: 100), () {
      if(state.ad != null){
        emit(state.copyWith(showAd: true));
      }
    });
  }

  void _stopClock(){
    _adTimer?.cancel();
    _adTimer = null;
  }
  
  void _startClock(){
    if(_adTimer != null) return;
    _adTimer = Timer.periodic(Duration(seconds: K.ad.tickIntervalSeconds), (timer) {
      add(AdEventIncreaseConsumeSeconds());
    });
  }


  bool canUpdateState(){
    if(state.loadAd || state.ad != null || state.showAd) return false;
    return true;
  }

  bool _checkLoadAdStatus(){
    if(!canUpdateState()) return false;

    return state.counterOpening >= K.ad.thresholdOpeningCounter
        || state.totalConsumeSeconds >= K.ad.thresholdConsumeSeconds;
  }

  @override
  Future<void> close() {
    _stopClock();
    return super.close();
  }

}