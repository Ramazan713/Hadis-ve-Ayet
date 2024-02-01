
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_preview_share_image_handle_dia.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/esmaul_husna/domain/enums/esmaul_husna_share_menu_item.dart';
import 'package:hadith/features/esmaul_husna/domain/extensions/esmaul_husna_share_ext.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/presentation/components/detail_esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/presentation/components/esmaul_husna_item.dart';
import 'package:hadith/features/esmaul_husna/presentation/esmaul_husna_detail_page_content.dart';
import 'package:hadith/features/esmaul_husna/presentation/esmaul_husna_list_page_content.dart';


class ShowEsmaulHusnaPage extends StatefulWidget {
  final int initPos;

  const ShowEsmaulHusnaPage({
    Key? key,
    required this.initPos
  }) : super(key: key);

  @override
  State<ShowEsmaulHusnaPage> createState() => ShowEsmaulHusnaPageState();
}

class ShowEsmaulHusnaPageState extends State<ShowEsmaulHusnaPage> {

  final TextEditingController searchTextController = TextEditingController();
  final CustomPositionController detailPositionController = CustomPositionController();
  final CustomAutoScrollController listScrollController = CustomAutoScrollController(suggestedRowHeight: 250);
  late final PageController pageController;

  var offset = 0.0;
  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initPos;

    pageController = PageController(initialPage: currentPage);
    listScrollController.controller.addListener(_offsetListener);
    context.read<ShowEsmaulHusnaBloc>()
        .add(ShowEsmaulHusnaEventReStartState());

  }

  void _offsetListener(){
    EasyDebounce.debounce("ListScrollListener", const Duration(milliseconds: 350), () {
      offset = listScrollController.controller.offset;
    });
  }


  @override
  Widget build(BuildContext context) {
    return AdCheckWidget(
      child: getListeners(
        child: Scaffold(
          body: SafeArea(
            child: DefaultAdaptiveLayout(
              builder: (context, windowSizeClass){
                if(windowSizeClass.isExpanded){
                  return Row(
                    children: [
                      Expanded(
                        child: EsmaulHusnaListPageContent(
                          customAutoScrollController: listScrollController,
                          searchTextController: searchTextController,
                          initOffset: offset,
                          onOffsetChange: (off){
                            offset = off;
                          },
                          onIndexItemClick: (index){
                            currentPage = index;
                            pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          },
                          onShareClick: (item){
                            handleShareClick(item, false);
                          },
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: EsmaulHusnaDetailPageContent(
                          pageController: pageController,
                          positionController: detailPositionController,
                          isFullPage: false,
                          onShareClick: (item){
                            handleShareClick(item, true);
                          },
                          currentPage: currentPage,
                          onPageChange: (page){
                            currentPage = page;
                          },
                        ),
                      )
                    ],
                  );
                }

                return BlocSelector<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState,bool>(
                  selector: (state) => state.isDetailOpen,
                  builder: (context, isDetailOpen){
                    if(isDetailOpen){
                      return EsmaulHusnaDetailPageContent(
                        pageController: pageController,
                        positionController: detailPositionController,
                        isFullPage: true,
                        currentPage: currentPage,
                        onShareClick: (item){
                          handleShareClick(item, true);
                        },
                        onPageChange: (page){
                          currentPage = page;
                        },
                      );
                    }
                    return EsmaulHusnaListPageContent(
                      customAutoScrollController: listScrollController,
                      searchTextController: searchTextController,
                      initOffset: offset,
                      onShareClick: (item){
                        handleShareClick(item, false);
                      },
                      onOffsetChange: (off){
                        offset = off;
                      },
                      onIndexItemClick: (index){
                        currentPage = index;
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void handleShareClick(EsmaulHusna item, bool isDetail){
    final shareBloc = context.read<ShareBloc>();
    final fontModel = context.read<ShowEsmaulHusnaBloc>().state.fontModel;

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
            if(isDetail){
              showPreviewShareImageHandleDia(context,
                  onImageWidget: (key){
                    return DetailEsmaulHusnaRepaintItem(
                      fontModel: fontModel,
                      esmaulHusna: item,
                      repaintKey: key,
                    );
                  },
                  imageName: "${item.name}_detail.png"
              );
            }else{
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
            }

            break;
        }
      },
    );
  }

  Widget getListeners({required Widget child}){
    return MultiBlocListener(
        listeners: [
          BlocListener<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState>(
            listenWhen: (prevState, nextState){
              return prevState.message != nextState.message;
            },
            listener: (context, state){
              final message = state.message;
              if(message!=null){
                ToastUtils.showLongToast(message);
                context.read<ShowEsmaulHusnaBloc>()
                    .add(ShowEsmaulHusnaEventClearMessage());
              }
            },
          ),
          BlocListener<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState>(
            listenWhen: (prevState, nextState){
              return prevState.items.length != nextState.items.length;
            },
            listener: (context, state){
              listScrollController.setTotalItems(totalItems: state.items.length);
              detailPositionController.setTotalItems(state.items.length);
            },
          )
        ],
        child: child
    );
  }


  @override
  void dispose() {
    listScrollController.controller.removeListener(_offsetListener);
    searchTextController.dispose();
    detailPositionController.dispose();
    listScrollController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
