


import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_event.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_state.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_repo.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';


class ManageAudioBlocOld extends Bloc<IManageAudioEventOld,ManageAudioStateOld>{
  late final ManageAudioRepo _manageAudioRepo;
  final StreamController<AudioManageEnum> _manageEnumController = StreamController();
  final BehaviorSubject<String> _identifierController = BehaviorSubject();

  ManageAudioBlocOld({required ManageAudioRepo manageAudioRepo}) : super(ManageAudioStateOld.init()){
    _manageAudioRepo = manageAudioRepo;

    _manageEnumController.add(state.manageEnum);

    on<ManageAudioEventInit>(_onInit,transformer: restartable());
    on<ManageAudioEventChangeType>(_onChangeType,transformer: restartable());
    on<ManageAudioEventDelete>(_onDelete,transformer: restartable());
    on<ManageAudioEventSetIdentifier>(_onSetIdentifier,transformer: restartable());

    add(ManageAudioEventInit());

  }

  void _onInit(ManageAudioEventInit event,Emitter<ManageAudioStateOld>emit)async{
    final cuzModelsStream = _identifierController.switchMap((identifier) => _manageAudioRepo.getCuzAudioManageModels(identifier));
    final surahModelsStream = _identifierController.switchMap((identifier) => _manageAudioRepo.getSurahAudioManageModels(identifier));

    final streamData = Rx.combineLatest3<AudioManageEnum,List<ManageAudioModel>,List<ManageAudioModel>,List<ManageAudioModel>>(
        _manageEnumController.stream,cuzModelsStream,surahModelsStream,
            (manageEnum, cuzModels,surahModels){
          if(manageEnum == AudioManageEnum.cuz){
            return cuzModels;
          }
          return surahModels;
        }
    );
    await emit.forEach<List<ManageAudioModel>>(streamData, onData: (data){
      return state.copyWith(manageModels: data);
    });
  }


  void _onChangeType(ManageAudioEventChangeType event,Emitter<ManageAudioStateOld>emit)async{
    _manageEnumController.add(event.manageEnum);
    emit(state.copyWith(manageEnum: event.manageEnum));
  }

  void _onDelete(ManageAudioEventDelete event,Emitter<ManageAudioStateOld>emit)async{
    await _manageAudioRepo.deleteAudios(event.manageModel);
  }

  void _onSetIdentifier(ManageAudioEventSetIdentifier event,Emitter<ManageAudioStateOld>emit)async{
    _identifierController.add(event.identifier);
  }

  @override
  Future<void> close() async{
    await _manageEnumController.close();
    await _identifierController.close();
    return super.close();
  }
}