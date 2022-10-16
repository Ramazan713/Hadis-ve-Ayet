

import 'package:flutter/material.dart';
import 'package:hadith/screens/setting_screen.dart';

Widget getSettingIcon(BuildContext context){
  return  IconButton(onPressed: (){
    Navigator.pushNamed(context, SettingScreen.id);
  }, icon: const Icon(Icons.settings),tooltip: "Ayarlar",);
}


Widget getMapIcon({required void Function() onPress}){
  return IconButton(onPressed: onPress, icon: const Icon(Icons.map),
    );
}

Widget getSavePointIcon({required void Function() onPress}){
  return IconButton(onPressed: onPress, icon: const Icon(Icons.save),
    tooltip: "Kayıt Noktası",);
}

Widget getManageSearchIcon({required void Function() onPress}){
  return IconButton(onPressed: onPress, icon: const Icon(Icons.manage_search),
    tooltip: "Arama Kriteri",);
}

Widget getPremiumActiveIcon({required void Function() onPress}){
  return IconButton(onPressed: onPress, icon: const Icon(Icons.workspace_premium,
    color: Color(0x86EF062E),),
  tooltip: "Premium Active",);
}