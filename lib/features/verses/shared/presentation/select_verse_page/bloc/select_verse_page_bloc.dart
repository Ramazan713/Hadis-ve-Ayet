import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verses/domain/manager/select_verse_manager.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_result/select_page_result.dart';
import 'package:hadith/core/features/verses/domain/repo/select_verse_page_repo.dart';

import 'select_verse_page_event.dart';
import 'select_verse_page_state.dart';

class SelectVersePageBloc extends Bloc<ISelectVersePageEvent,SelectVersePageState>{

  late final SelectVersePageRepo _versePageRepo;
  late final SelectVerseManager _selectVerseManager;

  SelectVersePageBloc({
    required SelectVersePageRepo selectVersePageRepo,
    required SelectVerseManager selectVerseManager
  }): super(SelectVersePageState.init()){

    _versePageRepo = selectVersePageRepo;
    _selectVerseManager = selectVerseManager;

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
    final initResult = await _selectVerseManager.getInitModel();

    emit(state.copyWith(
        cuzs: initResult.cuzs,
        surahes: initResult.surahes,
        verseNumbers: initResult.currentVerseNumbers,
        maxPage: initResult.pageMaxPos,
        selectedVerseNumber: initResult.currentVerseNumbers.firstOrNull,
        selectedSurah: initResult.surahes.firstOrNull,
        selectedCuz: initResult.cuzs.firstOrNull,
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
    final result = await _selectVerseManager.selectCuz(
      currentCuz: event.cuz,
      currentPage: state.page,
      currentSurah: state.selectedSurah,
      currentVerseNumber: state.selectedVerseNumber
    );
    emit(state.fromSelectVerse(selectVerse: result));
  }

  void _onSelectSurah(SelectVerseEventSelectSurah event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseManager.selectSurah(
      currentSurah: event.surah,
      currentPage: state.page,
      currentCuz: state.selectedCuz,
      currentVerseNumber: state.selectedVerseNumber
    );
    emit(state.fromSelectVerse(selectVerse: result));
  }

  void _onSelectVerse(SelectVerseEventSelectVerse event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseManager.selectVerse(
      currentSurah: state.selectedSurah,
      currentPage: state.page,
      currentCuz: state.selectedCuz,
      currentVerseNumber: event.verseNumber
    );
    emit(state.fromSelectVerse(selectVerse: result));
  }

  void _onSelectPageExecute(SelectVerseEventSelectPageExecute event, Emitter<SelectVersePageState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseManager.selectPage(
        currentSurah: state.selectedSurah,
        currentPage: event.page,
        currentCuz: state.selectedCuz,
        currentVerseNumber: state.selectedVerseNumber
    );
    emit(state.fromSelectVerse(selectVerse: result));
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
}