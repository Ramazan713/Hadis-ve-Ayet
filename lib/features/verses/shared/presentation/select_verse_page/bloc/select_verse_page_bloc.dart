

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_result/select_page_result.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/shared/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_verse_use_cases.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

import 'select_verse_page_event.dart';
import 'select_verse_page_state.dart';

class SelectVersePageBloc extends Bloc<ISelectVersePageEvent,SelectVersePageState>{

  late final SelectVersePageRepo _versePageRepo;
  late final SelectVerseUseCases _selectVerseUseCases;

  SelectVersePageBloc({
    required SelectVersePageRepo selectVersePageRepo,
    required SelectVerseUseCases selectVerseUseCases
  }): super(SelectVersePageState.init()){

    _versePageRepo = selectVersePageRepo;
    _selectVerseUseCases = selectVerseUseCases;

    on<SelectVerseEventLoadData>(_onLoadData,transformer: restartable());
    on<SelectVerseEventInitData>(_onInitData,transformer: restartable());

    on<SelectVerseEventSelectCuz>(_onSelectCuz,transformer: restartable());
    on<SelectVerseEventSelectSurah>(_onSelectSurah,transformer: restartable());
    on<SelectVerseEventSelectVerse>(_onSelectVerse,transformer: restartable());
    on<SelectVerseEventSelectPage>(_onSelectPage,transformer: restartable());
    on<SelectVerseEventSelectPageExecute>(_onSelectPageExecute,transformer: restartable());
    on<SelectVerseEventApprove>(_onApprove,transformer: restartable());

    on<SelectVersePageEventClearMessage>(_onClearMessage,transformer: restartable());
    on<SelectVerseEventClearResult>(_onClearResult,transformer: restartable());

    add(SelectVerseEventInitData());
  }

  void _onInitData(SelectVerseEventInitData event, Emitter<SelectVersePageState> emit)async{
    final cuzs = await _versePageRepo.getCuzs();
    final surahes = await _versePageRepo.getSurahes();
    final verseNumbers = await _getVerseNumbers(surahes.firstOrNull);
    final maxPage = await _versePageRepo.getMaxPage();

    emit(state.copyWith(
        cuzs: cuzs,
        surahes: surahes,
        verseNumbers: verseNumbers,
        maxPage: maxPage,
        selectedVerseNumber: verseNumbers.firstOrNull,
        selectedSurah: surahes.firstOrNull,
        selectedCuz: cuzs.firstOrNull,
        page: 1
    ));
  }

  void _onLoadData(SelectVerseEventLoadData event, Emitter<SelectVersePageState> emit)async{
    final startPage = event.startPage;
    if(startPage!=null){
      add(SelectVerseEventSelectPageExecute(page: startPage));
    }
  }

  void _onSelectCuz(SelectVerseEventSelectCuz event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseUseCases.selectCuz.call(
      cuz: event.cuz,
      currentPage: state.page,
      currentSurah: state.selectedSurah,
      currentVerseNumber: state.selectedVerseNumber
    );
    final verseNumbers = await _getVerseNumbers(result.surah);

    emit(state.copyWith(
      verseNumbers: verseNumbers,
      selectedCuz: event.cuz,
      selectedSurah: result.surah,
      selectedVerseNumber: result.verseNumber,
      page: result.page,
      isLoading: false
    ));
  }

  void _onSelectSurah(SelectVerseEventSelectSurah event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseUseCases.selectSurah.call(
      surah: event.surah,
      currentPage: state.page,
      currentCuz: state.selectedCuz,
      currentVerseNumber: state.selectedVerseNumber
    );
    final verseNumbers = await _getVerseNumbers(result.surah);

    emit(state.copyWith(
      selectedCuz: result.cuz,
      selectedSurah: result.surah,
      verseNumbers: verseNumbers,
      selectedVerseNumber: result.verseNumber,
      page: result.page,
      isLoading: false
    ));
  }

  void _onSelectVerse(SelectVerseEventSelectVerse event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseUseCases.selectVerseNumber.call(
      currentSurah: state.selectedSurah,
      currentPage: state.page,
      currentCuz: state.selectedCuz,
      currentVerseNumber: event.verseNumber
    );
    final verseNumbers = await _getVerseNumbers(result.surah);

    emit(state.copyWith(
      verseNumbers: verseNumbers,
      selectedCuz: result.cuz,
      selectedSurah: result.surah,
      selectedVerseNumber: result.verseNumber,
      page: result.page,
      isLoading: false
    ));
  }

  void _onSelectPageExecute(SelectVerseEventSelectPageExecute event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseUseCases.selectPage.call(
        currentSurah: state.selectedSurah,
        currentPage: event.page,
        currentCuz: state.selectedCuz,
        currentVerseNumber: state.selectedVerseNumber
    );
    final verseNumbers = await _getVerseNumbers(result.surah);
    emit(state.copyWith(
        verseNumbers: verseNumbers,
        selectedCuz: result.cuz,
        selectedSurah: result.surah,
        selectedVerseNumber: result.verseNumber,
        page: result.page,
        isLoading: false
    ));
  }

  void _onSelectPage(SelectVerseEventSelectPage event, Emitter<SelectVersePageState> emit)async{
    EasyDebounce.debounce("select_page_searchable", const Duration(milliseconds: 700), () async{
      final int page = int.tryParse(event.page) ?? state.page;
      if(page < 1 || page > state.maxPage) return;
      add(SelectVerseEventSelectPageExecute(page: page));
    });
  }

  void _onApprove(SelectVerseEventApprove event, Emitter<SelectVersePageState> emit)async{
    final cuzNo = state.selectedCuz?.no;
    final surahId = state.selectedSurah?.id;
    final verseNumber = state.selectedVerseNumber?.text;
    final pageNo = state.page;

    if(cuzNo == null || surahId == null || verseNumber == null || pageNo < 0 || pageNo > state.maxPage){
      return emit(state.copyWith(
        message: "Bir şeyler yanlış gitti"
      ));
    }

    final pagePos = await _versePageRepo.getPagePos(pageNo, verseNumber, surahId, cuzNo);
    if(pagePos == null){
      return emit(state.copyWith(
          message: "Bir şeyler yanlış gitti"
      ));
    }

    emit(state.copyWith(
      selectResult: SelectPageResult(pageNo: pageNo, pagePos: pagePos)
    ));
  }

  void _onClearMessage(SelectVersePageEventClearMessage event, Emitter<SelectVersePageState> emit){
    emit(state.copyWith(message: null));
  }

  void _onClearResult(SelectVerseEventClearResult event, Emitter<SelectVersePageState> emit){
    emit(state.copyWith(selectResult: null));
  }

  Future<List<VerseNumber>> _getVerseNumbers(Surah? surah)async{
    final verseNumbersStr = await _versePageRepo.getVerseNumbers(surah?.id ?? 1);
    final verseNumbers = VerseNumber.from(verseNumbersStr);
    return verseNumbers;
  }

}