
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum PrayerCustomTopBarMenu implements IMenuItem{

  import(
      title: "import",
      iconInfo: IconInfo(iconData: FontAwesomeIcons.fileImport)
  ),
  ;

  const PrayerCustomTopBarMenu({
    required this.title,
    this.iconInfo
  });

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}