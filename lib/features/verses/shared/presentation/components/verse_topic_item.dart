
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/features/verses/shared/domain/models/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/presentation/components/circle_icon_tip.dart';

class VerseTopicItem extends StatelessWidget {
  final String label;
  final int itemId;
  final IconData iconData;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onClickMoreMenu;

  final bool hasSavePoint;
  final AudioInfoResultModel infoResult;
  final DownloadedAudioViewModel? downloadedAudioView;

  const VerseTopicItem({
    Key? key,
    required this.label,
    required this.itemId,
    this.onLongPress,
    required this.iconData,
    required this.onTap,
    required this.hasSavePoint,
    this.downloadedAudioView,
    this.onClickMoreMenu,
    required this.infoResult
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CardListTile(
      margins: const EdgeInsets.symmetric(vertical: 3),
      contentPadding: const EdgeInsets.only(left: 16,right: 8),
      defaultColor: Theme.of(context).colorScheme.primaryContainer,
      title: Text(label,),
      leading: Icon(iconData),
      onTap: onTap,
      onLongPress: onLongPress,
      trailing: getTrailingWidget(context),
    );
  }


  Widget? getTrailingWidget(BuildContext context){
    const double width = 10;

    final items = <Widget>[];
    if(infoResult.downloadingItem == itemId){
      items.add(const CircleIconTip(
          iconData: Icons.downloading,
          message: "indiriliyor"
      ));
      items.add(const SizedBox(width: width,));
    }
    if(infoResult.downloadingQueueItems.contains(itemId)){
      items.add(const CircleIconTip(
          iconData: Icons.access_time,
          message: "indirme sırasında"
      ));
      items.add(const SizedBox(width: width,));
    }
    if(infoResult.listeningItem == itemId){
      items.add(const CircleIconTip(
          iconData: Icons.audiotrack,
          message: "çalıyor"
      ));
      items.add(const SizedBox(width: width,));
    }
    if(downloadedAudioView?.isDownloaded == true){
      items.add(const CircleIconTip(
          iconData: Icons.download_done,
          message: "indirilmiş"
      ));
      items.add(const SizedBox(width: width,));
    }
    if(hasSavePoint){
      items.add(CircleIconTip(
        iconData: Icons.beenhere,
        message: "kayıt noktası",
        iconColor: Theme.of(context).colorScheme.error,
      ));
      items.add(const SizedBox(width: width,));
    }

    if(onClickMoreMenu!= null){
      items.add(
          IconButton(
            onPressed: onClickMoreMenu,
            icon: const Icon(Icons.more_vert),
            tooltip: "Daha fazlası",
          )
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }
}
