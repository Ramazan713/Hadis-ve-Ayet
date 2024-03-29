
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/home/components/home_item.dart';
import 'package:hadith/features/home/components/home_section_item.dart';
import '../home_page.dart';

extension HomeSerlevhaContentSection on HomePage{

  HomeSectionItem getSerlevhaHadithSection(BuildContext context){
    final loadSavePointBloc = context.read<LoadSavePointBloc>();

    return HomeSectionItem(
        title: "Serlevha",
        items: [
          HomeItem(
            title: "Tümü",
            iconData: Icons.all_inclusive,
            onTap: (){
              loadSavePointBloc.add(LoadSavePointEventLoadLastOrDefault(
                  destination: DestinationAll(bookEnum: BookEnum.serlevha),
                  autoType: SaveAutoType.general
              ));
            },
          ),
          HomeItem(
            title: "Konular",
            iconData: FontAwesomeIcons.bookOpenReader,
            onTap: (){
              SectionRoute(bookId: BookEnum.serlevha.bookId).push(context);
            },
          ),
          HomeItem(
            title: "Kayıt Noktaları",
            iconData: Icons.save,
            onTap: (){
              showSelectSavePointsWithScopes(context,
                shortTitle: BookScopeEnum.serlevha.description,
                menuItems: SavePointTypeBarExt.getSavePointTypes(BookEnum.serlevha),
                scopes: [BookScopeEnum.serlevha,BookScopeEnum.serlevhaSitte],
              );
            },
          )
        ]
    );
  }

}