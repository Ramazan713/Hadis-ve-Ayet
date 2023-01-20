

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/repos/audio_edition_repo.dart';
import 'package:hadith/features/verse/edition_bloc/edition_event.dart';
import 'package:hadith/features/verse/edition_bloc/edition_state.dart';
import 'package:hadith/models/resource.dart';

class EditionBloc extends Bloc<IEditionEvent,EditionState>{
  final AudioEditionRepo editionRepo;

  EditionBloc({required this.editionRepo}) : super(EditionState.init()){
    on<EditionEventInit>(_onInit,transformer: restartable());
    on<EditionEventRefreshData>(_onRefreshData,transformer: restartable());
    on<EditionEventSetSelected>(_onSetSelected,transformer: restartable());


    add(EditionEventRefreshData());
    add(EditionEventInit());

  }

  void _onInit(EditionEventInit event,Emitter<EditionState>emit)async{
    final editionStream = editionRepo.getStreamEditions();

    await emit.forEach<List<AudioEdition>>(editionStream, onData: (data)=>state.copyWith(items: data,setError: true));
  }

  void _onRefreshData(EditionEventRefreshData event,Emitter<EditionState>emit)async{

    emit(state.copyWith(isLoading: true));
    final editionResponse = await editionRepo.refreshEditions(event.forceRemote);

    if(editionResponse is ResourceSuccess<List<AudioEdition>>){
      emit(state.copyWith(items: editionResponse.data,isLoading: false,setError: true));
    }
    else if(editionResponse is ResourceError<List<AudioEdition>>){
      emit(state.copyWith(isLoading: false,error: editionResponse.error,setError: true));
      emit(state.copyWith(setError: true));
    }
  }


  void _onSetSelected(EditionEventSetSelected event,Emitter<EditionState>emit)async{
    final newItems = state.items.map((e){
      return e.copyWith(isSelected: e.identifier == event.identifier);
    }).toList();
    await editionRepo.updateAudioEditions(newItems);
    emit(state.copyWith(items: newItems));
  }




}