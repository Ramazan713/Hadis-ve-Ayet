import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/use_cases/select_list/select_list_use_cases.dart';
import 'package:hadith/core/features/pagination/paging_modified_item.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_fetch_name_enum.dart';
import 'package:hadith/core/domain/repo/hadith_repo.dart';
import 'package:hadith/utils/font_size_helper.dart';

import 'hadith_shared_event.dart';
import 'hadith_shared_state.dart';

class HadithSharedBloc extends Bloc<IHadithSharedEvent,HadithSharedState>{

  late final SelectListUseCases _selectListUseCases;
  late final HadithRepo _hadithRepo;
  late final ListRepo _listRepo;

  HadithSharedBloc({
    required SelectListUseCases selectListUseCases,
    required HadithRepo hadithRepo,
    required ListRepo listRepo
  }) : super(HadithSharedState.init()){

    _selectListUseCases = selectListUseCases;
    _hadithRepo = hadithRepo;
    _listRepo = listRepo;

    on<HadithSharedEventFavorite>(_onHadithClick, transformer: restartable());
    on<HadithSharedEventFetchName>(_onFetchName, transformer: restartable());
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

  void _onFetchName(HadithSharedEventFetchName event,Emitter<HadithSharedState>emit)async{
    final String name;
    switch(event.fetchNameEnum){
      case HadithFetchNameEnum.topic:
        name = (await _hadithRepo.getTopicName(event.itemId)) ?? "";
        break;
      case HadithFetchNameEnum.list:
        name = (await _listRepo.getListName(event.itemId)) ?? "";
        break;
    }
    emit(state.copyWith(name: name));
  }

  void _onListenFontSize(HadithSharedEventListenFontSize event, Emitter<HadithSharedState>emit )async{

    final listFav = await _selectListUseCases.getFavoriteList.call(sourceType: SourceTypeEnum.hadith);

    emit(state.copyWith(favListId: listFav.id));

    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize, onData: (data){
      return state.copyWith(fontSize: data);
    });
  }

}