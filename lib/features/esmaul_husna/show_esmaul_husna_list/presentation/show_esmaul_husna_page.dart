
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_share_image_handle_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/enums/esmaul_husna_share_menu_item.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/extensions/esmaul_husna_share_ext.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/domain/enums/show_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/components/esmaul_husna_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ShowEsmaulHusnaPage extends StatefulWidget {
  final int initPos;

  const ShowEsmaulHusnaPage({
    Key? key,
    required this.initPos
  }) : super(key: key);

  @override
  State<ShowEsmaulHusnaPage> createState() => _ShowEsmaulHusnaPageState();
}

class _ShowEsmaulHusnaPageState extends State<ShowEsmaulHusnaPage> {

  final CustomScrollController scrollController = CustomScrollController();
  final CustomPositionController positionController = CustomPositionController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final TextEditingController searchTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowEsmaulHusnaBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocSelector<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState, bool>(
          selector: (state) => state.isSearchBarVisible,
          builder: (context, isSearchBarVisible){
            return CustomNestedSearchableAppBar(
              textEditingController: searchTextController,
              onSearchVisibilityChanged: (isSearchVisible){
                bloc.add(ShowEsmaulHusnaEventSetSearchBarVisibility(isVisible: isSearchVisible));
              },
              scrollController: scrollController,
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
                          return const SharedLoadingIndicator();
                        }
                        final items = state.items;

                        if(items.isEmpty){
                          return const SharedEmptyResult(
                            content: "herhangi bir sonuç bulunamadı",
                          );
                        }
                        return CustomScrollablePositionedList(
                          initialScrollIndex: widget.initPos,
                          itemCount: items.length,
                          itemScrollController: itemScrollController,
                          delayMilliSeconds: 50,
                          onScroll: (scrollDirection){
                            scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
                          },
                          onVisibleItemChanged: (min,max){
                            positionController.setPositions(min, max,totalItems: state.items.length);
                          },
                          itemBuilder: (context, index){
                            final item = items[index];
                            return EsmaulHusnaItem(
                              fontModel: state.fontModel,
                              esmaulHusna: item,
                              onClick: ()async{
                                await EsmaulHusnaDetailRoute(pos: item.order).push(context);
                              },
                              onShareClick: (){
                                _showAndHandleBottomMenu(context, item, state.fontModel);
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

  void _showAndHandleBottomMenu(BuildContext context,EsmaulHusna item, FontModel fontModel){
    final shareBloc = context.read<ShareBloc>();

    showShareAlertDia(context,
      items: EsmaulHusnaShareMenuItem.values,
      onSelected: (menuItem){
        final shareText = item.getShareShort();
        switch(menuItem){
          case EsmaulHusnaShareMenuItem.shareText:
            shareBloc.add(ShareEventShareText(text: shareText));
            break;
          case EsmaulHusnaShareMenuItem.copyText:
            shareBloc.add(ShareEventCopyText(text: shareText));
            break;
          case EsmaulHusnaShareMenuItem.shareImage:
            showPreviewShareImageHandleDia(context,
              imageName: "${item.name}.png",
              onImageWidget: (key){
                return EsmaulHusnaRepaintItem(
                  esmaulHusna: item,
                  fontModel: fontModel,
                  repaintKey: key,
                );
              }
            );
            break;
        }
      },
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      NavigateToIcon(
        positionController: positionController,
        onPosChanged: (selectedIndex){
          itemScrollController.jumpTo(index: selectedIndex);
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

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
    scrollController.dispose();
    positionController.dispose();
  }
}
