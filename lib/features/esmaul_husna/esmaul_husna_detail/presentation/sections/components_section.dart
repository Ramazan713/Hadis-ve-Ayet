
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/detail_esmaul_husna_page.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/domain/enums/detail_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_event.dart';
import 'package:hadith/utils/toast_utils.dart';


extension DetailEsmaulHusnaExt on DetailEsmaulHusnaPage{



  Widget getBottomButtons(BuildContext context, PageController pageController, CustomPositionController positionController){
    return ListenableBuilder(
      listenable: positionController,
      builder: (context, child){
        final previousEnabled = positionController.firstVisiblePos != 0;
        final nextEnabled = positionController.firstVisiblePos != positionController.totalItems - 1;
        return Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: !previousEnabled ? null : (){
                  pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                child: const Text("Önceki"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: !nextEnabled ? null : (){
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                child: const Text("Sonraki"),
              ),
            )
          ],
        );
      }
    );
  }

  Widget getListeners({required Widget child, required CustomPositionController positionController}){
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailEsmaulHusnaBloc, DetailEsmaulHusnaState>(
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
            positionController.setPositions(0, 0,totalItems: state.items.length);
          },
        )
      ],
      child: child
    );
  }

  List<Widget> getActions(BuildContext context,PageController pageController, CustomPositionController positionController){
    return [
      NavigateToIcon(
        positionController: positionController,
        onPosChanged: (selectedIndex){
          jumpToPage(selectedIndex, pageController);
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

  void jumpToPage(int page, PageController pageController){
    pageController.animateToPage(page,duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

}