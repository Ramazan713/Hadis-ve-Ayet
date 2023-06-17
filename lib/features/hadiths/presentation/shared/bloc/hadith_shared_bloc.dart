import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/i_key.dart';
import 'package:hadith/core/domain/repo/title_repo.dart';
import 'package:hadith/core/domain/use_cases/select_list/select_list_use_cases.dart';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';
import 'package:hadith/utils/font_size_helper.dart';

import 'hadith_shared_event.dart';
import 'hadith_shared_state.dart';

class HadithSharedBloc extends Bloc<IHadithSharedEvent,HadithSharedState>{

  late final SelectListUseCases _selectListUseCases;
  late final TitleRepo _titleRepo;
  late final AppPreferences _appPreferences;

  HadithSharedBloc({
    required SelectListUseCases selectListUseCases,
    required TitleRepo titleRepo,
    required AppPreferences appPreferences
  }) : super(HadithSharedState.init()){

    _selectListUseCases = selectListUseCases;
    _titleRepo = titleRepo;
    _appPreferences = appPreferences;

    on<HadithSharedEventFavorite>(_onHadithClick, transformer: restartable());
    on<HadithSharedEventSetTitle>(_onSetTitle, transformer: restartable());
    on<HadithSharedEventListenFontSize>(_onListenFontSize, transformer: restartable());
    on<HadithSharedEventClearInvalidateEvent>(_onHadithEventClearInvalidateEvent, transformer: restartable());


    add(HadithSharedEventListenFontSize());
  }


  void _onHadithClick(HadithSharedEventFavorite event,Emitter<HadithSharedState>emit)async{
    await _selectListUseCases.addFavoriteList.call(itemId: event.item.hadith.id??0,
        sourceType: SourceTypeEnum.hadith);

    final op = event.listFavAffected ? PagingInvalidateOp.unknown : PagingInvalidateOp.update;

    emit(state.copyWith(invalidateEvent: PagingModifiedItem(item: event.item,
        op: op),setInvalidateEvent: true));
  }

  void _onHadithEventClearInvalidateEvent(HadithSharedEventClearInvalidateEvent event,Emitter<HadithSharedState>emit)async{
    emit(state.copyWith(setInvalidateEvent: true));
  }

  void _onSetTitle(HadithSharedEventSetTitle event,Emitter<HadithSharedState>emit)async{
    final title = await _titleRepo.getTitle(event.itemId, event.titleEnum);
    emit(state.copyWith(title: title));
  }

  void _onListenFontSize(HadithSharedEventListenFontSize event, Emitter<HadithSharedState>emit )async{

    final fontSize = _appPreferences.getItem(KPref.fontSizeContent);
    final listFav = await _selectListUseCases.getFavoriteList.call(sourceType: SourceTypeEnum.hadith);

    emit(state.copyWith(favListId: listFav.id,contentFontSize: fontSize));

    final streamData = _appPreferences.listenerFiltered([KPref.fontSizeContent]);

    await emit.forEach<IKey>(streamData, onData: (data){
      final fontSize = _appPreferences.getItem(KPref.fontSizeContent);
      return state.copyWith(contentFontSize: fontSize);
    });
  }

}