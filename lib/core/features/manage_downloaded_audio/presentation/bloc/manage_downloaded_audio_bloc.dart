import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/models/downloaded_audio_view_model.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/repo/downloaded_audio_view_repo.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/bloc/manage_downloaded_audio_state.dart';
import 'package:rxdart/rxdart.dart';

class ManageAudioBloc extends Bloc<IManageAudioEvent,ManageAudioState>{
  late final DownloadedAudioViewRepo _audioViewRepo;

  final BehaviorSubject<DownloadedAudioViewEnum> _audioViewEnumController = BehaviorSubject();
  final BehaviorSubject<String?> _identifierController = BehaviorSubject();

  ManageAudioBloc({
    required DownloadedAudioViewRepo audioViewRepo
  }) : super(ManageAudioState.init()){

    _audioViewRepo = audioViewRepo;

    on<ManageAudioEventInitListener>(_onInitListener,transformer: restartable());
    on<ManageAudioEventLoadData>(_onLoadData,transformer: restartable());
    on<ManageAudioEventClearMessage>(_onClearMessage,transformer: restartable());
    on<ManageAudioEventChangeAudioViewType>(_onChangeAudioViewType,transformer: restartable());
    on<ManageAudioEventDelete>(_onDelete,transformer: restartable());
    on<ManageAudioEventSetIdentifier>(_onSetIdentifier,transformer: restartable());

    add(ManageAudioEventInitListener());

  }


  void _onLoadData(ManageAudioEventLoadData event,Emitter<ManageAudioState>emit) async{
    const audioView = DownloadedAudioViewEnum.surah;
    _audioViewEnumController.value = audioView;
    _identifierController.value = event.identifier;

    emit(state.copyWith(
      setSelectedEnum: true,
      selectedEnum: audioView,
      setSelectedIdentifier: true,
      selectedIdentifier: event.identifier
    ));
  }

  void _onInitListener(ManageAudioEventInitListener event,Emitter<ManageAudioState>emit) async{
    final streamData = Rx.combineLatest2(_audioViewEnumController.stream, _identifierController.stream, (viewEnum, identifier){
      return _Filter(audioView: viewEnum, identifier: identifier);
    }).switchMap((filter){
      return _audioViewRepo.getStreamModels(identifier: filter.identifier, audioEnumView: filter.audioView);
    });

    await emit.forEach<List<DownloadedAudioViewModel>>(streamData, onData: (data){
      return state.copyWith(models: data);
    });
  }


  void _onChangeAudioViewType(ManageAudioEventChangeAudioViewType event,Emitter<ManageAudioState>emit)async{
    _audioViewEnumController.value = event.audioViewEnum;
    emit(state.copyWith(
      setSelectedEnum: true,
      selectedEnum: event.audioViewEnum
    ));
  }

  void _onDelete(ManageAudioEventDelete event,Emitter<ManageAudioState>emit)async{
    await _audioViewRepo.deleteAudios(event.model);
    emit(state.copyWith(
      setMessage: true,
      message: "Başarıyla silindi"
    ));
  }

  void _onSetIdentifier(ManageAudioEventSetIdentifier event,Emitter<ManageAudioState>emit)async{
    _identifierController.add(event.identifier);
    emit(state.copyWith(
        setSelectedIdentifier: true,
        selectedIdentifier: event.identifier
    ));
  }

  void _onClearMessage(ManageAudioEventClearMessage event,Emitter<ManageAudioState>emit){
    emit(state.copyWith(setMessage: true));
  }

  @override
  Future<void> close() async{
    await _audioViewEnumController.close();
    await _identifierController.close();
    return super.close();
  }
}



class _Filter extends Equatable{
  final DownloadedAudioViewEnum audioView;
  final String? identifier;

  const _Filter({required this.audioView, required this.identifier});

  @override
  List<Object?> get props => [audioView, identifier];
}