import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/list_ext.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/esmaul_husna/domain/enums/detail_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/presentation/components/detail_esmaul_husna.dart';


class EsmaulHusnaDetailPageContent extends StatelessWidget {

  final PageController pageController;
  final CustomPositionController positionController;
  final bool isFullPage;
  final int currentPage;
  final void Function(int page) onPageChange;
  final void Function(EsmaulHusna item) onShareClick;

  const EsmaulHusnaDetailPageContent({
    super.key,
    required this.pageController,
    required this.positionController,
    required this.isFullPage,
    required this.currentPage,
    required this.onPageChange,
    required this.onShareClick
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowEsmaulHusnaBloc>();

    return PopScope(
      canPop: !isFullPage,
      onPopInvoked: (canPop){
        if(!canPop){
          bloc.add(ShowEsmaulHusnaEventHideDetail());
        }
      },
      child: DefaultNestedScrollableAppBar(
        title: const Text("Esmaul Husna"),
        floating: true,
        snap: true,
        actions: getActionsDetail(context),
        showNavigateBack: false,
        leading: getNavigateBackIcon(context),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState>(
                  buildWhen: (prevState, nextState){
                    return prevState.isLoading != nextState.isLoading ||
                        prevState.items != nextState.items ||
                        prevState.fontModel != nextState.fontModel;
                  },
                  builder: (context,state){
                    if(state.isLoading){
                      return const SharedLoadingIndicator();
                    }
                    final items = state.items;
                    if(items.isEmpty){
                      return const SharedEmptyResult(
                        content: "herhangi bir sonuç bulunamadı",
                      );
                    }
                    return PageView.builder(
                      onPageChanged: (page){
                        EasyDebounce.debounce("onPageChanged", const Duration(milliseconds: 150), () {
                          onPageChange(page);
                          positionController.setPositions(page, page,totalItems: items.length);
                          final item = getCurrentItemWithIndex(context, page);
                          bloc.add(ShowEsmaulHusnaEventSetSelected(item: item));
                        });
                      },
                      controller: pageController,
                      itemBuilder: (context,index){
                        final item = items[index];
                        return DetailEsmaulHusna(
                          esmaulHusna: item,
                          fontModel: state.fontModel,
                          onGotoDhikr: (){
                            final counterId = item.counterId;
                            if(counterId!=null){
                              DetailCounterRoute(id: counterId).push(context);
                            }
                          },
                          onSaveAsDhikr: (){
                            bloc.add(ShowEsmaulHusnaEventSaveAsDhikr(item: item));
                          },
                        );
                      },
                      itemCount: items.length,
                    );
                  },
                ),
              ),
              getBottomButtons()
            ],
          ),
        ),
      ),
    );
  }

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

  Widget? getNavigateBackIcon(BuildContext context){
    if(!isFullPage) return null;
    return IconButton(
      onPressed: (){
        context.read<ShowEsmaulHusnaBloc>()
            .add(ShowEsmaulHusnaEventHideDetail());
      },
      icon: const Icon(Icons.arrow_back)
    );
  }

  List<Widget> getActionsDetail(BuildContext context){
    return [
      IconButton(
        onPressed: (){
          final item = getCurrentItem(context);
          if(item == null) return;
          onShareClick(item);
        },
        icon: const Icon(Icons.share)
      ),
      NavigateToIcon(
        positionController: positionController,
        onPosChanged: (selectedIndex){
          pageController.animateToPage(selectedIndex + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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

  EsmaulHusna? getCurrentItem(BuildContext context){
    final index = pageController.page?.toInt();
    if(index == null) return null;

    return getCurrentItemWithIndex(context, index);
  }

  EsmaulHusna? getCurrentItemWithIndex(BuildContext context, int index){
    if(index < 0) return null;
    final bloc = context.read<ShowEsmaulHusnaBloc>();
    return bloc.state.items.getOrNull(index);
  }

}
