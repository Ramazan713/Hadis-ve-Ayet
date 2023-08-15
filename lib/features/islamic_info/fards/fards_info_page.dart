import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/fards_info_enum.dart';
import 'package:hadith/features/islamic_info/shared/presentation/islamic_info_shared_page.dart';

class FardsInfoPage extends StatelessWidget {

  final int fardsTypeId;

  const FardsInfoPage({
    Key? key,
    required this.fardsTypeId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final infoType = FardsInfoEnum.from(fardsTypeId).infoType;

    return IslamicInfoSharedPage(
        infoType: infoType,
        title: infoType.title,
        showVertical: false
    );
  }
}