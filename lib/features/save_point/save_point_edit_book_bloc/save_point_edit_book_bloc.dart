


import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/db/repos/save_point_repo.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_event.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_state.dart';
import 'package:rxdart/rxdart.dart';

class SavePointEditBookBloc extends Bloc<ISavePointBookEditEvent,SavePointEditBookState>{
  late final SavePointRepo _savePointRepo;

  final BehaviorSubject<OriginTag?>_filterController = BehaviorSubject();

  SavePointEditBookBloc({required SavePointRepo savePointRepo}) : super(SavePointEditBookState.init()){
    _savePointRepo = savePointRepo;

    on<SavePointBookEditEventRequest>(_onDataRequest,transformer: restartable());
    on<SavePointBookEditEventSelectSavePoint>(_onSelectSavePoint,transformer: restartable());
    on<SavePointBookEditEventSelectOrigin>(_onSelectOrigin,transformer: restartable());
  }

  void _onDataRequest(SavePointBookEditEventRequest event,Emitter<SavePointEditBookState>emit)async{
    _filterController.add(event.filter);
    emit(state.copyWith(selectedOriginTag: event.filter,setOriginTag: true));

    final streamData = _filterController.switchMap((OriginTag? filter){
      if(filter!=null){
        return _savePointRepo.getStreamSavePointsWithBookFilter(event.bookScopes, filter.savePointId);
      }else{
        return _savePointRepo.getStreamSavePointsWithBook(event.bookScopes);
      }
    });

    await emit.forEach<List<SavePoint>>(streamData, onData: (data){
      return state.copyWith(savePoints: data);
    });

  }

  void _onSelectSavePoint(SavePointBookEditEventSelectSavePoint event,Emitter<SavePointEditBookState>emit)async{
    emit(state.copyWith(selectedSavePoint: event.savePoint,setSavePoint: true));
  }

  void _onSelectOrigin(SavePointBookEditEventSelectOrigin event,Emitter<SavePointEditBookState>emit)async{
    _filterController.add(event.originTag);
    emit(state.copyWith(selectedOriginTag: event.originTag,setOriginTag: true));
  }

  @override
  Future<void> close() async{
    await _filterController.close();
    return super.close();
  }

}