import 'package:flutter/material.dart';
import 'package:hadith/core/features/backup/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';


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
    return CardListTile(
      margins:const EdgeInsets.symmetric(vertical: 4),
      isSelected: isSelected,
      elevation: 1,
      borderWidth: 1,
      shadowColor: null,
      title: Text(
        "Backup-${item.isAuto ? 'Auto-' : ''}${item.updatedDate}",
      ),
      onTap: onTap,
    );
  }
}
