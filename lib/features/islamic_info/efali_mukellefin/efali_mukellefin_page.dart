

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';
import 'package:hadith/features/islamic_info/shared/presentation/islamic_info_shared_page.dart';

class EfaliMukellefinPage extends StatelessWidget {

  const EfaliMukellefinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const infoType = IslamicInfoType.efaliMukellefin;

    return IslamicInfoSharedPage(
        infoType: infoType,
        title: infoType.title,
        showVertical: true
    );
  }
}
