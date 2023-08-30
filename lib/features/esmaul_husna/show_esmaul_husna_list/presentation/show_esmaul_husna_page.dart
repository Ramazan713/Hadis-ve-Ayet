
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/domain/enums/show_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/components/esmaul_husna_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ShowEsmaulHusnaPage extends StatelessWidget {

  final int initPos;

  ShowEsmaulHusnaPage({
    Key? key,
    required this.initPos
  }) : super(key: key);

  final CustomScrollController _scrollController = CustomScrollController();
  final CustomPositionController _positionController = CustomPositionController();
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<ShowEsmaulHusnaBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocSelector<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState, bool>(
          selector: (state) => state.isSearchBarVisible,
          builder: (context, isSearchBarVisible){
            return CustomNestedSearchableAppBar(
              onSearchVisibilityChanged: (isSearchVisible){
                bloc.add(ShowEsmaulHusnaEventSetSearchBarVisibility(isVisible: isSearchVisible));
              },
              scrollController: _scrollController,
              searchBarVisible: isSearchBarVisible,
              onTextChanged: (text){
                bloc.add(ShowEsmaulHusnaEventSetQuery(query: text));
              },
              title: const Text("Esmaul Husna"),
              actions: getActions(context),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState>(
                      builder: (context, state){
                        if(state.isLoading){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final items = state.items;

                        if(items.isEmpty){
                          return const Center(
                            child: Text("Empty"),
                          );
                        }
                        return CustomScrollablePositionedList(
                          initialScrollIndex: initPos,
                          itemCount: items.length,
                          itemScrollController: _itemScrollController,
                          delayMilliSeconds: 50,
                          onScroll: (scrollDirection){
                            _scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
                          },
                          onVisibleItemChanged: (min,max){
                            _positionController.setPositions(min, max,totalItems: state.items.length);
                          },
                          itemBuilder: (context, index){
                            final item = items[index];
                            return EsmaulHusnaItem(
                              fontModel: state.fontModel,
                              esmaulHusna: item,
                              onClick: ()async{
                                await EsmaulHusnaDetailRoute(pos: item.order).push(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      NavigateToIcon(
        positionController: _positionController,
        onPosChanged: (selectedIndex){
          _itemScrollController.jumpTo(index: selectedIndex);
        },
      ),
      _topBarDropDownMenu(context)
    ];
  }

  Widget _topBarDropDownMenu(BuildContext context){
    return CustomDropdownIconMenu(
      items: ShowEsmaulHusnaTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case ShowEsmaulHusnaTopBarMenuItem.fontSize:
            showSelectFontSizeDia(context);
            break;
        }
      },
    );
  }
}
