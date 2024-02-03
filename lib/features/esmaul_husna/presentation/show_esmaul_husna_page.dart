
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/list_detail_adaptive_layout.dart';
import 'package:hadith/core/features/adaptive/presentation/list_detail_adaptive_layout_with_controller.dart';
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
import 'package:scroll_to_index/scroll_to_index.dart';


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
  CustomAutoScrollController? listScrollController;
  PageController? pageController;

  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initPos;
    final bloc = context.read<ShowEsmaulHusnaBloc>();
    bloc.add(ShowEsmaulHusnaEventReStartState());

    detailPositionController.setTotalItems(bloc.state.items.length);
  }

  @override
  Widget build(BuildContext context) {
    return AdCheckWidget(
      child: getListeners(
        child: Scaffold(
          body: SafeArea(
            child: ListDetailAdaptiveLayoutWithController(
              useAdaptivePadding: true,
              useDetailOffset: false,
              onDetailOffsetListener: (){
                currentPage = pageController?.page?.toInt() ?? currentPage;
              },
              onCreateListController: (offset){
                return AutoScrollController(
                  initialScrollOffset: offset,
                  suggestedRowHeight: 250
                );
              },
              onCreateDetailController: (offset){
                return PageController(initialPage: currentPage);
              },
              onListWidget: (controller, isSinglePane){
                return EsmaulHusnaListPageContent(
                  customAutoScrollController: _setAndGetController(controller),
                  searchTextController: searchTextController,
                  onIndexItemClick: (index){
                    currentPage = index;
                    pageController?.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                  onShareClick: (item){
                    handleShareClick(item, false);
                  },
                );
              },
              onDetailWidget: (controller, isSinglePane){
                pageController = controller as PageController;
                return EsmaulHusnaDetailPageContent(
                  pageController: pageController!,
                  positionController: detailPositionController,
                  isFullPage: isSinglePane,
                  onShareClick: (item){
                    handleShareClick(item, true);
                  },
                  currentPage: currentPage,
                  onPageChange: (page){
                    currentPage = page;
                  },
                );
              },
              onShowDetailInSinglePaneBuilder: (onShowDetailResult){
                return BlocSelector<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState,bool>(
                  selector: (state) => state.isDetailOpen,
                  builder: (context, isDetailOpen){
                    return onShowDetailResult(isDetailOpen);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  CustomAutoScrollController _setAndGetController(ScrollController? controller){
    listScrollController = controller == null ? CustomAutoScrollController() :
        CustomAutoScrollController(autoScrollController: controller as AutoScrollController);
    final itemCount = context.read<ShowEsmaulHusnaBloc>().state.items.length;
    listScrollController!.setTotalItems(totalItems: itemCount);
    return listScrollController!;
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
              detailPositionController.setTotalItems(state.items.length);
            },
          )
        ],
        child: child
    );
  }


  @override
  void dispose() {
    searchTextController.dispose();
    detailPositionController.dispose();
    super.dispose();
  }
}
