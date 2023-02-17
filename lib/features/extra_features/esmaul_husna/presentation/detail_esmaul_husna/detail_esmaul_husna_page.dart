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

class DetailEsmaulHusnaPage extends StatelessWidget {
  static const id = "DetailEsmaulHusnaPage";

  DetailEsmaulHusnaPage({Key? key}) : super(key: key);

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailEsmaulHusnaBloc>();
    final esmaulHusna = (ModalRoute.of(context)?.settings.arguments as EsmaulHusna?);
    if(esmaulHusna!=null){
      bloc.add(DetailEsmaulHusnaEventSetCurrent(item: esmaulHusna,jumpToPage: true));
    }

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
          child: BlocListener<DetailEsmaulHusnaBloc,DetailEsmaulHusnaState>(
            listener: (context,state){
              if(state.jumpToPage){
                controller.jumpToPage((state.currentItem?.order??0));
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
            child: BlocBuilder<DetailEsmaulHusnaBloc,DetailEsmaulHusnaState>(

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





