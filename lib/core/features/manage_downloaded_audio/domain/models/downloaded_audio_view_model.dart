

import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/enums/downloaded_audio_view_enum.dart';

class DownloadedAudioViewModel extends Equatable{
  final String editionName;
  final String identifier;
  final int itemId;
  final bool isDownloaded;
  final String itemName;
  final DownloadedAudioViewEnum audioEnum;

  const DownloadedAudioViewModel({
    required this.editionName,
    required this.identifier,
    required this.itemId,
    required this.itemName,
    required this.isDownloaded,
    required this.audioEnum,
  });

  String get title{
    switch(audioEnum){
      case DownloadedAudioViewEnum.cuz:
        return itemName;
      case DownloadedAudioViewEnum.surah:
        return "$itemId $itemName";
      case DownloadedAudioViewEnum.page:
        return "$itemName. Sayfa";
    }
  }

  @override
  List<Object?> get props => [editionName, identifier, itemId, isDownloaded, itemName, audioEnum];
}