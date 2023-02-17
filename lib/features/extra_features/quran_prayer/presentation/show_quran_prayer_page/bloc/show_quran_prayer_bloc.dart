

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/features/extra_features/quran_prayer/domain/repo/quran_prayer_repo.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'show_quran_prayer_event.dart';
import 'show_quran_prayer_state.dart';

class ShowQuranPrayerBloc extends Bloc<IShowQuranPrayerEvent,ShowQuranPrayerState>{

  late final QuranPrayerRepo _prayerRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  ShowQuranPrayerBloc({required QuranPrayerRepo prayerRepo}) : super(ShowQuranPrayerState.init()){
    _prayerRepo = prayerRepo;

    on<ShowQuranPrayerEventInit>(_onInit);
    on<ShowQuranPrayerEventSetUi>(_onSetUi);

    add(ShowQuranPrayerEventInit());
  }

  void _onInit(ShowQuranPrayerEventInit event,Emitter<ShowQuranPrayerState>emit)async{
    final verseUiIndex = _sharedPreferences.getInt(PrefConstants.quranPrayerVerseUi.key)??
        PrefConstants.quranPrayerVerseUi.defaultValue;
    final verseUi = ArabicVerseUI2X.values[verseUiIndex];

    emit(state.copyWith(isLoading: true,verseUi: verseUi));
    final items = await _prayerRepo.getQuranPrayers();
    emit(state.copyWith(items: items,isLoading: false));

    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize,
        onData: (data)=>state.copyWith(fontSize: data));

  }

  void _onSetUi(ShowQuranPrayerEventSetUi event,Emitter<ShowQuranPrayerState>emit)async{
    emit(state.copyWith(verseUi: event.verseUIEnum));
  }

}