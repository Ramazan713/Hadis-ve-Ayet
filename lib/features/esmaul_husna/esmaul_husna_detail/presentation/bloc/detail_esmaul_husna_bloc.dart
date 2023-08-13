

import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    // required InsertCounterUseCase insertCounterUseCase
  }) :super(DetailEsmaulHusnaState.init()){

    _esmaulHusnaRepo = esmaulHusnaRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;
    // _insertCounterUseCase = insertCounterUseCase;

    on<DetailEsmaulHusnaEventListenInit>(_onListenInit);
    on<DetailEsmaulHusnaEventListenAppPref>(_onListenAppPref,transformer: restartable());

    on<DetailEsmaulHusnaEventLoadData>(_onLoadData,transformer: droppable());
    on<DetailEsmaulHusnaEventSaveAsDhikr>(_onSaveAsDhikr,transformer: droppable());
    on<DetailEsmaulHusnaEventGotoDhikr>(_onGotoDhikr,transformer: droppable());

    on<DetailEsmaulHusnaEventClearMessage>(_onClearMessage,transformer: restartable());

    add(DetailEsmaulHusnaEventListenInit());
    add(DetailEsmaulHusnaEventListenAppPref());
  }


  void _onListenInit(DetailEsmaulHusnaEventListenInit event,Emitter<DetailEsmaulHusnaState>emit)async{
    emit(state.copyWith(isLoading: true));
    final streamData = _esmaulHusnaRepo.getStreamEsmaulHusnas();
    await emit.forEach<List<EsmaulHusna>>(streamData, onData: (data){
      return state.copyWith(items: data, isLoading: false);
    });
  }

  void _onLoadData(DetailEsmaulHusnaEventLoadData event,Emitter<DetailEsmaulHusnaState>emit) async{

  }

  void _onSaveAsDhikr(DetailEsmaulHusnaEventSaveAsDhikr event,Emitter<DetailEsmaulHusnaState>emit)async{
    // final item = event.item;
    // final int? goal = _extractFirstNumberUseCase.operator(item.dhikr);
    //
    // await _insertCounterUseCase.operator(
    //     name: item.name,
    //     arabicContent: item.arabicName,
    //     content: item.name,
    //     meaning: item.meaning,
    //     counterType: CounterType.unlimited,
    //     goal: goal,
    //     lastCounter: 0
    // );
    // _addMessage("Başarıyla kaydedildi", emit);
  }

  void _onGotoDhikr(DetailEsmaulHusnaEventGotoDhikr event,Emitter<DetailEsmaulHusnaState>emit)async{
    // final item = event.item;
    // final int? goal = _extractFirstNumberUseCase.operator(item.dhikr);
    // final counter = Counter(
    //   name: item.name,
    //   content: item.name,
    //   arabicContent: item.arabicName,
    //   meaning: item.meaning,
    //   order: 0,
    //   goal: goal,
    //   counterType: CounterType.unlimited,
    //   lastCounter: 0
    // );
    //
    // emit(state.copyWith(
    //     navigationState: NavigationState(
    //       destination: CounterDetailPage.id,
    //       parameters: CounterDetailParam(type: CounterType.unlimited,counter: counter)
    //     ),
    //     setNavigationState: true)
    // );
    // emit(state.copyWith(setNavigationState: true));
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

}