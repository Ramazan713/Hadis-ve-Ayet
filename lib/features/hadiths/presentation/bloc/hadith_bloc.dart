

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/db/entities/list_hadith_entity.dart';
import 'package:hadith/db/repos/list_repo.dart';
import 'package:hadith/features/hadiths/data/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/bloc/hadith_event.dart';
import 'package:hadith/features/hadiths/presentation/bloc/hadith_state.dart';
import 'package:hadith/features/hadiths/presentation/model/hadith_invalidate_event.dart';

class HadithBloc extends Bloc<IHadithEvent,HadithState>{

  late final HadithAllPagingRepo _hadithPagingRepo;
  late final ListRepo _listRepo;

  HadithBloc({required HadithAllPagingRepo hadithPagingRepo,required ListRepo listRepo}) : super(HadithState.init()){
    _hadithPagingRepo = hadithPagingRepo;
    _listRepo = listRepo;


    on<HadithEventFavorite>(_onHadithClick);
    on<HadithEventClearInvalidateEvent>(_onHadithEventClearInvalidateEvent);
  }


  void _onHadithClick(HadithEventFavorite event,Emitter<HadithState>emit)async{
    final maxPos = (await _listRepo.getMaxPosList())?.data??0;
    final hadith = event.item.hadith;

    final lists = await _listRepo.getHadithListWithRemovable(hadith.id??0, false);

    if(lists.map((e) => e.hadithId).contains(hadith.id)){
      await _listRepo.deleteHadithList(lists.firstWhere((element) => element.hadithId == hadith.id));
    }else{
      await _listRepo.insertHadithList(ListHadithEntity(listId: 1, hadithId: hadith.id??0, pos: maxPos + 1));
    }
    emit(state.copyWith(invalidateEvent: HadithInvalidateEvent(item: event.item,
        op: PagingInvalidateOp.update),setInvalidateEvent: true));
  }

  void _onHadithEventClearInvalidateEvent(HadithEventClearInvalidateEvent event,Emitter<HadithState>emit)async{
    emit(state.copyWith(setInvalidateEvent: true));
  }

}