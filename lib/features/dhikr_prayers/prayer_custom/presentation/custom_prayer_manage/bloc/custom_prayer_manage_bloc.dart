

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';
import 'custom_prayer_manage_event.dart';
import 'custom_prayer_manage_state.dart';

class CustomPrayerManageBloc extends Bloc<ICustomPrayerManageEvent,CustomPrayerManageState>{

  late final PrayerCustomRepo _prayerRepo;

  CustomPrayerManageBloc({
    required PrayerCustomRepo prayerRepo,
  }) : super(CustomPrayerManageState.init()){

    _prayerRepo = prayerRepo;

    on<CustomPrayerManageEventUpdate>(_onUpdate,transformer: droppable());
    on<CustomPrayerManageEventLoadData>(_onLoadData,transformer: droppable());

    on<CustomPrayerManageEventClearNavigateBack>(_onClearNavigateBack,transformer: restartable());
    on<CustomPrayerManageEventClearMessage>(_onClearMessage,transformer: restartable());
  }

  void _onLoadData(CustomPrayerManageEventLoadData event,Emitter<CustomPrayerManageState>emit)async{
    emit(CustomPrayerManageState.init().copyWith(isLoading: true));
    final prayer = await _prayerRepo.getPrayerCustomById(event.prayerId??0);

    emit(state.copyWith(
      isLoading: false,
      currentPrayer: prayer,
    ));
  }

  void _onUpdate(CustomPrayerManageEventUpdate event,Emitter<CustomPrayerManageState>emit)async{
    final currentPrayer = state.currentPrayer;
    final name = event.newName.trim();
    final content = event.newContent?.trim();
    final arabicContent = event.newArabicContent?.trim();
    final meaning = event.newMeaning?.trim();
    final source = event.newSource?.trim();

    if(name.isEmpty){
      return emit(state.copyWith(message: "isim alanı boş geçilemez"));
    }

    final newPrayer = PrayerCustom(
      name: name,
      arabicContent: arabicContent,
      orderItem: currentPrayer?.orderItem ?? 0,
      id: currentPrayer?.id,
      meaningContent: meaning,
      pronunciationContent: content,
      source: source,
      counterId: currentPrayer?.counterId,
      updateCounter: currentPrayer != null
    );

    if(currentPrayer != null){
      await _prayerRepo.updatePrayerCustom(newPrayer);
    }else{
      await _prayerRepo.insertPrayerCustom(newPrayer);
    }

    emit(state.copyWith(
      message: "Başarılı",
      navigateBack: true
    ));
  }

  void _onClearMessage(CustomPrayerManageEventClearMessage event,Emitter<CustomPrayerManageState>emit){
    emit(state.copyWith(message: null));
  }

  void _onClearNavigateBack(CustomPrayerManageEventClearNavigateBack event,Emitter<CustomPrayerManageState>emit){
    emit(state.copyWith(navigateBack: false));
  }

}











