
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_preview_share_image_handle_dia.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/components/detail_esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/detail_esmaul_husna_page.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/domain/enums/detail_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/enums/esmaul_husna_share_menu_item.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/extensions/esmaul_husna_share_ext.dart';


extension DetailEsmaulHusnaExt on DetailEsmaulHusnaPageState{

  Widget getBottomButtons(){
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

  Widget getListeners({required Widget child}){
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

  List<Widget> getActions(){
    return [
      _getShareIcon(),
      NavigateToIcon(
        positionController: positionController,
        onPosChanged: (selectedIndex){
          jumpToPage(selectedIndex);
        },
      ),
      _topBarDropDownMenu()
    ];
  }

  Widget _topBarDropDownMenu(){
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

  Widget _getShareIcon(){
    final shareBloc = context.read<ShareBloc>();
    return BlocBuilder<DetailEsmaulHusnaBloc,DetailEsmaulHusnaState>(
      buildWhen: (prevState, nextState){
        return prevState.currentItem != nextState.currentItem ||
          prevState.fontModel != nextState.fontModel;
      },
      builder: (context, state){
        final item = state.currentItem;
        if(item == null) return const SizedBox.shrink();
        final shareText = item.getShareLong();

        return IconButton(
          onPressed: (){
            showShareAlertDia(context,
                items: EsmaulHusnaShareMenuItem.values,
                onSelected: (shareMenuItem){
                  switch(shareMenuItem){
                    case EsmaulHusnaShareMenuItem.shareText:
                      shareBloc.add(ShareEventShareText(text: shareText));
                      break;
                    case EsmaulHusnaShareMenuItem.copyText:
                      shareBloc.add(ShareEventCopyText(text: shareText));
                      break;
                    case EsmaulHusnaShareMenuItem.shareImage:
                      showPreviewShareImageHandleDia(context,
                        onImageWidget: (key){
                          return DetailEsmaulHusnaRepaintItem(
                            fontModel: state.fontModel,
                            esmaulHusna: item,
                            repaintKey: key,
                          );
                        },
                        imageName: "${item.name}_detail.png"
                      );
                      break;
                  }
                }
            );
          },
          icon: const Icon(Icons.share),
        );
      },
    );
  }


  void jumpToPage(int page){
    pageController.animateToPage(page,duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

}