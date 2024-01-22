
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';
import 'package:json_annotation/json_annotation.dart';

enum AudioQualityEnum with IPrefEnum, IMenuItem{
  q32(
    enumValue: 32
  ),
  q48(
    enumValue: 48
  ),
  q64(
    enumValue: 64
  ),
  q128(
    enumValue: 128
  ),
  q192(
    enumValue: 192
  );

  const AudioQualityEnum({required this.enumValue});

  @override
  final int enumValue;

  int get quality => enumValue;

  @override
  String get title => "Bitrate: $quality";

  @override
  IconInfo? get iconInfo => null;

  static AudioQualityEnum get defaultValue => AudioQualityEnum.q64;

  static AudioQualityEnum from(int quality){
    switch(quality){
      case 32:
        return AudioQualityEnum.q32;
      case 48:
        return AudioQualityEnum.q48;
      case 64:
        return AudioQualityEnum.q64;
      case 128:
        return AudioQualityEnum.q128;
      case 192:
        return AudioQualityEnum.q192;
    }
    return AudioQualityEnum.q64;
  }
}