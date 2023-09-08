

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/i_key.dart';
import 'package:hadith/core/domain/repo/title_repo.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/domain/use_cases/select_list/select_list_use_cases.dart';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';

import 'verse_shared_event.dart';
import 'verse_shared_state.dart';

class VerseSharedBloc extends Bloc<IVerseSharedEvent, VerseSharedState>{

  late final AppPreferences _appPreferences;
  late final SelectListUseCases _selectListUseCases;
  late final TitleRepo _titleRepo;
  late final FontModelUseCase _fontModelUseCase;

  VerseSharedBloc({
    required AppPreferences appPreferences,
    required SelectListUseCases selectListUseCases,
    required TitleRepo titleRepo,
    required FontModelUseCase fontModelUseCase
  }): super(VerseSharedState.init()){

    _appPreferences = appPreferences;
    _selectListUseCases = selectListUseCases;
    _titleRepo = titleRepo;
    _fontModelUseCase = fontModelUseCase;

    on<VerseSharedEventInit>(_onInit,transformer: restartable());
    on<VerseSharedEventSetTitle>(_onSetTitle,transformer: restartable());
    on<VerseSharedEventAddFavorite>(_onAddFavorite,transformer: restartable());
    on<VerseSharedEventClearInvalidateEvent>(_onClearInvalidateEvent,transformer: restartable());

    add(VerseSharedEventInit());
  }


  void _onSetTitle(VerseSharedEventSetTitle event, Emitter<VerseSharedState> emit)async{
    final title = await _titleRepo.getTitle(event.itemId, event.titleEnum);
    emit(state.copyWith(title: title));
  }


  void _onAddFavorite(VerseSharedEventAddFavorite event, Emitter<VerseSharedState> emit)async{
    await _selectListUseCases.addFavoriteList.call(itemId: event.verseListModel.verse.id ?? 0,
        sourceType: SourceTypeEnum.verse);

    final op = event.listFavAffected ? PagingInvalidateOp.unknown : PagingInvalidateOp.update;

    emit(state.copyWith(invalidateEvent:
      PagingModifiedItem(item: event.verseListModel, op: op),setInvalidateEvent: true));
  }

  void _onClearInvalidateEvent(VerseSharedEventClearInvalidateEvent event, Emitter<VerseSharedState> emit)async{
    emit(state.copyWith(setInvalidateEvent: true));
  }

  void _onInit(VerseSharedEventInit event, Emitter<VerseSharedState> emit)async{

    final listFav = await _selectListUseCases.getFavoriteList.call(sourceType: SourceTypeEnum.verse);


    final showVerseListIcons = _appPreferences.getItem(KPref.showVerseListIcons);
    final verseUi = _appPreferences.getEnumItem(KPref.verseAppearanceEnum);

    emit(state.copyWith(
      fontModel: _fontModelUseCase(),
      showListVerseIcons: showVerseListIcons,
      arabicVerseUIEnum: verseUi,
      favListId: listFav.id
    ));


    await emit.forEach<IKey>(_appPreferences.listener, onData: (key){
      final showVerseListIcons = _appPreferences.getItem(KPref.showVerseListIcons);
      final verseUi = _appPreferences.getEnumItem(KPref.verseAppearanceEnum);

      return state.copyWith(
          fontModel: _fontModelUseCase(),
          showListVerseIcons: showVerseListIcons,
          arabicVerseUIEnum: verseUi
      );
    });
  }

}