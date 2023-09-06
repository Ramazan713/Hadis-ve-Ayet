import 'package:flutter/material.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';


class AddCounterItem extends StatelessWidget {
  final PrayerDhikr item;
  final Function() onClick;
  final bool showDetails;
  final bool selected;

  const AddCounterItem({
    Key? key,
    required this.item,
    required this.onClick,
    this.showDetails = true,
    this.selected = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        selected: selected,
        selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        title: Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: getTitleFontWeight()
          ),
        ),
        subtitle: getSubTitle(context),
        onTap: onClick,
      ),
    );
  }

  Widget? getSubTitle(BuildContext context){
    if(!showDetails) return null;
    return Text(
      item.pronunciationContent,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  FontWeight getTitleFontWeight(){
    if(showDetails)return FontWeight.w500;
    return FontWeight.normal;
  }


}