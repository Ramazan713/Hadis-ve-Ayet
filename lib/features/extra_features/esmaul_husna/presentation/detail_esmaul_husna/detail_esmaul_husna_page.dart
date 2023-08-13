import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/bloc/detail_esmaul_husna_event.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/bloc/detail_esmaul_husna_state.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/components/detail_esmaul_husna.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/constant/detail_esmaul_husna_menu_enum.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/widgets/menu_button.dart';

import '../../domain/model/esmaul_husna.dart';
import 'bloc/detail_esmaul_husna_bloc.dart';

class DetailEsmaulHusnaPageOld extends StatelessWidget {
  static const id = "DetailEsmaulHusnaPage";

  DetailEsmaulHusnaPageOld({Key? key}) : super(key: key);

  late final PageController controller;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailEsmaulHusnaBlocOld>();
    final esmaulHusna = (ModalRoute.of(context)?.settings.arguments as EsmaulHusna?);
    if(esmaulHusna!=null){
      bloc.add(DetailEsmaulHusnaEventSetInit(item: esmaulHusna,jumpToPage: true));
    }
    controller = PageController(initialPage: esmaulHusna?.order??0);

    return Scaffold(
      body: SafeArea(
        child: CustomSliverNestedView(
          context,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              CustomSliverAppBar(
                title: const Text("Esmaul Hüsna"),
                actions: [
                  MenuButton(
                      items: DetailEsmaulHusnaMenuEnum.values.map((e){
                        return MenuModel(label: e.label, value: e,iconData: e.iconData);
                      }).toList(),
                      selectedFunc: (selected){
                        switch(selected){
                          case DetailEsmaulHusnaMenuEnum.selectFontSize:
                            showSelectFontSizeBottomDia(context);
                            break;
                        }
                      },
                  )
                ],
              )
            ];
          },
          child: BlocListener<DetailEsmaulHusnaBlocOld,DetailEsmaulHusnaStateOld>(
            listener: (context,state){
              if(controller.hasClients&&state.jumpToPage){
                controller.animateToPage((state.currentItem?.order??0),duration: const Duration(microseconds: 300),curve: Curves.easeIn);
              }
              if(state.message!=null){
                ToastUtils.showLongToast(state.message??"");
              }
              final navigation = state.navigationState;
              if(navigation!=null){
                Navigator.pushNamed(context, navigation.destination,
                    arguments: navigation.parameters
                );
              }
            },
            child: BlocBuilder<DetailEsmaulHusnaBlocOld,DetailEsmaulHusnaStateOld>(

              builder: (context,state){
                if(state.isLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final items = state.items;
                if(items.isEmpty){
                  return const Text("empty");
                }
                return PageView.builder(
                  controller: controller,
                  itemBuilder: (context,index){
                    final item = items[index];
                    return DetailEsmaulHusna(
                      esmaulHusna: item,
                      fontSize: state.fontSize.size,
                      onGotoDhikr: (){
                        bloc.add(DetailEsmaulHusnaEventGotoDhikr(item: item));
                      },
                      onSaveAsDhikr: (){
                        bloc.add(DetailEsmaulHusnaEventSaveAsDhikr(item: item));
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





