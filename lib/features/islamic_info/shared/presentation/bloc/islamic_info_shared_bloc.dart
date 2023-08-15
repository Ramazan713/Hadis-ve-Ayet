


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/features/islamic_info/shared/domain/repo/islamic_info_repo.dart';

import 'islamic_info_shared_event.dart';
import 'islamic_info_shared_state.dart';

class IslamicInfoSharedBloc extends Bloc<IIslamicInfoSharedEvent,IslamicInfoSharedState>{

  late final IslamicInfoRepo _infoRepo;
  late final AppPreferences _appPreferences;
  late final FontModelUseCase _fontModelUseCase;

  IslamicInfoSharedBloc({
    required IslamicInfoRepo islamicInfoRepo,
    required AppPreferences appPreferences,
    required FontModelUseCase fontModelUseCase
  }): super(IslamicInfoSharedState.init()){

    _infoRepo = islamicInfoRepo;
    _appPreferences = appPreferences;
    _fontModelUseCase = fontModelUseCase;

    on<IslamicInfoSharedEventLoadData>(_onLoadData,transformer: restartable());
    on<IslamicInfoSharedEventListenAppPref>(_onListenAppPref,transformer: restartable());

    add(IslamicInfoSharedEventListenAppPref());
  }

  void _onLoadData(IslamicInfoSharedEventLoadData event,Emitter<IslamicInfoSharedState>emit)async{
    emit(IslamicInfoSharedState.init().copyWith(
        isLoading: true,
        fontModel: _fontModelUseCase(),
    ));

    final items = await _infoRepo.getIslamicInfoCollectionByType(event.infoType);

    emit(state.copyWith(
      isLoading: false,
      infoType: event.infoType,
      items: items
    ));
  }

  void _onListenAppPref(IslamicInfoSharedEventListenAppPref event,Emitter<IslamicInfoSharedState>emit)async{
    final streamData = _appPreferences.listenerFiltered([
      KPref.fontSizeContent,
      KPref.fontFamilyArabic,
      KPref.fontSizeArabic,
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

}