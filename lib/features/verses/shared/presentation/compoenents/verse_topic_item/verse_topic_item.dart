
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/circle_icon_tip.dart';

class VerseTopicItem extends StatelessWidget {
  final String label;
  final int itemId;
  final IconData iconData;
  final void Function()?onTap;
  final void Function()?onLongPress;
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
    required this.infoResult
  }) : super(key: key);


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
          iconColor: Theme.of(context).errorColor,
      ));
      items.add(const SizedBox(width: width,));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle=Theme.of(context).textTheme.bodyText1;
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        child: ListTile(
          title: Text(label,style: textStyle,),
          leading: Icon(iconData,color: textStyle?.color,),
          onTap: onTap,
          onLongPress: onLongPress,
          trailing: getTrailingWidget(context),
        ));
  }
}
