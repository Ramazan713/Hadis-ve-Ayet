
import 'package:flutter/material.dart';

class TopicIconItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final void Function()?onTap;
  final void Function()?onLongPress;
  final Widget? trailing;
  final bool isDownloadingActive;
  final bool isAudioRunning;
  const TopicIconItem({Key? key,required this.label,this.onLongPress,required this.iconData,this.trailing,
    required this.onTap,required this.isDownloadingActive,required this.isAudioRunning}) : super(key: key);


  Widget? getTrailingWidget(BuildContext context){
    final iconColor = Theme.of(context).iconTheme.color;
    final downloadingIcon = Icon(Icons.downloading,color: iconColor,);
    final audioIcon = Icon(Icons.audiotrack,color: iconColor,);

    final isAudio = isDownloadingActive || isAudioRunning;
    final audioIcons = [];
    if(isDownloadingActive)audioIcons.add(downloadingIcon);
    if(isAudioRunning)audioIcons.add(audioIcon);

    if(trailing!=null && isAudio){
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
    }else if(trailing!=null){
      return trailing!;
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
