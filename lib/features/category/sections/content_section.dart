

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/fards_info_enum.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';
import 'package:hadith/core/utils/asset_helper.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/category/category_page.dart';
import 'package:hadith/features/category/components/category_collection.dart';
import 'package:hadith/features/category/components/category_item.dart';

extension CategoryContentExt on CategoryPage{


  Widget getDhikrCollection(BuildContext context, bool expandContent){
    return CategoryCollection(
      title: "Zikir",
      expandContent: expandContent,
      items: [
        CategoryItem(
          title: "Zikirmatik",
          expandContent: expandContent,
          assetPath: AssetHelper.dhikr,
          onClick: () {
            ShowCountersRoute().push(context);
          },
        ),
      ]
    );
  }

  Widget getEsmaulHusnaCollection(BuildContext context, bool expandContent){
    return CategoryCollection(
      title: "Allah'ın Esmaları ve Sıfatları",
      expandContent: expandContent,
      items: [
        CategoryItem(
          title: "Esmaul Husna",
          expandContent: expandContent,
          assetPath: AssetHelper.esmaulHusna,
          onClick: () {
            ShowEsmaulHusnaRoute().push(context);
            // Navigator.pushNamed(context, EsmaulHusnaPage.id);
          },
        ),
        CategoryItem(
          title: IslamicInfoType.adjectivesOfAllah.title,
          expandContent: expandContent,
          assetPath: AssetHelper.islamicInfo2,
          onClick: () {
            AdjectiveOfAllahRoute().push(context);
          },
        ),
      ]
    );
  }


  Widget getPrayerAndVerseCollection(BuildContext context, bool expandContent){
    return CategoryCollection(
      title: "Dua ve Ayetler",
      expandContent: expandContent,
      items: [
        CategoryItem(
          title: "Namaz Duaları ve Ayetleri",
          expandContent: expandContent,
          assetPath: AssetHelper.prayer,
          onClick: () {
            PrayerAndVerseListRoute().push(context);
          },
        ),
        CategoryItem(
          title: "Kuranda geçen dua ayetleri",
          expandContent: expandContent,
          assetPath: AssetHelper.prayer,
          onClick: () {
            PrayerInQuranRoute().push(context);
          },
        ),
        CategoryItem(
          title: "Kuranda geçen dua ayetleri",
          expandContent: expandContent,
          assetPath: AssetHelper.prayer,
          onClick: () {
            PrayerInQuranRoute().push(context);
          },
        ),
      ]
    );
  }

  Widget getIslamicInfoCollection(BuildContext context, bool expandContent){
    return CategoryCollection(
      title: "İslami Bilgiler",
      expandContent: expandContent,
      items: [
        CategoryItem(
          title: IslamicInfoType.fards32.title,
          expandContent: expandContent,
          assetPath: AssetHelper.quranBook,
          onClick: () {
            FardsInfoRoute(fardsTypeId: FardsInfoEnum.f32.typeId).push(context);
          },
        ),
        CategoryItem(
          title: IslamicInfoType.fards54.title,
          expandContent: expandContent,
          assetPath: AssetHelper.quranBook,
          onClick: () {
            FardsInfoRoute(fardsTypeId: FardsInfoEnum.f54.typeId).push(context);
          },
        ),
        CategoryItem(
          title: IslamicInfoType.efaliMukellefin.title,
          expandContent: expandContent,
          assetPath: AssetHelper.book,
          onClick: () {
            EfaliMukellefinRoute().push(context);
          },
        ),
      ]
    );
  }
}