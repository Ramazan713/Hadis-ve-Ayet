
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/home/components/home_item.dart';
import 'package:hadith/features/home/components/home_section_item.dart';
import 'package:hadith/features/home/home_page.dart';

extension HomeVerseContentSection on HomePage{

  HomeSectionItem getVerseSection(BuildContext context,int gridCount){
    return HomeSectionItem(
        title: "Kur'an-ı Kerim",
        gridCount: gridCount,
        items: [
          HomeItem(
            title: "Konular",
            iconData: FontAwesomeIcons.bookOpenReader,
            onTap: (){
              SectionRoute(bookId: BookEnum.diyanetMeal.bookId).push(context);
            },
            useSecondary: false,
          ),
          HomeItem(
            title: "Cüz",
            iconData: FontAwesomeIcons.bookQuran,
            onTap: (){
              CuzRoute().push(context);
            },
            useSecondary: false,
          ),
          HomeItem(
            title: "Sure",
            iconData: FontAwesomeIcons.bookQuran,
            onTap: (){
              SurahRoute().push(context);
            },
            useSecondary: false,
          ),
          HomeItem(
            title: "Sayfa",
            iconData: FontAwesomeIcons.bookQuran,
            onTap: (){
              VersePageShowRoute().push(context);
            },
            useSecondary: false,
          ),
          HomeItem(
            title: "Kayıt Noktaları",
            iconData: Icons.save,
            onTap: (){
              showSelectSavePointsWithScopes(context,
                shortTitle: BookScopeEnum.diyanetMeal.description,
                menuItems: SavePointTypeBarExt.getSavePointTypes(BookEnum.diyanetMeal),
                scopes: [BookScopeEnum.diyanetMeal],
              );
            },
            useSecondary: false,
          )
        ]
    );
  }
}