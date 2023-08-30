
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/domain/enums/detail_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/components/detail_esmaul_husna.dart';
import 'package:hadith/utils/toast_utils.dart';

import 'bloc/detail_esmaul_husna_state.dart';

class DetailEsmaulHusnaPage extends StatelessWidget {

  final int initPos;

  DetailEsmaulHusnaPage({
    Key? key,
    required this.initPos
  }) : super(key: key);

  late final PageController pageController;
  final CustomPositionController _positionController = CustomPositionController();

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<DetailEsmaulHusnaBloc>();
    bloc.add(DetailEsmaulHusnaEventLoadData());

    pageController = PageController(initialPage: initPos);
    _positionController.setPositions(initPos,initPos,totalItems: bloc.state.items.length);

    return WillPopScope(
      onWillPop: (){
        // ShowEsmaulHusnaRoute(pos: pageController.page?.toInt() ?? 0)
        //   .go(context);
        Navigator.pop(context,pageController.page?.toInt());
        return Future.value(false);
      },
      child: getListeners(
        child: Scaffold(
            body: SafeArea(
              child: CustomNestedViewAppBar(
                title: const Text("Esmaul Husna"),
                actions: getActions(context),
                child: Column(
                  children: [
                    Expanded(
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
                            onPageChanged: (page){
                              _positionController.setPositions(page, page,totalItems: items.length);
                            },
                            controller: pageController,
                            itemBuilder: (context,index){
                              final item = items[index];
                              return DetailEsmaulHusna(
                                esmaulHusna: item,
                                fontModel: state.fontModel,
                                onGotoDhikr: (){
                                  // bloc.add(DetailEsmaulHusnaEventGotoDhikr(item: item));
                                },
                                onSaveAsDhikr: (){
                                  // bloc.add(DetailEsmaulHusnaEventSaveAsDhikr(item: item));
                                },
                              );
                            },
                            itemCount: items.length,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }



  Widget getListeners({required Widget child}){
    return MultiBlocListener(
        listeners: [
          BlocListener<DetailEsmaulHusnaBloc,DetailEsmaulHusnaState>(
            listenWhen: (prevState, nextState){
              return prevState.message != nextState.message;
            },
            listener: (context, state){
              final message = state.message;
              if(message!=null){
                ToastUtils.showLongToast(message);
                context.read<DetailEsmaulHusnaBloc>()
                    .add(DetailEsmaulHusnaEventClearMessage());
              }
            },
          ),
          BlocListener<DetailEsmaulHusnaBloc,DetailEsmaulHusnaState>(
            listenWhen: (prevState, nextState){
              return prevState.items.length != nextState.items.length;
            },
            listener: (context, state){
             _positionController.setPositions(0, 0,totalItems: state.items.length);
            },
          )
        ],
        child: child
    );
  }

  void _jumpToPage(int page){
    pageController.animateToPage(page,duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  List<Widget> getActions(BuildContext context){
    return [
      NavigateToIcon(
        positionController: _positionController,
        onPosChanged: (selectedIndex){
          _jumpToPage(selectedIndex);
        },
      ),
      _topBarDropDownMenu(context)
    ];
  }

  Widget _topBarDropDownMenu(BuildContext context){
    return CustomDropdownIconMenu(
      items: DetailEsmaulHusnaTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case DetailEsmaulHusnaTopBarMenuItem.fontSize:
            showSelectFontSizeDia(context);
            break;
        }
      },
    );
  }
}
