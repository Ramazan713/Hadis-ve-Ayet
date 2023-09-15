

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/repo/esmaul_husna_repo.dart';

import 'detail_esmaul_husna_event.dart';
import 'detail_esmaul_husna_state.dart';

class DetailEsmaulHusnaBloc extends Bloc<IDetailEsmaulHusnaEvent,DetailEsmaulHusnaState>{

  late final EsmaulHusnaRepo _esmaulHusnaRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  DetailEsmaulHusnaBloc({
    required EsmaulHusnaRepo esmaulHusnaRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase
  }) :super(DetailEsmaulHusnaState.init()){

    _esmaulHusnaRepo = esmaulHusnaRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    on<DetailEsmaulHusnaEventListenInit>(_onListenInit);
    on<DetailEsmaulHusnaEventListenAppPref>(_onListenAppPref,transformer: restartable());

    on<DetailEsmaulHusnaEventLoadData>(_onLoadData,transformer: droppable());
    on<DetailEsmaulHusnaEventSaveAsDhikr>(_onSaveAsDhikr,transformer: droppable());
    on<DetailEsmaulHusnaEventSetCurrentItem>(_onSetCurrentItem,transformer: droppable());

    on<DetailEsmaulHusnaEventClearMessage>(_onClearMessage,transformer: restartable());

    add(DetailEsmaulHusnaEventListenInit());
    add(DetailEsmaulHusnaEventListenAppPref());
  }

  void _onSetCurrentItem(DetailEsmaulHusnaEventSetCurrentItem event,Emitter<DetailEsmaulHusnaState>emit){
    emit(state.copyWith(
      currentItem: _getCurrentItem(state.items, event.page)
    ));
  }

  void _onListenInit(DetailEsmaulHusnaEventListenInit event,Emitter<DetailEsmaulHusnaState>emit)async{
    emit(state.copyWith(isLoading: true));
    final streamData = _esmaulHusnaRepo.getStreamEsmaulHusnas();
    await emit.forEach<List<EsmaulHusna>>(streamData, onData: (data){
      return state.copyWith(items: data, isLoading: false);
    });
  }

  void _onLoadData(DetailEsmaulHusnaEventLoadData event,Emitter<DetailEsmaulHusnaState>emit) async{
    emit(state.copyWith(isLoading: true));
    final items = await _esmaulHusnaRepo.getEsmaulHusnas();
    emit(state.copyWith(
      items: items,
      isLoading: false,
      currentItem: _getCurrentItem(items, event.initPos)
    ));
  }

  void _onSaveAsDhikr(DetailEsmaulHusnaEventSaveAsDhikr event,Emitter<DetailEsmaulHusnaState>emit)async{
    await _esmaulHusnaRepo.addCounterFromEsmaulHusna(event.item);
    emit(state.copyWith(message: "Başarıyla kaydedildi"));
  }

  void _onListenAppPref(DetailEsmaulHusnaEventListenAppPref event,Emitter<DetailEsmaulHusnaState>emit)async{
    final streamData = _appPreferences.listenerFiltered([
      KPref.fontSizeContent,
      KPref.fontFamilyArabic,
      KPref.fontSizeArabic,
      KPref.esmaulHusnaSearchCriteria,
    ], initValue: null);

    emit(state.copyWith(
      fontModel: _fontModelUseCase(),
    ));

    await emit.forEach(streamData, onData: (key){
      return state.copyWith(
        fontModel: _fontModelUseCase(),
      );
    });
  }

  void _onClearMessage(DetailEsmaulHusnaEventClearMessage event,Emitter<DetailEsmaulHusnaState>emit)async{
    emit(state.copyWith(message: null));
  }

  EsmaulHusna? _getCurrentItem(List<EsmaulHusna> items, int index){
    if(items.length > index){
      final item = items[index];
      return item;
    }
    return null;
  }

}