


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';

enum BackupLoadSectionMenu implements IMenuItem{
  loadLastBackup(
      title: "En son Yedeği Yükle",
  ),
  showBackupFiles(
      title: "Yedek dosyalarını göster",
  ),
  notShowAgain(
      title: "Bir daha bu uyarıyı gösterme",
  );

  const BackupLoadSectionMenu({
    required this.title
  });

  @override
  final String title;

  @override
  get iconInfo => null;
}
