

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/features/verses/domain/manager/select_verse_manager.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_by_quran_repo.dart';

import 'create_quran_prayer_event.dart';
import 'create_quran_prayer_state.dart';

class CreateQuranPrayerBloc extends Bloc<ICreateQuranPrayerEvent,CreateQuranPrayerState>{
  late final SelectVerseManager _selectVerseManager;
  late final PrayerCustomByQuranRepo _prayerCustomByQuranRepo;

  CreateQuranPrayerBloc({
    required SelectVerseManager selectVerseManager,
    required PrayerCustomByQuranRepo prayerCustomByQuranRepo
  }) : super(CreateQuranPrayerState.init()){

    _selectVerseManager = selectVerseManager;
    _prayerCustomByQuranRepo = prayerCustomByQuranRepo;

    on<CreateQuranPrayerEventClearMessage>(_onClearMessage,transformer: restartable());
    on<CreateQuranPrayerEventInit>(_onInit);
    on<CreateQuranPrayerEventSelectCuz>(_onSelectCuz,transformer: restartable());
    on<CreateQuranPrayerEventSelectSurah>(_onSelectSurah,transformer: restartable());
    on<CreateQuranPrayerEventInsert>(_onInsert,transformer: restartable());
    on<CreateQuranPrayerEventSelectVerse>(_onSelectVerse,transformer: restartable());
    on<CreateQuranPrayerEventClearNavigateBack>(_onClearNavigateBack,transformer: restartable());
    on<CreateQuranPrayerEventCheckAutoGenerateName>(_onCheckAutoGenerateName,transformer: restartable());
    on<CreateQuranPrayerEventCheckAutoGenerateNameImmediately>(_onCheckAutoGenerateNameImmediately,transformer: restartable());
    on<CreateQuranPrayerEventAutoGenerateName>(_onAutoGenerateName,transformer: restartable());
    on<CreateQuranPrayerEventClearSetName>(_onClearSetName,transformer: restartable());

    add(CreateQuranPrayerEventInit());
  }

  void _onClearMessage(CreateQuranPrayerEventClearMessage event, Emitter<CreateQuranPrayerState> emit){
    emit(state.copyWith(message: null));
  }

  void _onClearSetName(CreateQuranPrayerEventClearSetName event, Emitter<CreateQuranPrayerState> emit){
    emit(state.copyWith(generatedName: null));
  }

  void _onCheckAutoGenerateName(CreateQuranPrayerEventCheckAutoGenerateName event, Emitter<CreateQuranPrayerState> emit){
    EasyDebounce.debounce("Check Visibility", const Duration(milliseconds: 700), () {
      add(CreateQuranPrayerEventCheckAutoGenerateNameImmediately(text: event.text));
    });
  }

  void _onCheckAutoGenerateNameImmediately(CreateQuranPrayerEventCheckAutoGenerateNameImmediately event, Emitter<CreateQuranPrayerState> emit){
    emit(state.copyWith(showAutoGenerateNameButton: event.text.isEmpty));
  }

  void _onAutoGenerateName(CreateQuranPrayerEventAutoGenerateName event, Emitter<CreateQuranPrayerState> emit){
    final surahName = state.selectedSurah?.name ?? "?";
    final generatedName = "$surahName ${state.firstSelectedVerseNumber?.text}-${state.lastSelectedVerseNumber?.text}";
    emit(state.copyWith(generatedName: generatedName, showAutoGenerateNameButton: false));
  }
  
  void _onInit(CreateQuranPrayerEventInit event,Emitter<CreateQuranPrayerState>emit)async {
    final initResult = await _selectVerseManager.getInitModel();
    final quranData = await _prayerCustomByQuranRepo.getQuranData(surahId: 1, firstItemIndex: 0, lastItemIndex: 0);

    emit(state.copyWith(
        cuzs: initResult.cuzs,
        surahes: initResult.surahes,
        verseNumbers: initResult.currentVerseNumbers,
        selectedCuz: initResult.cuzs.firstOrNull,
        selectedSurah: initResult.surahes.firstOrNull,
        firstSelectedVerseNumber: initResult.currentVerseNumbers.firstOrNull,
        lastSelectedVerseNumber: initResult.currentVerseNumbers.firstOrNull,
        arabicContent: quranData.arabicContent,
        meaningContent: quranData.meaningContent
    ));
  }


  void _onSelectCuz(CreateQuranPrayerEventSelectCuz event, Emitter<CreateQuranPrayerState> emit)async{
    final result = await _selectVerseManager.selectCuz(
        currentSurah: state.selectedSurah,
        currentCuz: event.cuz,
        currentVerseNumber: state.firstSelectedVerseNumber
    );
    final quranData = await _prayerCustomByQuranRepo.getQuranData(surahId: result.surah?.id ?? 1, firstItemIndex: 0, lastItemIndex: 0);

    emit(state.copyWith(
        selectedCuz: result.cuz,
        selectedSurah: result.surah,
        verseNumbers: result.validVerseNumbers,
        firstSelectedVerseNumber: result.validVerseNumbers.firstOrNull,
        lastSelectedVerseNumber: result.validVerseNumbers.firstOrNull,
        arabicContent: quranData.arabicContent,
        meaningContent: quranData.meaningContent
    ));
  }

  void _onSelectSurah(CreateQuranPrayerEventSelectSurah event, Emitter<CreateQuranPrayerState> emit)async{
    final result = await _selectVerseManager.selectSurah(
        currentSurah: event.surah,
        currentCuz: state.selectedCuz,
        currentVerseNumber: state.firstSelectedVerseNumber
    );
    final quranData = await _prayerCustomByQuranRepo.getQuranData(surahId: result.surah?.id ?? 1, firstItemIndex: 0, lastItemIndex: 0);

    emit(state.copyWith(
        selectedCuz: result.cuz,
        selectedSurah: result.surah,
        verseNumbers: result.validVerseNumbers,
        firstSelectedVerseNumber: result.validVerseNumbers.firstOrNull,
        lastSelectedVerseNumber: result.validVerseNumbers.firstOrNull,
        arabicContent: quranData.arabicContent,
        meaningContent: quranData.meaningContent
    ));
  }

  void _onSelectVerse(CreateQuranPrayerEventSelectVerse event, Emitter<CreateQuranPrayerState> emit)async {
    final result = await _selectVerseManager.selectVerse(
        currentSurah: state.selectedSurah,
        currentCuz: state.selectedCuz,
        currentVerseNumber: event.verseNumber
    );
    var firstSelectedVerseNumber = event.isFirstField ? result
        .currentVerseNumber : state.firstSelectedVerseNumber;
    var lastSelectedVerseNumber = event.isFirstField ? state
        .lastSelectedVerseNumber : result.currentVerseNumber;

    var firstIndex = state.verseNumbers.indexWhere((element) =>
    element.text == firstSelectedVerseNumber?.text);
    var lastIndex = state.verseNumbers.indexWhere((element) =>
    element.text == lastSelectedVerseNumber?.text);

    if (firstIndex > lastIndex) {
      if (event.isFirstField) {
        lastSelectedVerseNumber = firstSelectedVerseNumber;
        lastIndex = firstIndex;
      } else {
        firstSelectedVerseNumber = lastSelectedVerseNumber;
        firstIndex = lastIndex;
      }
    }

    final contentData = await _prayerCustomByQuranRepo.getQuranData(
        surahId: result.surah!.id,
        firstItemIndex: firstIndex,
        lastItemIndex: lastIndex
    );

    emit(state.copyWith(
        selectedCuz: result.cuz,
        selectedSurah: result.surah,
        verseNumbers: result.validVerseNumbers,
        firstSelectedVerseNumber: firstSelectedVerseNumber,
        lastSelectedVerseNumber: lastSelectedVerseNumber,
        arabicContent: contentData.arabicContent,
        meaningContent: contentData.meaningContent
    ));
  }

  void _onInsert(CreateQuranPrayerEventInsert event,Emitter<CreateQuranPrayerState>emit)async {
    final surah = state.selectedSurah;
    if(surah == null){
      emit(state.copyWith(message: "Bir şeyler yanlış gitti"));
      return;
    }
    final response = await _prayerCustomByQuranRepo.insertCustomPrayer(
        surah: surah,
        validVerseNumbers: state.verseNumbers,
        firstVerseNumber: state.firstSelectedVerseNumber,
        lastVerseNumber: state.lastSelectedVerseNumber,
        name: event.name
    );
    response.handle(
      onError: (e){
        emit(state.copyWith(message: e));
      },
      onSuccess: (x){
        emit(state.copyWith(message: "Başarılı", navigateBack: true));
      }
    );
  }

  void _onClearNavigateBack(CreateQuranPrayerEventClearNavigateBack event,Emitter<CreateQuranPrayerState>emit){
    emit(state.copyWith(
      navigateBack: false
    ));
    // for init state
    final surah = state.surahes.firstOrNull;
    if(surah != null){
      add(CreateQuranPrayerEventSelectSurah(surah: surah));
    }
  }
}