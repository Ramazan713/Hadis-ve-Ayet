import 'package:flutter/material.dart';
import 'package:hadith/constants/asset_helper.dart';
import 'package:hadith/constants/common_menu_items.dart';
import 'package:hadith/features/app/widget/bottom_nav_focus_widget.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';
import 'package:hadith/features/extra_features/quran_prayer/presentation/show_quran_prayer_page/show_quran_prayer_page.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'components/feature_item.dart';
import 'counter/presentation/show_counters/show_counter_page.dart';
import 'esmaul_husna/presentation/show_list_esmaul_husna/esmaul_husna_page.dart';
import 'islamic_info/presentation/detail_islamic_info/detail_islamic_info_page.dart';
import 'islamic_info/presentation/detail_islamic_info/info_page_param.dart';
import 'prayer_surah/presentation/show_prayer_surah/show_prayer_surah_page.dart';

class ExtraFeaturesPage extends StatelessWidget {
  static const id = "ExtraFeaturesPage";

  const ExtraFeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarFocusWidget(
      child: Scaffold(
          body: SafeArea(
              child: CustomSliverNestedView(context,
        isBottomNavAffected: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CustomSliverAppBar(
              snap: true,
              floating: true,
              title: const Text("Kategoriler"),
              actions: [
                getSettingIcon(context),
              ],
            )
          ];
        },
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            FeatureItem(
              title: "Zikirmatik",
              assetPath: AssetHelper.dhikr,
              onClick: () {
                Navigator.pushNamed(context, ShowCounterPage.id);
              },
            ),
            FeatureItem(
              title: "Esmaul Husna",
              assetPath: AssetHelper.esmaulHusna,
              onClick: () {
                Navigator.pushNamed(context, EsmaulHusnaPageOld.id);
              },
            ),
            FeatureItem(
              title: IslamicInfoType.adjectivesOfAllah.title,
              assetPath: AssetHelper.islamicInfo2,
              onClick: () {
                Navigator.pushNamed(context, DetailIslamicInfoPage.id,
                  arguments: InfoPageParam(
                      infoType: IslamicInfoType.adjectivesOfAllah,
                      itemAxis: Axis.vertical),
                );
              },
            ),
            FeatureItem(
              title: IslamicInfoType.efaliMukellefin.title,
              assetPath: AssetHelper.book,
              onClick: () {
                Navigator.pushNamed(context, DetailIslamicInfoPage.id,
                    arguments: InfoPageParam(
                        infoType: IslamicInfoType.efaliMukellefin,
                        itemAxis: Axis.vertical));
              },
            ),
            FeatureItem(
              title: "Namaz Duaları ve Ayetleri",
              assetPath: AssetHelper.prayer,
              onClick: () {
                Navigator.pushNamed(context, ShowPrayerSurahPage.id);
              },
            ),
            FeatureItem(
              title: "Kuranda geçen dua ayetleri",
              assetPath: AssetHelper.prayer,
              onClick: () {
                Navigator.pushNamed(context, ShowQuranPrayerPage.id);
              },
            ),

            FeatureItem(
              title: IslamicInfoType.fards32.title,
              assetPath: AssetHelper.quranBook,
              onClick: () {
                Navigator.pushNamed(context, DetailIslamicInfoPage.id,
                    arguments: InfoPageParam(
                        infoType: IslamicInfoType.fards32,
                        itemAxis: Axis.horizontal));
              },
            ),
            FeatureItem(
              title: IslamicInfoType.fards54.title,
              assetPath: AssetHelper.quranBook,
              onClick: () {
                Navigator.pushNamed(context, DetailIslamicInfoPage.id,
                    arguments: InfoPageParam(
                        infoType: IslamicInfoType.fards54,
                        itemAxis: Axis.horizontal));
              },
            ),

          ],
        ),
      ))),
    );
  }
}


