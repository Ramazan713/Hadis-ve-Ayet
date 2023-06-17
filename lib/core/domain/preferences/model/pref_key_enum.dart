

import 'package:hadith/core/domain/preferences/model/i_key.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

class PrefKeyEnum<T extends IPrefEnum> extends IKey{

  @override
  final String key;
  final T defaultPrefEnum;

  final T Function(int) from;

  PrefKeyEnum({required this.key, required this.defaultPrefEnum, required this.from});
}