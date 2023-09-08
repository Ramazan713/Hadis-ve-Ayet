

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_event.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_state.dart';

class SelectFontSizeBloc extends Bloc<ISelectFontSizeEvent, SelectFontSizeState>{

  late final AppPreferences _appPreferences;

  SelectFontSizeBloc({required AppPreferences appPreferences}): super(SelectFontSizeState.init()){

    _appPreferences = appPreferences;

    on<SelectFontSizeEventInit>(_onInit,transformer: restartable());
    on<SelectFontSizeEventSetContentSize>(_onSetContentSize,transformer: restartable());
    on<SelectFontSizeEventSetArabicSize>(_onSetArabicSize,transformer: restartable());
    on<SelectFontSizeEventSetArabicFamily>(_onSetArabicFamily,transformer: restartable());
    on<SelectFontSizeEventSave>(_onSave,transformer: restartable());
    on<SelectFontSizeEventReset>(_onReset,transformer: restartable());
    on<SelectFontSizeEventClearMessage>(_onClearMessage,transformer: restartable());
  }


  void _onInit(SelectFontSizeEventInit event,Emitter<SelectFontSizeState> emit){
    emit(_getFirstState(state: state));
  }

  void _onSetContentSize(SelectFontSizeEventSetContentSize event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(selectedContentFontSize: event.fontSize));
  }

  void _onSetArabicSize(SelectFontSizeEventSetArabicSize event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(selectedArabicFontSize: event.fontSize));
  }

  void _onSetArabicFamily(SelectFontSizeEventSetArabicFamily event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(selectedFontFamilyArabic: event.fontFamilyArabic));
  }

  void _onSave(SelectFontSizeEventSave event,Emitter<SelectFontSizeState> emit)async{

    final fontSizeArabic = state.selectedArabicFontSize;
    final fontSizeContent = state.selectedContentFontSize;
    final fontFamilyArabic = state.selectedFontFamilyArabic;

    await _appPreferences.setEnumItem(KPref.fontSizeArabic, fontSizeArabic);
    await _appPreferences.setEnumItem(KPref.fontSizeContent, fontSizeContent);
    await _appPreferences.setEnumItem(KPref.fontFamilyArabic, fontFamilyArabic);

    emit(state.copyWith(
      message: "Kaydedildi",
      lastSavedSelectedFontFamilyArabic: fontFamilyArabic,
      lastSavedContentFontSize: fontSizeContent,
      lastSavedArabicFontSize: fontSizeArabic
    ));
  }

  void _onReset(SelectFontSizeEventReset event,Emitter<SelectFontSizeState> emit){
    emit(_getFirstState(state: state));
  }

  void _onClearMessage(SelectFontSizeEventClearMessage event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(message: null));
  }


  SelectFontSizeState _getFirstState({required SelectFontSizeState state}){
    final contentFontSize = _appPreferences.getEnumItem(KPref.fontSizeContent);
    final arabicFontSize = _appPreferences.getEnumItem(KPref.fontSizeArabic);
    final arabicFontFamily = _appPreferences.getEnumItem(KPref.fontFamilyArabic);

    return state.copyWith(
      lastSavedSelectedFontFamilyArabic: arabicFontFamily,
      selectedFontFamilyArabic: arabicFontFamily,
      lastSavedArabicFontSize: arabicFontSize,
      selectedArabicFontSize: arabicFontSize,
      lastSavedContentFontSize: contentFontSize,
      selectedContentFontSize: contentFontSize,
    );
  }

}