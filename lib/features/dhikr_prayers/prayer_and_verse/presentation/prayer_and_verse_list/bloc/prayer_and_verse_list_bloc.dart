import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

import 'prayer_and_verse_list_event.dart';
import 'prayer_and_verse_list_state.dart';

class PrayerAndVerseListBloc extends Bloc<IPrayerAndVerseListEvent,PrayerAndVerseListState>{


  late final PrayerRepo _prayerRepo;

  PrayerAndVerseListBloc({
    required PrayerRepo prayerRepo
  }): super(PrayerAndVerseListState.init()){

    _prayerRepo = prayerRepo;

    on<PrayerAndVerseListEventLoadData>(_onLoadData,transformer: restartable());

    add(PrayerAndVerseListEventLoadData());
  }

  void _onLoadData(PrayerAndVerseListEventLoadData event,Emitter<PrayerAndVerseListState>emit)async{
    emit(state.copyWith(isLoading: true));
    final items = await _prayerRepo.getPrayerAndVerses();
    emit(state.copyWith(
      isLoading: false,
      items: items
    ));
  }

  // void _on(,Emitter<PrayerAndVerseListState>emit)async{
  //
  // }

}