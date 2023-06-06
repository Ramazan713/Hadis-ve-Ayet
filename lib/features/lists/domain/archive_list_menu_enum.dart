


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum ArchiveListMenuEnum implements IMenuItem{
  rename(
      title: "Yeniden İsimlendir",
      iconInfo: IconInfo(iconData: Icons.drive_file_rename_outline)
  ),
  remove(
      title: "Sil",
      iconInfo: IconInfo(iconData: Icons.folder_delete)
  ),
  exportAs(
      title: "Dışa Aktar",
      iconInfo: IconInfo(iconData: Icons.share)
  ),
  unArchive(
      title: "Arşivden Çıkar",
      iconInfo: IconInfo(iconData: Icons.unarchive)
  );



  const ArchiveListMenuEnum({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

}