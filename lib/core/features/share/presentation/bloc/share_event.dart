
import 'dart:typed_data';

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:url_launcher/url_launcher.dart';
abstract class IShareEvent{}


class ShareEventShareImage extends IShareEvent{
  final ByteData? data;
  final String imageName;
  ShareEventShareImage({required this.data, required this.imageName});
}

class ShareEventShareText extends IShareEvent{
  final String text;
  ShareEventShareText({required this.text});
}

class ShareEventLaunchUrl extends IShareEvent{
  final String url;
  final LaunchMode launchMode;

  ShareEventLaunchUrl({
    required this.url,
    this.launchMode = LaunchMode.externalApplication
  });
}

class ShareEventCopyText extends IShareEvent{
  final String text;
  ShareEventCopyText({required this.text});
}

class ShareEventSharePdf extends IShareEvent{
  final int listId;
  final String listName;
  final SourceTypeEnum sourceType;
  ShareEventSharePdf({required this.listId, required this.sourceType, required this.listName});
}

class ShareEventSharePdfText extends IShareEvent{
  final int listId;
  final SourceTypeEnum sourceType;
  ShareEventSharePdfText({required this.listId, required this.sourceType});
}

class ShareEventSharePrayerCustomJson extends IShareEvent{
  final PrayerCustom prayerCustom;
  ShareEventSharePrayerCustomJson({required this.prayerCustom});
}

class ShareEventClearMessage extends IShareEvent{}

class ShareEventClearShareUiEvent extends IShareEvent{}

class ShareEventClearCompletedLoading extends IShareEvent{}


