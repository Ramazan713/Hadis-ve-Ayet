

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/repo/prayer_repo.dart';

import 'show_prayer_event.dart';
import 'show_prayer_state.dart';

class ShowPrayerBloc extends Bloc<IShowPrayerEvent,ShowPrayerState>{
  late final PrayerRepo _prayerRepo;

  ShowPrayerBloc({required PrayerRepo prayerRepo}) : super(ShowPrayerState.init()){
    _prayerRepo = prayerRepo;

    on<ShowPrayerEventInit>(_onInit);

    add(ShowPrayerEventInit());
  }

  void _onInit(ShowPrayerEventInit event,Emitter<ShowPrayerState>emit)async{
    emit(state.copyWith(isLoading: true));
    final prayers = await _prayerRepo.getPrayers();
    emit(state.copyWith(prayers: prayers,isLoading: false));
  }

}