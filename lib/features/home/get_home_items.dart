

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/features/hadiths/presentation/all_hadith/hadith_all_page.dart';
import 'package:hadith/features/home/widget/home_book_item.dart';
import 'package:hadith/features/home/widget/home_sub_item.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

import '../../constants/enums/book_enum.dart';
import '../save_point/constants/origin_tag_enum.dart';
import '../../models/save_point_argument.dart';
import '../hadith/hadith_router.dart';
import '../paging/hadith_loader/hadith_serlevha_paging_loader.dart';
import '../paging/hadith_loader/hadith_sitte_paging_loader.dart';
import '../paging/paging_argument.dart';
import '../save_point/show_select_savepoint_with_book_dia.dart';
import '../topic/model/section_argument.dart';
import '../topic/section_screen.dart';
import '../verse/cuz/cuz_screen.dart';
import '../verse/surah/surah_screen.dart';


final List<String> homeTitles = [
  "Kur'an-ı Kerim",
  "Serlevha",
  "Kütübi Sitte",
];

List<HomeBookItem>getHomeItems(BuildContext context,{required OriginTag originTag}){
  return [
    HomeBookItem(
        item1: HomeSubItem(
          title: "Konular",
          iconData: FontAwesomeIcons.bookOpenReader,
          onTap: () {
            final sectionArgument =
            SectionArgument(bookEnum: BookEnum.diyanetMeal);
            Navigator.pushNamed(context, SectionScreen.id,
                arguments: sectionArgument);
          },
        ),
        item2: HomeSubItem(
          title: "Cüz",
          iconData: FontAwesomeIcons.bookQuran,
          onTap: () {
            Navigator.pushNamed(context, CuzScreen.id);
          },
        ),
        item3: HomeSubItem(
          title: "Sure",
          iconData: FontAwesomeIcons.bookQuran,
          onTap: () {
            Navigator.pushNamed(context, SurahScreen.id);
          },
        ),
        item4: HomeSubItem(
          title: "Kayıt Noktaları",
          iconData: Icons.save,
          onTap: () {
            showSelectSavePointWithBookDia(context,
                bookEnum: BookEnum.diyanetMeal,
                bookScopes: [BookScopeEnum.diyanetMeal],
                exclusiveTags: [OriginTag.all]);
          },
        ),
        title: homeTitles[0]),
    HomeBookItem(
        item1: HomeSubItem(
          title: "Tümü",
          iconData: Icons.all_inclusive,
          onTap: () {
            // var loader = HadithSerlevhaPagingLoader(context: context);

            Navigator.pushNamed(context, HadithAllPage.id);

            // routeHadithPage(
            //     context,
            //     PagingArgument(
            //         savePointArg: SavePointLoadArg(parentKey: BookEnum.serlevha.bookId.toString()),
            //         bookScope: BookScopeEnum.serlevha,
            //         title: "Tümü",
            //         loader: loader,
            //         originTag: originTag));
          },
        ),
        item2: HomeSubItem(
          title: "Konular",
          iconData: FontAwesomeIcons.bookOpenReader,
          onTap: () {
            final sectionArgument =
            SectionArgument(bookEnum: BookEnum.serlevha);
            Navigator.pushNamed(context, SectionScreen.id,
                arguments: sectionArgument);
          },
        ),
        item3: HomeSubItem(
          title: "Kayıt Noktaları",
          iconData: Icons.save,
          onTap: () {

            showSelectSavePointsWithScopes(context,
                shortTitle: BookScopeEnum.serlevha.description,
                menuItems: SavePointTypeBarExt.getSavePointTypes(BookEnum.serlevha),
                scopes: [BookScopeEnum.serlevha,BookScopeEnum.serlevhaSitte],
            );

            // showSelectSavePointWithBookDia(context,
            //     bookEnum: BookEnum.serlevha,
            //     bookScopes: [
            //       BookScopeEnum.serlevha,
            //       BookScopeEnum.serlevhaSitte
            //     ],
            //     exclusiveTags: [
            //       OriginTag.surah,
            //       OriginTag.cuz
            //     ]);
          },
        ),
        title: homeTitles[1]), //Serlevha

    HomeBookItem(
        item1: HomeSubItem(
          title: "Tümü",
          iconData: Icons.all_inclusive,
          onTap: () {
            var loader = HadithSittePagingLoader(context: context);
            routeHadithPage(
                context,
                PagingArgument(
                    savePointArg: SavePointLoadArg(
                        parentKey:BookEnum.sitte.bookId.toString() ),
                    bookScope: BookScopeEnum.sitte,
                    title: "Tümü",
                    loader: loader,
                    originTag: originTag));
          },
        ),
        item2: HomeSubItem(
          title: "Konular",
          iconData: FontAwesomeIcons.bookOpenReader,
          onTap: () {
            final sectionArgument = SectionArgument(bookEnum: BookEnum.sitte);
            Navigator.pushNamed(context, SectionScreen.id,
                arguments: sectionArgument);
          },
        ),
        item3: HomeSubItem(
          title: "Kayıt Noktaları",
          iconData: Icons.save,
          onTap: () {
            showSelectSavePointWithBookDia(context,
                bookEnum: BookEnum.sitte,
                bookScopes: [
                  BookScopeEnum.sitte,
                  BookScopeEnum.serlevhaSitte
                ],
                exclusiveTags: [
                  OriginTag.surah,
                  OriginTag.cuz
                ]);
          },
        ),
        title: homeTitles[2]), //Kütübi Sitte


  ];
}