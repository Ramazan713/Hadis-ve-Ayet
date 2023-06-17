

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
    final contentFontSize = _appPreferences.getItem(KPref.fontSizeContent);
    final arabicFontSize = _appPreferences.getItem(KPref.fontSizeArabic);
    final arabicFontFamily = _appPreferences.getEnumItem(KPref.fontFamilyArabic);

    emit(state.copyWith(
      fontFamilyArabic: arabicFontFamily,
      arabicFontSize: arabicFontSize,
      contentFontSize: contentFontSize
    ));

  }
  void _onSetContentSize(SelectFontSizeEventSetContentSize event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(contentFontSize: event.size));
  }

  void _onSetArabicSize(SelectFontSizeEventSetArabicSize event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(arabicFontSize: event.size));
  }

  void _onSetArabicFamily(SelectFontSizeEventSetArabicFamily event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(fontFamilyArabic: event.fontFamilyArabic));
  }

  void _onSave(SelectFontSizeEventSave event,Emitter<SelectFontSizeState> emit)async{
    await _appPreferences.setItem(KPref.fontSizeArabic, state.arabicFontSize);
    await _appPreferences.setItem(KPref.fontSizeContent, state.contentFontSize);
    await _appPreferences.setEnumItem(KPref.fontFamilyArabic, state.fontFamilyArabic);

    emit(state.copyWith(
      setMessage: true,
      message: "Kaydedildi"
    ));
  }

  void _onReset(SelectFontSizeEventReset event,Emitter<SelectFontSizeState> emit){
    final contentFontSize = KPref.fontSizeContent.defaultValue;
    final arabicFontSize = KPref.fontSizeArabic.defaultValue;
    final arabicFontFamily = KPref.fontFamilyArabic.defaultPrefEnum;

    emit(state.copyWith(
        fontFamilyArabic: arabicFontFamily,
        arabicFontSize: arabicFontSize,
        contentFontSize: contentFontSize
    ));
  }

  void _onClearMessage(SelectFontSizeEventClearMessage event,Emitter<SelectFontSizeState> emit){
    emit(state.copyWith(setMessage: true));
  }
}