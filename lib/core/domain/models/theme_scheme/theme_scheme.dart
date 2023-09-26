

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'theme_scheme.freezed.dart';

@freezed
class ThemeScheme with _$ThemeScheme{
  const factory ThemeScheme({
    required ColorScheme currentScheme,
    required ColorScheme lightScheme,
    required ColorScheme darkScheme
  }) = _ThemeScheme;
}