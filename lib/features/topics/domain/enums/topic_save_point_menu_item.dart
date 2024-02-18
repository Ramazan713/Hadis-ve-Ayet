import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';


enum TopicSavePointMenuItem implements IMenuItem{

  signSavePoint(
      title: "İşaretle",
      iconInfo: IconInfo(iconData: Icons.save_outlined)
  ),
  unSignSavePoint(
      title: "İşareti Kaldır",
      iconInfo: IconInfo(iconData: Icons.save_outlined)
  );

  const TopicSavePointMenuItem({required this.title,this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

  static List<TopicSavePointMenuItem> getMenuItems(bool hasSavePoint){
    if(hasSavePoint){
      return [unSignSavePoint];
    }
    return [signSavePoint];
  }


}
