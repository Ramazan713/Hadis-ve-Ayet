
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/fards_info_enum.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/utils/asset_helper.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/category/components/category_item.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: const Text("Kategoriler"),
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              CategoryItem(
                title: "Zikirmatik",
                assetPath: AssetHelper.dhikr,
                onClick: () {
                  ShowCountersRoute().push(context);
                  // Navigator.pushNamed(context, ShowCounterPage.id);
                },
              ),
              CategoryItem(
                title: "Esmaul Husna",
                assetPath: AssetHelper.esmaulHusna,
                onClick: () {
                  ShowEsmaulHusnaRoute(pos: 30).push(context);
                  // Navigator.pushNamed(context, EsmaulHusnaPage.id);
                },
              ),
              CategoryItem(
                title: IslamicInfoType.adjectivesOfAllah.title,
                assetPath: AssetHelper.islamicInfo2,
                onClick: () {
                  AdjectiveOfAllahRoute().push(context);
                },
              ),
              CategoryItem(
                title: IslamicInfoType.efaliMukellefin.title,
                assetPath: AssetHelper.book,
                onClick: () {
                  EfaliMukellefinRoute().push(context);
                },
              ),
              CategoryItem(
                title: "Namaz Duaları ve Ayetleri",
                assetPath: AssetHelper.prayer,
                onClick: () {
                  PrayerAndVerseListRoute().push(context);
                },
              ),
              CategoryItem(
                title: "Kuranda geçen dua ayetleri",
                assetPath: AssetHelper.prayer,
                onClick: () {
                  PrayerInQuranRoute().push(context);
                },
              ),

              CategoryItem(
                title: IslamicInfoType.fards32.title,
                assetPath: AssetHelper.quranBook,
                onClick: () {
                  FardsInfoRoute(fardsTypeId: FardsInfoEnum.f32.typeId).push(context);
                },
              ),
              CategoryItem(
                title: IslamicInfoType.fards54.title,
                assetPath: AssetHelper.quranBook,
                onClick: () {
                  FardsInfoRoute(fardsTypeId: FardsInfoEnum.f54.typeId).push(context);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
