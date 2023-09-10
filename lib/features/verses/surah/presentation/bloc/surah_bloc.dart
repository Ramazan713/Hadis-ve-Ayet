
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/verse_topic_get_downloaded_models_use_case.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'surah_event.dart';
import 'surah_state.dart';


class SurahBloc extends Bloc<ISurahEvent, SurahState>{

  final BehaviorSubject<String> _queryFilter = BehaviorSubject();

  late final SurahRepo _surahRepo;
  late final VerseTopicGetDownloadedModelsUseCase _getItemsUseCases;

  SurahBloc({
    required SurahRepo surahRepo,
    required VerseTopicGetDownloadedModelsUseCase getItemsUseCases,
  }):super(SurahState.init()){

    _surahRepo = surahRepo;
    _getItemsUseCases = getItemsUseCases;

    on<SurahEventSetSearchBarVisibility>(_onSearchBarVisible, transformer: restartable());
    on<SurahEventSearch>(_onSearch, transformer: restartable());
    on<SurahEventLoadData>(_onLoadData, transformer: restartable());

    add(SurahEventLoadData());
  }

  void _onSearchBarVisible(SurahEventSetSearchBarVisibility event, Emitter<SurahState> emit){
    emit(state.copyWith(searchBarVisible: event.isSearchBarVisible));
  }

  void _onSearch(SurahEventSearch event, Emitter<SurahState> emit){
    EasyDebounce.debounce("surah_search", const Duration(milliseconds: K.searchDelaySearchMilliSecond), () {
      _queryFilter.add(event.query);
    });
  }

  void _onLoadData(SurahEventLoadData event, Emitter<SurahState> emit) async{

    _queryFilter.add("");

    emit(state.copyWith(isLoading: true, items: []));

    final surahStream = _queryFilter.distinct().asyncMap((query)async{
      if(query.trim().isEmpty){
        return await _surahRepo.getAllSurah();
      }
      return await _surahRepo.getSurahesWithQuery(query);
    });

    final streamData = _getItemsUseCases.call<Surah>(
        dataSource: surahStream,
        selectKey: (data) => data.id ,
        viewEnum: DownloadedAudioViewEnum.surah
    );

    await emit.forEach<List<VerseTopicModel<Surah>>>(streamData, onData: (items){
      return state.copyWith(items: items,isLoading: false);
    });
  }
}