import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';


enum CuzSavePointMenuItem implements IMenuItem{

  goToLastSavePoint(
      title: "Git (son kayıt noktası)",
      iconInfo: IconInfo(iconData: Icons.login)
  ),
  signSavePoint(
      title: "İşaretle",
      iconInfo: IconInfo(iconData: Icons.save_outlined)
  ),
  unSignSavePoint(
      title: "İşareti Kaldır",
      iconInfo: IconInfo(iconData: Icons.save_outlined)
  );

  const CuzSavePointMenuItem({required this.title,this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

  static List<CuzSavePointMenuItem> getMenuItems(bool hasSavePoint){
    if(hasSavePoint){
      return [goToLastSavePoint, unSignSavePoint];
    }
    return [goToLastSavePoint, signSavePoint];
  }


}
