import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/detail_esmaul_husna_page.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/show_list_esmaul_husna/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/show_list_esmaul_husna/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/show_list_esmaul_husna/components/esmaul_husna_item.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';
import 'package:hadith/widgets/menu_button.dart';

import 'bloc/show_esmaul_husna_event.dart';
import 'constant/list_esmaul_husna_menu_enum.dart';


class EsmaulHusnaPage extends StatelessWidget {
  static const id = "EsmaulHusnaPage";

  const EsmaulHusnaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowEsmaulHusnaBloc>();

    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(context,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return [
                CustomSliverAppBar(
                   title: const Text("Esmaul Hüsna"),
                   floating: true,
                   snap: true,
                    actions: [
                      MenuButton<ListEsmaulHusnaMenuItem>(
                        items: ListEsmaulHusnaMenuItem.values.map((e){
                          return MenuModel(label: e.label, value: e,iconData: e.iconData);
                        }).toList(),
                        selectedFunc: (selected){
                          switch(selected){
                            case ListEsmaulHusnaMenuItem.selectFontSize:
                              showSelectFontSizeBottomDia(context);
                              break;
                          }
                        },
                      )
                    ],
                )
              ];
            },
            child: BlocBuilder<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState>(
              builder: (context,state){
                final items = state.items;
                if(items.isEmpty){
                  return const Text("empty");
                }

                return ListView.builder(
                  itemBuilder: (context,index){
                    final item = items[index];
                    return EsmaulHusnaItem(
                      esmaulHusna: item,
                      fontSize: state.fontSize.size,
                      onClick: (){
                        Navigator.pushNamed(context, DetailEsmaulHusnaPage.id,
                          arguments: item
                        );
                      },
                    );
                  },
                  itemCount: items.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}




