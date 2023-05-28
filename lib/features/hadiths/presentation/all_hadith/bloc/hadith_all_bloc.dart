

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/use_cases/list_hadith/list_hadith_use_cases.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/db/entities/list_hadith_entity.dart';
import 'package:hadith/db/repos/list_repo.dart';
import 'package:hadith/utils/font_size_helper.dart';

import '../model/hadith_invalidate_event.dart';
import 'hadith_all_event.dart';
import 'hadith_all_state.dart';

class HadithAllBloc extends Bloc<IHadithAllEvent,HadithAllState>{

  late final ListHadithUseCases _listHadithUseCases;

  HadithAllBloc({required ListHadithUseCases listHadithUseCases}) : super(HadithAllState.init()){
    _listHadithUseCases = listHadithUseCases;

    on<HadithEventFavorite>(_onHadithClick);
    on<HadithEventListenFontSize>(_onListenFontSize);
    on<HadithEventClearInvalidateEvent>(_onHadithEventClearInvalidateEvent);


    add(HadithEventListenFontSize());
  }


  void _onHadithClick(HadithEventFavorite event,Emitter<HadithAllState>emit)async{
    await _listHadithUseCases.addFavoriteList.call(event.item.hadith.id??0);
    emit(state.copyWith(invalidateEvent: HadithInvalidateEvent(item: event.item,
        op: PagingInvalidateOp.update),setInvalidateEvent: true));
  }

  void _onHadithEventClearInvalidateEvent(HadithEventClearInvalidateEvent event,Emitter<HadithAllState>emit)async{
    emit(state.copyWith(setInvalidateEvent: true));
  }


  void _onListenFontSize(HadithEventListenFontSize event, Emitter<HadithAllState>emit )async{
    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize, onData: (data){
      return state.copyWith(fontSize: data);
    });
  }

}