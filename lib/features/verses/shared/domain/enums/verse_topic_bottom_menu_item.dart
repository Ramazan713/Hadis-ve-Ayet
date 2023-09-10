

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/verses/shared/domain/models/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';


enum VerseTopicBottomMenuItem implements IMenuItem{

  startListenAudios(
      title: "Dinlemeye Başla",
      iconInfo: IconInfo(iconData: Icons.audiotrack)
  ),
  stopListenAudios(
      title: "Dinlemeyi Iptal Et",
      iconInfo: IconInfo(iconData: Icons.stop)
  ),
  startDownloadAudios(
      title: "Indir",
      iconInfo: IconInfo(iconData: Icons.download)
  ),
  deleteAudios(
      title: "Indirilen ses dosyalarını sil",
      iconInfo: IconInfo(iconData: Icons.delete_forever)
  ),
  goToLastSavePoint(
      title: "Git (son kayıt noktası)",
      iconInfo: IconInfo(iconData: Icons.login)
  ),
  signSavePoint(
      title: "İşaretle",
      iconInfo: IconInfo(iconData: Icons.save_outlined)
  ),
  unSignSavePoint(
      title: "İşareti Kaldır",
      iconInfo: IconInfo(iconData: Icons.save_outlined)
  );

  const VerseTopicBottomMenuItem({required this.title,this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

  static List<VerseTopicBottomMenuItem> getMenuItems({
    required bool hasSavePoint,
    required VerseTopicModel topicModel,
    required AudioInfoResultModel audioInfo,
    required int itemId
  }){

    final savePointItem = hasSavePoint ? unSignSavePoint : signSavePoint;
    final listenItem = audioInfo.listeningItem == itemId ?
    stopListenAudios: startListenAudios;

    VerseTopicBottomMenuItem? downloadItem;

    if(topicModel.audioViewModel?.isDownloaded == true){
      downloadItem = deleteAudios;
    }else if(audioInfo.downloadingItem != itemId && !audioInfo.downloadingQueueItems.contains(itemId)){
      downloadItem = startDownloadAudios;
    }

    final result = [goToLastSavePoint, listenItem];
    if(downloadItem!=null) result.add(downloadItem);
    result.add(savePointItem);

    return result;
  }
}
