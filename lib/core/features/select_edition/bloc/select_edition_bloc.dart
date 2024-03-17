

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_event.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_state.dart';
import 'package:hadith/core/features/select_edition/edition_util.dart';
import 'package:hadith/core/features/verse_audio/domain/model/basic_audio_request/basic_audio_request.dart';


class SelectEditionBloc extends Bloc<ISelectEditionEvent,SelectEditionState>{

  late final AppPreferences _appPreferences;
  late final EditionRepo _editionRepo;

  SelectEditionBloc({
    required EditionRepo editionRepo,
    required AppPreferences appPreferences
  }) : super(SelectEditionState.init()){

    _editionRepo = editionRepo;
    _appPreferences = appPreferences;

    on<EditionEventDataListener>(_onDataListener);
    on<EditionEventSelectedEditionListener>(_onSelectedEditionListener);
    on<EditionEventLoadData>(_onLoadData,transformer: restartable());
    on<EditionEventSetEdition>(_onSetEdition,transformer: restartable());
    on<EditionEventSave>(_onSave,transformer: restartable());
    on<EditionEventResetChanges>(_onResetChanges,transformer: restartable());
    on<EditionEventClearMessage>(_onClearMessage,transformer: restartable());
    on<EditionEventSetAudioRequest>(_onSetAudioRequest,transformer: restartable());
    on<EditionEventAddFavorite>(_onAddFavorite,transformer: restartable());
    on<EditionEventDeleteFavorite>(_onDeleteFavorite,transformer: restartable());

    add(EditionEventDataListener());
    add(EditionEventSelectedEditionListener());
  }

  void _onDataListener(EditionEventDataListener event,Emitter<SelectEditionState>emit)async{

    emit(state.copyWith(isLoading: true));
    final editionResult = await _editionRepo.getEditions();

    editionResult.handle(
      onSuccess: (editions){
        emit(state.copyWith(isLoading: false));
      },
      onError: (error){
        emit(state.copyWith(message: error, isLoading: false));
      }
    );

    final streamData = _editionRepo.getStreamEditions();

    await emit.forEach<List<AudioEdition>>(streamData,onData: (data){
      final items = EditionUtil.transformEditions(data, _getFavoriteIdentifiers());
      return state.copyWith(items: items, isLoading: false);
    });
  }

  void _onSelectedEditionListener(EditionEventSelectedEditionListener event,Emitter<SelectEditionState>emit)async{
    final streamData = _editionRepo.getSelectedStreamEdition();

    await emit.forEach<AudioEdition?>(streamData, onData: (data){
      return state.copyWith(
          selectedEdition: EditionUtil.transformEdition(data, _getFavoriteIdentifiers())
      );
    });
  }


  void _onLoadData(EditionEventLoadData event,Emitter<SelectEditionState>emit)async {
    emit(state.copyWith(isLoading: true));

    final selectedEditionResult = await _editionRepo.getSelectedEdition();
    final audioRequest = _getAudioRequest();
    final audioRequestSource = _getAudioRequestSource();

    selectedEditionResult.handle(
      onSuccess: (selectedEdition){
        final selectedItem = EditionUtil.transformEdition(selectedEdition, []);
        emit(state.copyWith(
          isLoading: false,
          selectedEdition: selectedItem,
          lastSavedEdition: selectedItem,
          audioRequest: audioRequest,
          audioRequestSource: audioRequestSource,
        ));
      },
      onError: (error){
        emit(state.copyWith(
          message: error,
          isLoading: false,
          audioRequest: audioRequest,
          audioRequestSource: audioRequestSource,
        ));
      }
    );
  }


  void _onSetEdition(EditionEventSetEdition event,Emitter<SelectEditionState>emit) async{
    emit(state.copyWith(
        selectedEdition: event.edition,
    ));
  }

  void _onSetAudioRequest(EditionEventSetAudioRequest event,Emitter<SelectEditionState>emit) async{
    final surahId = event.result.selectedSurah.id;
    final startVerseId = event.result.firstSelectedVerseNumber.text;
    final endVerseId = event.result.lastSelectedVerseNumber.text;
    final source = event.result.source;
    
    final request = BasicAudioRequest(
      surahId: surahId, 
      startVerseId: startVerseId,
      endVerseId: endVerseId,
    );
    
    await _appPreferences.setItem(KPref.selectEditionAudioSurahId, surahId);
    await _appPreferences.setItem(KPref.selectEditionAudioStartVerseId, startVerseId);
    await _appPreferences.setItem(KPref.selectEditionAudioEndVerseId, endVerseId);
    await _appPreferences.setItem(KPref.selectEditionAudioSource, source);

    emit(state.copyWith(
      audioRequestSource: source,
      audioRequest: request
    ));
  }

  void _onResetChanges(EditionEventResetChanges event,Emitter<SelectEditionState>emit) async{
    final selectedEditionResult = await _editionRepo.getSelectedEdition();

    selectedEditionResult.handle(
      onSuccess: (selectedEdition){
        final selectedItem = EditionUtil.transformEdition(selectedEdition, _getFavoriteIdentifiers());
        emit(state.copyWith(
          lastSavedEdition: selectedItem,
          selectedEdition: selectedItem,
        ));
      },
      onError: (error){
        emit(state.copyWith(
          message: error
        ));
      }
    );
  }

  void _onSave(EditionEventSave event,Emitter<SelectEditionState>emit)async{
    final selectedEdition = state.selectedEdition;
    if(selectedEdition == null){
      emit(state.copyWith(message: "bir şeyler yanlış gitti"));
      return;
    }

    await _editionRepo.setSelectedEdition(selectedEdition.audioEdition.identifier);
    
    emit(state.copyWith(
      message: "Başarıyla Kaydedildi",
      lastSavedEdition: selectedEdition,
    ));
  }


  void _onAddFavorite(EditionEventAddFavorite event,Emitter<SelectEditionState>emit) async{
    final favoriteItems = state.favoriteItems.toList();
    favoriteItems.add(event.edition);
    await _appPreferences.setItem(KPref.favoriteEditionsList, favoriteItems.map((e) => e.audioEdition.identifier).toList());
    emit(state.copyWith(
      items: state.items.map((e){
        if(e.audioEdition.identifier == event.edition.audioEdition.identifier){
          return e.copyWith(isSelected: true);
        }
        return e;
      }).toList()
    ));
  }

  void _onDeleteFavorite(EditionEventDeleteFavorite event,Emitter<SelectEditionState>emit) async{
    final favoriteItems = state.favoriteItems.toSet();
    favoriteItems.remove(event.edition);
    await _appPreferences.setItem(KPref.favoriteEditionsList, favoriteItems.map((e) => e.audioEdition.identifier).toList());
    emit(state.copyWith(
      items: state.items.map((e){
        if(e.audioEdition.identifier == event.edition.audioEdition.identifier){
          return e.copyWith(isSelected: false);
        }
        return e;
      }).toList()
    ));
  }

  void _onClearMessage(EditionEventClearMessage event,Emitter<SelectEditionState>emit){
    emit(state.copyWith(message: null));
  }


  BasicAudioRequest _getAudioRequest(){
    final surahId = _appPreferences.getItem(KPref.selectEditionAudioSurahId);
    final startVerseId = _appPreferences.getItem(KPref.selectEditionAudioStartVerseId);
    final endVerseId = _appPreferences.getItem(KPref.selectEditionAudioEndVerseId);

    return BasicAudioRequest(
      surahId: surahId,
      startVerseId: startVerseId,
      endVerseId: endVerseId,
    );
  }

  String _getAudioRequestSource(){
    return _appPreferences.getItem(KPref.selectEditionAudioSource);
  }


  List<String> _getFavoriteIdentifiers(){
    return _appPreferences.getItem(KPref.favoriteEditionsList);
  }

}