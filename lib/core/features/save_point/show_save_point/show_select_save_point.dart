import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/components/save_point_list_view.dart';
import 'package:hadith/core/features/save_point/show_save_point/bloc/show_save_point_event.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_text_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/utils/toast_utils.dart';

import '../handler/save_point_navigate_handler.dart';
import 'bloc/show_save_point_bloc.dart';
import 'bloc/show_save_point_state.dart';


void showSelectSavePointsWithScopes(BuildContext context, {
    required String shortTitle,
    required List<SavePointType> menuItems,
    required List<BookScopeEnum> scopes,
}){
  context.read<ShowSavePointBloc>()
      .add(ShowSavePointEventLoadBookData(scopes: scopes, filter: null));

  _showSelectSavePoints(
    context,
    shortTitle: shortTitle,
    menuItems: menuItems,
  );
}

void showSelectSavePoints(BuildContext context, {
    required String shortTitle,
    required SavePointType savePointType,
    BookScopeEnum? bookScope,
}){

  context.read<ShowSavePointBloc>()
      .add(ShowSavePointEventLoadTypeData(savePointType: savePointType,scope: bookScope));

  _showSelectSavePoints(
      context,
      shortTitle: shortTitle,
      menuItems: [],
  );
}


void _showSelectSavePoints(BuildContext context, {
  required String shortTitle,
  required List<SavePointType> menuItems,
}){

  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return DraggableScrollableSheet(
        minChildSize: 0.5,
        initialChildSize: 0.7,
        maxChildSize: 0.99,
        expand: false,
        builder: (context, scrollControllerDraggable) {
          return _DialogContent(
            controller: scrollControllerDraggable,
            menuItems: menuItems,
            shortTitle: shortTitle,
          );
        },
      );
    }
  );
}


class _DialogContent extends StatelessWidget {

  final String shortTitle;
  final List<SavePointType> menuItems;
  final ScrollController controller;

  const _DialogContent({
    Key? key,
    required this.shortTitle,
    required this.menuItems,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<ShowSavePointBloc>();

    return getListeners(
      child: Padding(
        padding: const EdgeInsets.only(top: 7,left: 5,right: 5,bottom: 3),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      getDropdownMenu(context),
                      BlocBuilder<ShowSavePointBloc,ShowSavePointState>(
                        builder: (context,state){
                          if(state.status == DataStatus.loading){
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 19),
                              child: SharedLoadingIndicator()
                            );
                          }
                          final items = state.savePoints;

                          if(items.isEmpty){
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 19),
                              child: SharedEmptyResult(
                                content: "Herhangi bir kayıt bulunamadı",
                              ),
                            );
                          }
                          return SavePointListView(
                            items: state.savePoints,
                            scrollController: ScrollController(),
                            selectedSavePoint: state.selectedSavePoint,
                            onDeleteSavePoint: (item){
                              bloc.add(ShowSavePointEventDelete(savePoint: item));
                            },
                            onEditSavePoint: (item,newTitle){
                              bloc.add(ShowSavePointEventRename(savePoint: item,newTitle: newTitle));
                            },
                            onSelectSavePoint: (item){
                              bloc.add(ShowSavePointEventSelect(savePoint: item));
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              getBottomButton(context)
            ],
          ),
      ),
    );
  }


  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "$shortTitle Kayıt Noktaları",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.close,
              size: 27,
            )
          ),
        )
      ],
    );
  }


  Widget getBottomButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: BlocSelector<ShowSavePointBloc,ShowSavePointState,SavePoint?>(
        selector: (state)=>state.selectedSavePoint,
        builder: (context, selectedSavePoint){
          return FilledButton(
            onPressed: selectedSavePoint == null ? null : (){
              context.pop();
              savePointNavigateHandlerWithSavePoint(context, savePoint: selectedSavePoint);
            },
            child: const Text("Yükle ve Git")
          );
        },
      ),
    );
  }

  Widget getDropdownMenu(BuildContext context){
    if(menuItems.isEmpty) {
      return const SizedBox();
    }
    final bloc = context.read<ShowSavePointBloc>();
    return Padding(
      padding: const EdgeInsets.only(left: 5,top: 5,bottom: 3),
      child: BlocSelector<ShowSavePointBloc,ShowSavePointState,SavePointType?>(
        selector: (state)=>state.selectedMenuItem,
        builder: (context,selectedOriginTag){
          return CustomDropdownTextMenu(
            selectedItem: selectedOriginTag,
            items: menuItems,
            addEmptyItem: true,
            onSelected: (selected){
              bloc.add(ShowSavePointEventChangeMenuItem(savePointType: selected));
            },
          );
        },
      ),
    );

  }


  Widget getListeners({required Widget child}){
    return BlocListener<ShowSavePointBloc,ShowSavePointState>(
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          context.read<ShowSavePointBloc>()
              .add(ShowSavePointEventClearMessage());
        }
      },
      child: child,
    );
  }

}
