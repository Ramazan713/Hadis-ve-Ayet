


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/list_ext.dart';
import 'package:hadith/core/features/select_quran_section/domain/manager/select_quran_manager.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_content/select_quran_content.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_model/select_quran_model.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_result/select_quran_section_result.dart';
import 'package:hadith/core/features/select_quran_section/domain/repo/select_quran_page_repo.dart';
import 'package:hadith/core/features/select_quran_section/presentation/bloc/select_quran_section_event.dart';
import 'package:hadith/core/features/select_quran_section/presentation/bloc/select_quran_section_state.dart';

class SelectQuranSectionBloc extends Bloc<ISelectQuranSectionEvent,SelectQuranSectionState>{

  late final SelectQuranManager _selectVerseManager;
  late final SelectQuranPageRepo _versePageRepo;

  bool _generateVerseContent = true;

  SelectQuranSectionBloc({
    required SelectQuranManager selectVerseManager,
    required SelectQuranPageRepo selectVersePageRepo,
  }) : super(SelectQuranSectionState.init()){

    _selectVerseManager = selectVerseManager;
    _versePageRepo = selectVersePageRepo;

    on<SelectQuranSectionEventClearMessage>(_onClearMessage,transformer: restartable());
    on<SelectQuranSectionEventInit>(_onInit);
    on<SelectQuranSectionEventSelectCuz>(_onSelectCuz,transformer: restartable());
    on<SelectQuranSectionEventSelectSurah>(_onSelectSurah,transformer: restartable());
    on<SelectQuranSectionEventSubmit>(_onSubmit,transformer: restartable());
    on<SelectQuranSectionEventSelectVerse>(_onSelectVerse,transformer: restartable());
    on<SelectQuranSectionEventCheckAutoGenerateName>(_onCheckAutoGenerateName,transformer: restartable());
    on<SelectQuranSectionEventCheckAutoGenerateNameImmediately>(_onCheckAutoGenerateNameImmediately,transformer: restartable());
    on<SelectQuranSectionEventAutoGenerateName>(_onAutoGenerateName,transformer: restartable());
    on<SelectQuranSectionEventClearSetName>(_onClearSetName,transformer: restartable());
    on<SelectQuranSectionEventLoadData>(_onLoadData,transformer: restartable());
    on<SelectQuranSectionEventSelectPageExecute>(_onSelectPageExecute,transformer: restartable());
    on<SelectQuranSectionEventSelectPage>(_onSelectPage,transformer: restartable());
    on<SelectQuranSectionEventClearResult>(_onClearResult,transformer: restartable());

    add(SelectQuranSectionEventInit());
  }

  void _onClearMessage(SelectQuranSectionEventClearMessage event, Emitter<SelectQuranSectionState> emit){
    emit(state.copyWith(message: null));
  }

  void _onClearResult(SelectQuranSectionEventClearResult event, Emitter<SelectQuranSectionState> emit){
    emit(state.copyWith(result: null));
  }

  void _onClearSetName(SelectQuranSectionEventClearSetName event, Emitter<SelectQuranSectionState> emit){
    emit(state.copyWith(generatedName: null));
  }

  void _onCheckAutoGenerateName(SelectQuranSectionEventCheckAutoGenerateName event, Emitter<SelectQuranSectionState> emit){
    EasyDebounce.debounce("Check Visibility", const Duration(milliseconds: 700), () {
      add(SelectQuranSectionEventCheckAutoGenerateNameImmediately(text: event.text));
    });
  }

  void _onCheckAutoGenerateNameImmediately(SelectQuranSectionEventCheckAutoGenerateNameImmediately event, Emitter<SelectQuranSectionState> emit){
    emit(state.copyWith(showAutoGenerateNameButton: event.text.isEmpty));
  }

  void _onAutoGenerateName(SelectQuranSectionEventAutoGenerateName event, Emitter<SelectQuranSectionState> emit){
    final generatedName = _generateName();
    emit(state.copyWith(generatedName: generatedName, showAutoGenerateNameButton: false));
  }

  void _onInit(SelectQuranSectionEventInit event,Emitter<SelectQuranSectionState>emit)async {
    final initResult = await _selectVerseManager.getInitModel();

    emit(state.copyWith(
      cuzs: initResult.cuzs,
      surahes: initResult.surahes,
      verseNumbers: initResult.currentVerseNumbers,
      selectedCuz: initResult.cuzs.firstOrNull,
      selectedSurah: initResult.surahes.firstOrNull,
      firstSelectedVerseNumber: initResult.currentVerseNumbers.firstOrNull,
      lastSelectedVerseNumber: initResult.currentVerseNumbers.firstOrNull,
      arabicContent: initResult.arabicContent,
      meaningContent: initResult.meaningContent,
      maxPage: initResult.pageMaxPos,
      page: 1
    ));
  }


  void _onLoadData(SelectQuranSectionEventLoadData event, Emitter<SelectQuranSectionState> emit)async{
    final loadConfig = event.loadConfig;
    _generateVerseContent = event.generateVerseContent;

    final result = await _selectVerseManager.loadInit(
      loadConfig: loadConfig,
      surahes: state.surahes
    ) ??
        await _selectVerseManager.selectPage(
          currentSurah: state.surahes.firstOrNull,
          currentCuz: state.cuzs.firstOrNull,
          currentFirstVerseNumber: null,
          currentLastVerseNumber: null,
          currentPage: 1
        );

    final quranData = await _getQuranData2(result);
    emit(state.fromSelectVerse(
        selectVerse: result,
        quranData: quranData
    ).copyWith(result: null)
    );
  }

  void _onSelectPage(SelectQuranSectionEventSelectPage event, Emitter<SelectQuranSectionState> emit)async{
    EasyDebounce.debounce("select_page_searchable", const Duration(milliseconds: 700), () async{
      final int page = int.tryParse(event.page) ?? state.page;
      if(page < 1 || page > state.maxPage || page == state.page) return;
      add(SelectQuranSectionEventSelectPageExecute(page: page));
    });
  }

  void _onSelectPageExecute(SelectQuranSectionEventSelectPageExecute event, Emitter<SelectQuranSectionState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await _selectVerseManager.selectPage(
      currentSurah: state.selectedSurah,
      currentPage: event.page,
      currentCuz: state.selectedCuz,
      currentFirstVerseNumber: state.firstSelectedVerseNumber,
      currentLastVerseNumber: state.lastSelectedVerseNumber,
    );

    final quranData = await _getQuranData2(result);

    emit(state.fromSelectVerse(
      selectVerse: result,
      quranData: quranData
    ));
  }
  
  void _onSelectCuz(SelectQuranSectionEventSelectCuz event, Emitter<SelectQuranSectionState> emit)async{
    final result = await _selectVerseManager.selectCuz(
      currentSurah: state.selectedSurah,
      currentCuz: event.cuz,
      currentFirstVerseNumber: state.firstSelectedVerseNumber,
      currentLastVerseNumber: state.lastSelectedVerseNumber,
      currentPage: state.page
    );
    final quranData = await _getQuranData2(result);

    emit(state.fromSelectVerse(
      selectVerse: result,
      quranData: quranData
    ));
  }

  void _onSelectSurah(SelectQuranSectionEventSelectSurah event, Emitter<SelectQuranSectionState> emit)async{
    final result = await _selectVerseManager.selectSurah(
      currentSurah: event.surah,
      currentCuz: state.selectedCuz,
      currentFirstVerseNumber: state.firstSelectedVerseNumber,
      currentLastVerseNumber: state.lastSelectedVerseNumber,
      currentPage: state.page
    );
    final quranData = await _getQuranData2(result);

    emit(state.fromSelectVerse(
        selectVerse: result,
        quranData: quranData
    ));
  }

  void _onSelectVerse(SelectQuranSectionEventSelectVerse event, Emitter<SelectQuranSectionState> emit)async {
    final result = await _selectVerseManager.selectVerse(
        currentSurah: state.selectedSurah,
        currentCuz: state.selectedCuz,
        currentVerseNumber: event.verseNumber,
        currentPage: state.page,

    );
    var firstSelectedVerseNumber = event.isFirstField ? result
        .firstVerseNumber : state.firstSelectedVerseNumber;
    var lastSelectedVerseNumber = event.isFirstField ? state
        .lastSelectedVerseNumber : result.firstVerseNumber;

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

    final firstVerseNumberChange = firstSelectedVerseNumber != state.firstSelectedVerseNumber;

    final quranData = await _selectVerseManager.getQuranData(
        surahId: result.surah!.id,
        firstItemIndex: firstIndex,
        lastItemIndex: lastIndex
    );

    emit(state.fromSelectVerse(
        selectVerse: result,
        quranData: quranData
    ).copyWith(
        firstSelectedVerseNumber: firstSelectedVerseNumber,
        lastSelectedVerseNumber: lastSelectedVerseNumber,
        page: firstVerseNumberChange ? result.page : state.page
    ));
  }

  void _onSubmit(SelectQuranSectionEventSubmit event, Emitter<SelectQuranSectionState> emit)async{
    final surah = state.selectedSurah;
    final cuz = state.selectedCuz;
    final firstVerseNumber = state.firstSelectedVerseNumber;
    final lastVerseNumber = state.lastSelectedVerseNumber;
    final pageNo = state.page;

    if(![cuz, surah, firstVerseNumber, lastVerseNumber].allIsNotNull() || pageNo < 0 || pageNo > state.maxPage){
      return emit(state.copyWith(
        message: "Bir şeyler yanlış gitti xxx"
      ));
    }

    final pagePos = await _versePageRepo.getPagePos(pageNo, firstVerseNumber!.text, surah!.id, cuz!.no);
    if(pagePos == null){
      return emit(state.copyWith(
          message: "Bir şeyler yanlış gitti yy"
      ));
    }

    final currentName = event.name.isEmpty ? _generateName() : event.name;

    final quranData = await _selectVerseManager.getQuranData2(
      surahId: surah.id,
      firstVerseNumber: firstVerseNumber,
      lastVerseNumber: lastVerseNumber!,
      validVerseNumbers: state.verseNumbers,
      includeSelectedVerses: event.includeSelectedVerses
    );

    final result = SelectQuranSectionResult(
      name: currentName,
      pageNo: pageNo,
      pagePos: pagePos,
      selectedCuz: cuz,
      selectedSurah: surah,
      firstSelectedVerseNumber: firstVerseNumber,
      lastSelectedVerseNumber: lastVerseNumber,
      arabicContent: quranData.arabicContent,
      meaningContent: quranData.meaningContent,
      selectedVerses:quranData.verses,
      source: _generateName()
    );

    emit(state.copyWith(
      result: result
    ));

  }

  Future<SelectQuranContent?> _getQuranData2(SelectQuranModel selectVerse) async {
    if(_generateVerseContent == false) return null;
    return _selectVerseManager.getQuranData2(
      surahId: selectVerse.surah?.id ?? 1,
      firstVerseNumber: selectVerse.firstVerseNumber ?? selectVerse.validVerseNumbers.first,
      lastVerseNumber: selectVerse.lastVerseNumber ?? selectVerse.validVerseNumbers.first,
      validVerseNumbers: selectVerse.validVerseNumbers
    );
  }

  String _generateName(){
    final surahName = state.selectedSurah?.name ?? "?";
    var first = (state.firstSelectedVerseNumber?.text ?? "").split(",")[0];
    var lastArr = (state.lastSelectedVerseNumber?.text ?? "").split(",");
    final last = lastArr.length > 1 ? lastArr[lastArr.length - 1] : lastArr[0];

    final lastPart = first == last ? first : "$first-$last";
    final generatedName = "$surahName $lastPart";
    return generatedName;
  }

}