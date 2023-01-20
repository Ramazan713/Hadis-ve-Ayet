

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/entities/user_info_entity.dart';
import 'package:hadith/db/repos/user_info_repo.dart';
import 'package:hadith/features/settings/bloc/setting_event.dart';
import 'package:hadith/features/settings/bloc/setting_state.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:hadith/utils/search_helper.dart';
import 'package:hadith/utils/theme_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<ISettingEvent,SettingState>{
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;
  late final UserInfoRepo _userInfoRepo;

  final BehaviorSubject<String?> _userIdController = BehaviorSubject();

  SettingBloc({required UserInfoRepo userInfoRepo}) : super(SettingState.init()){
    _userInfoRepo = userInfoRepo;

    on<SettingEventInit>(_onInit);
    on<SettingEventSetSearchCriteria>(_onSetSearchCriteria,transformer: restartable());
    on<SettingEventSetFontText>(_onSetFontText,transformer: restartable());
    on<SettingEventSetArabicUI>(_onSetArabicUI,transformer: restartable());
    on<SettingEventSetArchiveAsList>(_onSetArchiveAsList,transformer: restartable());
    on<SettingEventSetShowListIcons>(_onSetShowListIcons,transformer: restartable());
    on<SettingEventResetSettings>(_onResetSettings,transformer: restartable());
    on<SettingEventRequestUserInfo>(_onRequestUserInfo,transformer: restartable());

    add(SettingEventInit());
  }

  void _onInit(SettingEventInit event,Emitter<SettingState>emit)async{
    final searchCriteria = SearchHelper.getCriteria();
    final arabicUI = ArabicVerseUIEnum.values[_sharedPreferences.getInt(PrefConstants.arabicVerseAppearanceEnum.key) ??
        PrefConstants.arabicVerseAppearanceEnum.defaultValue];
    final fontText = FontSize.values[_sharedPreferences.getInt(PrefConstants.fontSize.key) ??
        PrefConstants.fontSize.defaultValue].shortName;
    final showVerseListIcons =  _sharedPreferences.getBool(PrefConstants.showVerseListIcons.key) ??
    PrefConstants.showVerseListIcons.defaultValue;
    final useArchiveAsList = _sharedPreferences.getBool(PrefConstants.useArchiveListFeatures.key) ??
        PrefConstants.useArchiveListFeatures.defaultValue;

    emit(state.copyWith(showSelectedListVerseIcons: showVerseListIcons,fontText: fontText,arabicVerseUI: arabicUI,
      searchCriteria: searchCriteria,useArchiveAsSelectList: useArchiveAsList));

    final Stream<UserInfoEntity?> userInfoStream = _userIdController.switchMap<UserInfoEntity?>((userId){
      if(userId!=null){
        return _userInfoRepo.getStreamUserInfoWithId(userId);
      }
      return Stream.value(null);
    });
    final packageInfo = await PackageInfo.fromPlatform();

    emit(state.copyWith(packageInfo: packageInfo.packageName));

    await emit.forEach<UserInfoEntity?>(userInfoStream, onData: (userInfo){
      return state.copyWith(userInfoEntity: userInfo,setUserInfo: true);
    });

  }


  void _onSetSearchCriteria(SettingEventSetSearchCriteria event,Emitter<SettingState>emit)async{
    await _sharedPreferences.setInt(PrefConstants.searchCriteriaEnum.key, event.searchCriteria.index);
    emit(state.copyWith(searchCriteria: event.searchCriteria));
  }
  void _onSetFontText(SettingEventSetFontText event,Emitter<SettingState>emit)async{
    emit(state.copyWith(fontText: event.fontText));
  }
  void _onSetArabicUI(SettingEventSetArabicUI event,Emitter<SettingState>emit)async{
    emit(state.copyWith(arabicVerseUI: event.arabicVerseUI));
  }
  void _onSetArchiveAsList(SettingEventSetArchiveAsList event,Emitter<SettingState>emit)async{
    await _sharedPreferences.setBool(PrefConstants.useArchiveListFeatures.key, event.archiveAsList);
    emit(state.copyWith(useArchiveAsSelectList: event.archiveAsList));
  }

  void _onSetShowListIcons(SettingEventSetShowListIcons event,Emitter<SettingState>emit)async{
    await _sharedPreferences.setBool(PrefConstants.showVerseListIcons.key,event.showListIcons);
    emit(state.copyWith(showSelectedListVerseIcons: event.showListIcons));
  }

  void _onResetSettings(SettingEventResetSettings event,Emitter<SettingState>emit)async{
    await PrefConstants.setDefaultValues();
    add(SettingEventInit());
  }

  void _onRequestUserInfo(SettingEventRequestUserInfo event,Emitter<SettingState>emit)async{
    _userIdController.add(event.userId);
  }

  @override
  Future<void> close() async{
    await _userIdController.close();
    return super.close();
  }

}