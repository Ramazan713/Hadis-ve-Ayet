


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum ShowListMenuEnum implements IMenuItem{
  rename(
      title: "Yeniden İsimlendir",
      iconInfo: IconInfo(iconData: Icons.drive_file_rename_outline)
  ),
  remove(
      title: "Sil",
      iconInfo: IconInfo(iconData: Icons.folder_delete)
  ),
  removeItems(
      title: "İçindekileri Sil",
      iconInfo: IconInfo(iconData: Icons.delete)
  ),
  exportAs(
      title: "Dışa Aktar",
      iconInfo: IconInfo(iconData: Icons.share)
  ),
  archive(
      title: "Arşivle",
      iconInfo: IconInfo(iconData: Icons.send_and_archive)
  ),
  newCopy(
      title: "Kopyasını Oluştur",
      iconInfo: IconInfo(iconData: Icons.copy)
  );



  const ShowListMenuEnum({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

  static List<ShowListMenuEnum> getMenuItems(bool isRemovable){
    final List<ShowListMenuEnum> items;
    if(isRemovable){
      items = [
        ShowListMenuEnum.rename,
        ShowListMenuEnum.remove,
        ShowListMenuEnum.exportAs,
        ShowListMenuEnum.archive,
        ShowListMenuEnum.newCopy
      ];
    }else{
      items = [
        ShowListMenuEnum.rename,
        ShowListMenuEnum.removeItems,
        ShowListMenuEnum.exportAs,
        ShowListMenuEnum.newCopy
      ];
    }
    return items;
  }

}