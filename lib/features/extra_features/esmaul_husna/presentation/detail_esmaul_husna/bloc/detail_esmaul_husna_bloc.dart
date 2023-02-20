

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/insert_counter_use_case.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/counter_detail_page.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/model/counter_detail_param.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/use_case/extract_first_number_use_case.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/bloc/detail_esmaul_husna_event.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/bloc/detail_esmaul_husna_state.dart';
import 'package:hadith/models/navigation_state.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailEsmaulHusnaBloc extends Bloc<IDetailEsmaulHusnaEvent,DetailEsmaulHusnaState>{

  late final InsertCounterUseCase _insertCounterUseCase;
  late final EsmaulHusnaRepo _esmaulHusnaRepo;
  final ExtractFirstNumberUseCase _extractFirstNumberUseCase = ExtractFirstNumberUseCase();

  DetailEsmaulHusnaBloc({required EsmaulHusnaRepo esmaulHusnaRepo,required InsertCounterUseCase insertCounterUseCase}) :
        super(DetailEsmaulHusnaState.init()){
    _esmaulHusnaRepo = esmaulHusnaRepo;
    _insertCounterUseCase = insertCounterUseCase;

    on<DetailEsmaulHusnaEventInit>(_onInit);
    on<DetailEsmaulHusnaEventSetInit>(_onSetInit,transformer: droppable());
    on<DetailEsmaulHusnaEventSaveAsDhikr>(_onSaveAsDhikr,transformer: droppable());
    on<DetailEsmaulHusnaEventGotoDhikr>(_onGotoDhikr,transformer: droppable());

    add(DetailEsmaulHusnaEventInit());
  }



  void _onInit(DetailEsmaulHusnaEventInit event,Emitter<DetailEsmaulHusnaState>emit)async{
    emit(state.copyWith(isLoading: true));
    final items = await _esmaulHusnaRepo.getAllEsmaulHusna();
    emit(state.copyWith(items: items,isLoading: false));

    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize, onData: (data)=>
      state.copyWith(fontSize: data)
    );
  }

  void _onSetInit(DetailEsmaulHusnaEventSetInit event,Emitter<DetailEsmaulHusnaState>emit)async{
    emit(state.copyWith(currentItem: event.item,setCurrentItem: true,jumpToPage: event.jumpToPage));
    emit(state.copyWith(jumpToPage: false));
    if(state.isLoading){
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(jumpToPage: true));
      emit(state.copyWith(jumpToPage: false));
    }
  }

  void _onSaveAsDhikr(DetailEsmaulHusnaEventSaveAsDhikr event,Emitter<DetailEsmaulHusnaState>emit)async{
    final item = event.item;
    final int? goal = _extractFirstNumberUseCase.operator(item.dhikr);
    
    await _insertCounterUseCase.operator(
        name: item.name,
        arabicContent: item.arabicName,
        content: item.name,
        meaning: item.meaning,
        counterType: CounterType.unlimited,
        goal: goal,
        lastCounter: 0
    );
    _addMessage("Başarıyla kaydedildi", emit);
  }

  void _onGotoDhikr(DetailEsmaulHusnaEventGotoDhikr event,Emitter<DetailEsmaulHusnaState>emit)async{
    final item = event.item;
    final int? goal = _extractFirstNumberUseCase.operator(item.dhikr);
    final counter = Counter(
      name: item.name,
      content: item.name,
      arabicContent: item.arabicName,
      meaning: item.meaning,
      order: 0,
      goal: goal,
      counterType: CounterType.unlimited,
      lastCounter: 0
    );

    emit(state.copyWith(
        navigationState: NavigationState(
          destination: CounterDetailPage.id,
          parameters: CounterDetailParam(type: CounterType.unlimited,counter: counter)
        ),
        setNavigationState: true)
    );
    emit(state.copyWith(setNavigationState: true));
  }


  void _addMessage(String message,Emitter<DetailEsmaulHusnaState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true));
  }
}