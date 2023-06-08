
import 'package:flutter/material.dart';

class VerseTopicItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final void Function()?onTap;
  final void Function()?onLongPress;
  final bool hasSavePoint;
  final bool isDownloadingActive;
  final bool isAudioRunning;

  const VerseTopicItem({Key? key,required this.label,this.onLongPress,required this.iconData,
    required this.onTap,required this.isDownloadingActive,required this.isAudioRunning, required this.hasSavePoint}) : super(key: key);


  Widget? getTrailingWidget(BuildContext context){
    final iconColor = Theme.of(context).iconTheme.color;
    final downloadingIcon = Icon(Icons.downloading,color: iconColor,);
    final audioIcon = Icon(Icons.audiotrack,color: iconColor,);
    final savePointIcon = Icon(Icons.beenhere, color: Theme.of(context).errorColor,);

    final isAudio = isDownloadingActive || isAudioRunning;
    final audioIcons = [];
    if(isDownloadingActive)audioIcons.add(downloadingIcon);
    if(isAudioRunning)audioIcons.add(audioIcon);

    if(hasSavePoint && isAudio){
      return SizedBox(
        width: 60,
        height: 30,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...audioIcons,
            downloadingIcon
          ],
        ),
      );
    }else if(hasSavePoint){
      return savePointIcon!;
    }else if(isDownloadingActive){
      return downloadingIcon;
    }else if(isAudioRunning){
      return audioIcon;
    }
    return null;
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
