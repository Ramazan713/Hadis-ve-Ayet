import 'package:flutter/material.dart';
import 'package:hadith/db/entities/backup_meta.dart';


class BackupMetaItem extends StatelessWidget {
  final BackupMeta item;
  final bool isSelected;
  final TextStyle? textStyle;
  final Function()? onTap;
  const BackupMetaItem({Key? key,required this.item,required this.isSelected,this.textStyle,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        tileColor: isSelected ? Theme.of(context).selectedRowColor : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
            side: BorderSide(
                color: textStyle?.color ?? Colors.black)),
        title: Text(
          "Backup-${item.isAuto ? 'Auto-' : ''}${item.updatedDate}",
          style: textStyle,
        ),
        onTap: onTap,
      ),
    );
  }
}
