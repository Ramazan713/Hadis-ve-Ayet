
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/domain/preferences/model/i_key.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';
import 'package:hadith/core/domain/preferences/model/pref_key.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

import '../../domain/preferences/app_preferences.dart';
import 'package:rxdart/rxdart.dart';


class AppPreferencesImpl extends AppPreferences{

  late final SharedPreferences _preferences;
  late final BehaviorSubject<IKey> _listener = BehaviorSubject<IKey>();

  AppPreferencesImpl({
    required SharedPreferences preferences
  }){
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
    if(item is PrefKey<String>){
      await _preferences.setString(item.key, value as String);
    }else if(item is PrefKey<int>){
      await _preferences.setInt(item.key, value as int);
    }else if(item is PrefKey<bool>){
      await _preferences.setBool(item.key, value as bool);
    }else if(item is PrefKey<double>){
      await _preferences.setDouble(item.key, value as double);
    }else if(item is PrefKey<List<String>>){
      await _preferences.setStringList(item.key, value as List<String>);
    }

    if(prevValue!=value){
      _listener.value = item;
    }
  }

  @override
  T getItem<T>(PrefKey<T> item){
    if(item is PrefKey<String>){
      return _preferences.getString(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(item is PrefKey<int>){
      return _preferences.getInt(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(item is PrefKey<bool>){
      return _preferences.getBool(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(item is PrefKey<double>){
      return _preferences.getDouble(item.key).castOrNull<T>() ?? item.defaultValue;
    }else if(item is PrefKey<List<String>>){
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
  Map<String,dynamic> toJson(){
    final map = <String,dynamic>{};

    for (var element in KPref.prefValues) {
      map[element.key] = {"value": getItem(element),"type": "classic"};
    }

    for (var element in KPref.prefEnumValues) {
      map[element.key] = {"value": getEnumItem(element).enumValue,"type": "enum"};
    }
    return map;
  }

  @override
  Future<void> fromJson(Map<String,dynamic> map) async{
    try{
      for (var key in map.keys) {
        final valueDict = map[key];
        final value = valueDict["value"];
        final type = valueDict["type"] as String?;
        if(value == null || type == null) continue;

        switch(type){
          case "classic":
            final prefKey = KPref.prefValues.firstWhereOrNull((e)=>e.key == key);
            if(prefKey == null) return;
            await setItem(prefKey, value);
            break;
          case "enum":
            final prefKey = KPref.prefEnumValues.firstWhereOrNull((e)=>e.key == key);
            if(prefKey == null) return;
            await setEnumItem(prefKey, prefKey.from(value));
            break;
        }
      }
    }catch(e){}
  }


  @override
  Future<void> clear()async{
    await _preferences.clear();
  }

  @override
  Future<void> fromJsonListLegacy(List sharedJsonArr) async{
    await _reloadSharedPreferences(sharedJsonArr, _preferences);
  }
}




//will be removed later update
Future<void> _reloadSharedPreferences(List sharedJsonArr, SharedPreferences sharedPreferences)async{

  for(var sh in sharedJsonArr){
    final map = json.decode(sh);
    final key=map["key"];
    final value=map["value"];
    final type=map["type"];
    if(value==null) {
      continue;
    }

    switch(type){
      case "int":
        await sharedPreferences.setInt(key, value);
        break;
      case "String":
        await sharedPreferences.setString(key, value);
        break;
      case "bool":
        await sharedPreferences.setBool(key, value);
        break;
      case "double":
        await sharedPreferences.setDouble(key, value);
        break;
      case "List<String>":
        await sharedPreferences.setStringList(key, value);
        break;
    }
  }
}




