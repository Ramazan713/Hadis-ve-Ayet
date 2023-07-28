import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/verse_topic_get_downloaded_models_use_case.dart';

import 'cuz_event.dart';
import 'cuz_state.dart';

class CuzBloc extends Bloc<ICuzEvent,CuzState>{

  late final CuzRepo _cuzRepo;
  late final VerseTopicGetDownloadedModelsUseCase _getItemsUseCases;

  CuzBloc({
    required CuzRepo cuzRepo,
    required VerseTopicGetDownloadedModelsUseCase getItemsUseCases,
  }) : super(CuzState.init()){

    _cuzRepo = cuzRepo;
    _getItemsUseCases = getItemsUseCases;

    on<CuzEventLoadData>(_onLoadData, transformer: restartable());

    add(CuzEventLoadData());
  }

  void _onLoadData(CuzEventLoadData event,Emitter<CuzState>emit)async{
    final cuzData = await _cuzRepo.getAllCuz();

    final streamData = _getItemsUseCases.call<Cuz>(
        dataSource: Stream.value(cuzData),
        selectKey: (data) => data.no,
        viewEnum: DownloadedAudioViewEnum.cuz
    );

    await emit.forEach(streamData, onData: (data){
      return state.copyWith(
        items: data
      );
    });
  }

}