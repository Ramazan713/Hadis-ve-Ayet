

import 'i_key.dart';

class PrefKey<T> extends IKey{
  @override
  final String key;
  final T defaultValue;

  PrefKey({required this.key, required this.defaultValue});
}