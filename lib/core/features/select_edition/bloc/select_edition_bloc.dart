

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/utils/edition_util.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

import 'select_edition_event.dart';
import 'select_edition_state.dart';

class SelectEditionBloc extends Bloc<ISelectEditionEvent,SelectEditionState>{

  late final AppPreferences _appPreferences;
  late final EditionRepo _editionRepo;

  final _audioQualityController = BehaviorSubject<AudioQualityEnum>();

  SelectEditionBloc({
    required EditionRepo editionRepo,
    required AppPreferences appPreferences
  }) : super(SelectEditionState.init()){

    _editionRepo = editionRepo;
    _appPreferences = appPreferences;

    on<EditionEventInitListener>(_onInitListener);
    on<EditionEventSelectedEditionListener>(_onSelectedEditionListener);
    on<EditionEventLoadInit>(_onLoadInit,transformer: restartable());
    on<EditionEventSetEdition>(_onSetEdition,transformer: restartable());
    on<EditionEventSetQuality>(_onSetQuality,transformer: restartable());
    on<EditionEventSave>(_onSave,transformer: restartable());
    on<EditionEventResetChanges>(_onResetChanges,transformer: restartable());
    on<EditionEventClearMessage>(_onClearMessage,transformer: restartable());

    add(EditionEventInitListener());
    add(EditionEventSelectedEditionListener());
  }

  void _onSelectedEditionListener(EditionEventSelectedEditionListener event,Emitter<SelectEditionState>emit)async{
    final streamData = _editionRepo.getSelectedStreamEdition();

    await emit.forEach<AudioEdition?>(streamData, onData: (data){
      return state.copyWith(
        selectedEdition: data
      );
    });
  }

  void _onLoadInit(EditionEventLoadInit event,Emitter<SelectEditionState>emit)async {
    emit(state.copyWith(isLoading: true));
    final quality = _appPreferences.getEnumItem(KPref.audioQualityEnum);
    _audioQualityController.value = quality;

    final selectedEditionResult = await _editionRepo.getSelectedEdition();

    selectedEditionResult.handle(
      onSuccess: (selectedEdition){
        emit(state.copyWith(
          isLoading: false,
          selectedEdition: selectedEdition,
          lastSavedEdition: selectedEdition,
          selectedQuality: quality,
          lastSavedQuality: quality,
        ));
      },
      onError: (error){
        emit(state.copyWith(message: error, isLoading: false));
      }
    );
  }

  void _onInitListener(EditionEventInitListener event,Emitter<SelectEditionState>emit)async{

    emit(state.copyWith(isLoading: true));
    final editionResult = await _editionRepo.getEditions();

    editionResult.handle(
      onSuccess: (selectedEdition){
        emit(state.copyWith(isLoading: false,));
      },
      onError: (error){
        emit(state.copyWith(message: error, isLoading: false));
      }
    );

    final streamData = Rx.combineLatest2(_editionRepo.getStreamEditions(), _audioQualityController,
            (editions, quality){
      return EditionUtil.filterEditions(editions, quality);
    });

    await emit.forEach<List<AudioEdition>>(streamData,onData: (data){
      return state.copyWith(items: data);
    });
  }


  void _onSetEdition(EditionEventSetEdition event,Emitter<SelectEditionState>emit) async{
    emit(state.copyWith(
        selectedEdition: event.edition,
    ));
  }

  void _onSetQuality(EditionEventSetQuality event,Emitter<SelectEditionState>emit)async{
    _audioQualityController.value = event.audioQuality;
    emit(state.copyWith(
      selectedQuality: event.audioQuality,
    ));
  }

  void _onResetChanges(EditionEventResetChanges event,Emitter<SelectEditionState>emit) async{
    final quality = _appPreferences.getEnumItem(KPref.audioQualityEnum);
    final selectedEditionResult = await _editionRepo.getSelectedEdition();

    selectedEditionResult.handle(
      onSuccess: (selectedEdition){
        _audioQualityController.value = quality;

        emit(state.copyWith(
          lastSavedQuality: quality,
          lastSavedEdition: selectedEdition,
          selectedEdition: selectedEdition,
          selectedQuality: quality,
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
    final lastQuality = state.selectedQuality;
    if(selectedEdition == null){
      emit(state.copyWith(message: "bir şeyler yanlış gitti"));
      return;
    }
    final isEditionInQuality = EditionUtil.isEditionInQuality(selectedEdition, lastQuality);
    if(!isEditionInQuality){
      emit(state.copyWith(message: "seçilmiş herhangi bir kıraat bulunamadı"));
      return;
    }

    await _appPreferences.setEnumItem(KPref.audioQualityEnum, lastQuality);
    await _editionRepo.setSelectedEdition(selectedEdition.identifier);
    
    emit(state.copyWith(
      message: "Başarıyla Kaydedildi",
      lastSavedEdition: selectedEdition,
      lastSavedQuality: lastQuality,
    ));
  }

  void _onClearMessage(EditionEventClearMessage event,Emitter<SelectEditionState>emit){
    emit(state.copyWith(message: null));
  }


  @override
  Future<void> close() async{
    await _audioQualityController.close();
    return super.close();
  }

}