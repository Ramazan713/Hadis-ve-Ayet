
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/domain/repo/topic_save_point_repo.dart';
import 'package:hadith/core/domain/use_cases/topic_save_point/topic_save_point_use_cases.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/domain/repo/topic_view_repo.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'surah_event.dart';
import 'surah_state.dart';


class SurahBloc extends Bloc<ISurahEvent, SurahState>{


  final BehaviorSubject<String> _queryFilter = BehaviorSubject();

  late final SurahRepo _surahRepo;

  Timer? _timer;

  SurahBloc({
    required SurahRepo surahRepo,
  }):super(SurahState.init()){

    _surahRepo = surahRepo;

    on<SurahEventSetSearchBarVisibility>(_onSearchBarVisible, transformer: restartable());
    on<SurahEventSearch>(_onSearch, transformer: restartable());
    on<SurahEventLoadData>(_onLoadData, transformer: restartable());

    add(SurahEventLoadData());
  }

  void _onSearchBarVisible(SurahEventSetSearchBarVisibility event, Emitter<SurahState> emit){
    emit(state.copyWith(searchBarVisible: event.isSearchBarVisible));
  }

  void _onSearch(SurahEventSearch event, Emitter<SurahState> emit){
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: kTimerDelaySearchMilliSecond), () async{
      _queryFilter.add(event.query);
    });
  }


  void _onLoadData(SurahEventLoadData event, Emitter<SurahState> emit) async{

    _queryFilter.add("");

    emit(state.copyWith(isLoading: true, items: []));

    final streamData = _queryFilter.asyncMap((query)async{
      if(query.trim().isEmpty){
        return await _surahRepo.getAllSurah();
      }
      return await _surahRepo.getSurahesWithQuery(query);
    });

    await emit.forEach<List<Surah>>(streamData, onData: (items){
      return state.copyWith(items: items,isLoading: false);
    });
  }
}