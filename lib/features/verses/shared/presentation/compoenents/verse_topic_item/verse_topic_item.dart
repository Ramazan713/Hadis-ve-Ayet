
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
    final downloadingIcon = Icon(Icons.access_time,color: iconColor,);
    final audioIcon = Icon(Icons.audiotrack,color: iconColor,);
    final savePointIcon = Icon(Icons.beenhere, color: Theme.of(context).errorColor,);
    const double width = 10;

    final items = <Widget>[];
    if(isDownloadingActive){
      items.add(downloadingIcon);
      items.add(const SizedBox(width: width,));
    }
    if(isAudioRunning){
      items.add(audioIcon);
      items.add(const SizedBox(width: width,));
    }
    if(hasSavePoint){
      items.add(savePointIcon);
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
