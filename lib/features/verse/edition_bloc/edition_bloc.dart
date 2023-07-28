

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/repos/audio_edition_repo.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/features/verse/edition_bloc/edition_event.dart';
import 'package:hadith/features/verse/edition_bloc/edition_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/util/edition_util.dart';
import 'package:hadith/models/resource.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import '../../../constants/preference_constants.dart';

class EditionBloc extends Bloc<IEditionEvent,EditionState>{
  final AudioEditionRepoOld editionRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  final _audioQualityController = BehaviorSubject<AudioQualityEnum>();

  EditionBloc({required this.editionRepo}) : super(EditionState.init()){
    on<EditionEventInit>(_onInit);
    on<EditionEventInitAudioQuality>(_onInitQualityAudio);
    on<EditionEventSetInit>(_onSetInit,transformer: restartable());
    on<EditionEventRefreshData>(_onRefreshData,transformer: restartable());
    on<EditionEventSetSelected>(_onSetSelected,transformer: restartable());
    on<EditionEventSetQuality>(_onSetQuality,transformer: restartable());
    on<EditionEventSave>(_onSave,transformer: restartable());
    on<EditionEventReset>(_onReset,transformer: restartable());

    add(EditionEventInit());
    add(EditionEventInitAudioQuality());
  }

  void _onInit(EditionEventInit event,Emitter<EditionState>emit)async{
    await emit.forEach<List<AudioEdition>>(editionRepo.getStreamEditions(), onData: (data){
      return state.copyWith(items: data);
    });
  }
  void _onInitQualityAudio(EditionEventInitAudioQuality event,Emitter<EditionState>emit)async{
    await emit.forEach<AudioQualityEnum>(_audioQualityController.stream, onData: (filter){
      return state.copyWith(filteredItems: EditionUtil.filterEditions(state.items, filter));
    });
  }

  void _onSetInit(EditionEventSetInit event,Emitter<EditionState>emit)async{
    add(EditionEventRefreshData());

    final audioQuality = _sharedPreferences.getInt(PrefConstants.audioQuality.key)??PrefConstants.audioQuality.defaultValue;
    final audioQualityEnum = AudioQualityExt.fromQuality(audioQuality);
    _audioQualityController.value = audioQualityEnum;

    emit(state.copyWith(initAudioQuality: audioQualityEnum, lastAudioQuality: audioQualityEnum));
  }

  void _onRefreshData(EditionEventRefreshData event,Emitter<EditionState>emit)async{

    emit(state.copyWith(isLoading: true));
    final editionResponse = await editionRepo.refreshEditions(event.forceRemote);

    if(editionResponse is ResourceSuccess<List<AudioEdition>>){
      final items = editionResponse.data;
      final filteredItems = EditionUtil.filterEditions(items,
          _audioQualityController.value);
      final selectedEdition = items.firstWhereOrNull((element) => element.isSelected);
      emit(state.copyWith(initSelectedEdition: selectedEdition,
          lastSelectedEdition: selectedEdition,setLastEdition: true,setInitEdition: true,
          filteredItems: filteredItems,items:items,isLoading:false
      ));
    }
    else if(editionResponse is ResourceError<List<AudioEdition>>){
      _addMessage(editionResponse.error, emit);
    }
  }


  void _onSetSelected(EditionEventSetSelected event,Emitter<EditionState>emit)async{
    emit(state.copyWith(
        lastSelectedEdition: state.items.firstWhere((element) => element.identifier == event.identifier),
        saveButtonEnabled: true,resetButtonEnabled: true,setLastEdition: true,
    ));
  }

  void _onSetQuality(EditionEventSetQuality event,Emitter<EditionState>emit)async{
    _audioQualityController.value = event.audioQuality;
    emit(state.copyWith(lastAudioQuality: event.audioQuality,saveButtonEnabled: true,
        resetButtonEnabled: true));
  }

  void _onReset(EditionEventReset event,Emitter<EditionState>emit)async{
    emit(state.copyWith(
      resetButtonEnabled: false,saveButtonEnabled: false,
      lastSelectedEdition: state.initSelectedEdition, setLastEdition: true,
      lastAudioQuality: state.initAudioQuality
    ));
    _audioQualityController.value = state.initAudioQuality;
  }

  void _onSave(EditionEventSave event,Emitter<EditionState>emit)async{
    final selectedEdition = state.lastSelectedEdition;
    final lastQuality = state.lastAudioQuality;
    if(selectedEdition==null){
      _addMessage("bir şeyler yanlış gitti", emit);
      return;
    }
    final isEditionInQuality = EditionUtil.isEditionInQuality(selectedEdition, lastQuality);
    if(!isEditionInQuality){
      _addMessage("seçilmiş herhangi bir kıraat bulunamadı", emit);
      return;
    }
    await _sharedPreferences.setInt(PrefConstants.audioQuality.key, state.lastAudioQuality.quality);

    final newItems = state.items.map((e){
      return e.copyWith(isSelected: e.identifier == selectedEdition.identifier);}).toList();
    await editionRepo.updateAudioEditions(newItems);
    emit(state.copyWith(
      items: newItems,
      initSelectedEdition: selectedEdition,setInitEdition: true,
      initAudioQuality: lastQuality,
      saveButtonEnabled: false,resetButtonEnabled: false,
    ));
    _addMessage("Başarıyla Kaydedildi", emit);
  }

  void _addMessage(String message,Emitter<EditionState>emit){
    emit(state.copyWith(message: message,setMessage: true,isLoading: false));
    emit(state.copyWith(setMessage: true));
  }

  @override
  Future<void> close() async{
    await _audioQualityController.close();
    return super.close();
  }

}