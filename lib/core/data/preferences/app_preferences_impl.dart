
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/domain/preferences/model/i_key.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';
import 'package:hadith/core/domain/preferences/model/pref_key.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/preferences/app_preferences.dart';
import 'package:rxdart/rxdart.dart';


class AppPreferencesImpl extends AppPreferences{

  late final SharedPreferences _preferences;
  late final BehaviorSubject<IKey> _listener = BehaviorSubject<IKey>();

  AppPreferencesImpl({required SharedPreferences preferences}){
    _preferences = preferences;
  }

  @override
  ValueStream<IKey> get listener => _listener.shareValue();

  @override
  ValueStream<IKey> listenerFiltered(List<IKey> filter,{IKey? initValue}) {
    if(initValue != null){
      _listener.value = initValue;
    }
    return _listener.where((event)=>filter.contains(event)).shareValue();
  }


  @override
  Future<void> setItem<T>(PrefKey<T> item, T value)async{
    final prevValue = getItem(item);

    if(T == String){
      await _preferences.setString(item.key, value as String);
    }else if(T == int){
      await _preferences.setInt(item.key, value as int);
    }else if(T == bool){
      await _preferences.setBool(item.key, value as bool);
    }else if(T == double){
      await _preferences.setDouble(item.key, value as double);
    }else if(T == List<String>){
      await _preferences.setStringList(item.key, value as List<String>);
    }

    if(prevValue!=value){
      _listener.value = item;
    }
  }

  @override
  T getItem<T>(PrefKey<T> item){
    if(T == String){
      return _preferences.getString(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(T == int){
      return _preferences.getInt(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(T == bool){
      return _preferences.getBool(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(T == double){
      return _preferences.getDouble(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(T == List<String>){
      return _preferences.getStringList(item.key).castOrNull<T>() ?? item.defaultValue;
    }
    return item.defaultValue;
  }

  @override
  Future<void> setEnumItem<T extends IPrefEnum>(PrefKeyEnum<T> item, T prefEnum)async{
    final prevValue = getEnumItem(item);
    await _preferences.setInt(item.key, prefEnum.enumValue);

    if(prevValue!=prefEnum){
      _listener.value = item;
    }
  }

  @override
  T getEnumItem<T extends IPrefEnum>(PrefKeyEnum<T> item){
    final value = _preferences.getInt(item.key) ?? item.defaultPrefEnum.enumValue;
    return item.from(value);
  }

  @override
  Future<void> clear()async{
    await _preferences.clear();
  }
}





