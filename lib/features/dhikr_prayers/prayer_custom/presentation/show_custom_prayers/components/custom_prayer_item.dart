import 'package:flutter/material.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

class CustomPrayerItem extends StatelessWidget {
  final PrayerCustom item;
  final Function() onMenuClick;
  final Function() onClick;
  final bool showDetail;
  final EdgeInsets? paddingsDetails;
  final EdgeInsets? paddingsNormal;
  final EdgeInsets? margins;


  const CustomPrayerItem({
    Key? key,
    required this.item,
    required this.onMenuClick,
    required this.onClick,
    this.showDetail = true,
    this.paddingsDetails,
    this.paddingsNormal,
    this.margins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(13);
    return Card(
      margin: margins,
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onClick,
        child: Padding(
          padding: getAdaptiveDefaultPaddings(),
          child: Row(
            children: [
              Expanded(
                child: getAdaptiveContent(context),
              ),
              IconButton(
                onPressed: onMenuClick,
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).iconTheme.color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets getAdaptiveDefaultPaddings(){
    if(showDetail){
      return paddingsDetails ?? const EdgeInsets.symmetric(horizontal: 5,vertical: 13);
    }
    return paddingsNormal ?? const EdgeInsets.symmetric(horizontal: 5,vertical: 1);
  }

  Widget getAdaptiveContent(BuildContext context){
    if(showDetail){
      return getContentLarge(context);
    }
    return getContentSmall(context);
  }

  Widget getContentSmall(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Text(
        item.name,
        style: Theme.of(context).textTheme.bodyLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget getContentLarge(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.pronunciationContent??"",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

}
