import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';


class BackupMetaItem extends StatelessWidget {
  final BackupMetaModel item;
  final bool isSelected;
  final Function()? onTap;

  const BackupMetaItem({
    Key? key,
    required this.item,
    required this.isSelected,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final colorSchema = Theme.of(context).colorScheme;
    final tileColor = isSelected ? colorSchema.secondaryContainer : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        tileColor: tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19),
        ),
        title: Text(
          "Backup-${item.isAuto ? 'Auto-' : ''}${item.updatedDate}",
        ),
        onTap: onTap,
      ),
    );
  }
}
