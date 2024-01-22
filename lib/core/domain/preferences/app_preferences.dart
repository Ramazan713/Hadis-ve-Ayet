import 'package:hadith/core/domain/preferences/model/i_key.dart';
import 'package:rxdart/rxdart.dart';

import 'model/i_pref_enum.dart';
import 'model/pref_key.dart';
import 'model/pref_key_enum.dart';

abstract class AppPreferences{

  ValueStream<IKey> get listener;

  ValueStream<IKey> listenerFiltered(List<IKey> filter,{IKey? initValue});

  Future<void> setItem<T>(PrefKey<T> item, T value);

  T getItem<T>(PrefKey<T> item);

  Future<void> setEnumItem<T extends IPrefEnum>(PrefKeyEnum<T> item, T prefEnum);

  T getEnumItem<T extends IPrefEnum>(PrefKeyEnum<T> item);

  Map<String,dynamic> toJson();

  Future<void> fromJson(Map<String,dynamic> map);

  Future<void> fromJsonListLegacy(List sharedJsonArr);


  Future<void> clear();


}

