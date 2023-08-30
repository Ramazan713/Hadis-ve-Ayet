


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/local_destination_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/components/save_point_list_view.dart';
import 'package:hadith/core/features/save_point/edit_save_point/bloc/edit_save_point_bloc.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

import 'bloc/edit_save_point_event.dart';
import 'bloc/edit_save_point_state.dart';


void showEditSavePointsDiaGetApprovedSavePoint(BuildContext context, {
  required SavePointDestination destination,
  required int itemIndexPos,
  required void Function(SavePoint savePoint) onSelectedSavePoint,
  int? selectedSavePointId,
  String? description,
  String? title
}){
  showEditSavePointsDiaCustom(
      context,
      destination: destination,
      itemIndexPos: itemIndexPos,
      selectedSavePointId: selectedSavePointId,
      description: description,
      customTitle: title,
      useWideScope: false,
      customBottomButtons: (savePoint){
        return CustomButtonPositive(
          onTap: (){
            if(savePoint!=null){
              onSelectedSavePoint(savePoint);
              Navigator.pop(context);
            }
          },
          label: "Onayla",
        );
      }
  );
}

void showEditSavePointsDiaBasic(BuildContext context, {
  required SavePointDestination destination,
  required int itemIndexPos,
  void Function(SavePoint savePoint)? onLoadSavePointClick,
  int? selectedSavePointId,
  String? description,
  String? title
})async{
  showEditSavePointsDiaCustom(
    context,
    destination: destination,
    itemIndexPos: itemIndexPos,
    selectedSavePointId: selectedSavePointId,
    onLoadSavePointClick: (savePoint, differentLocation){
      onLoadSavePointClick?.call(savePoint);
    },
    description: description,
    useWideScope: false,
    customTitle: title
  );
}

void showEditSavePointsDiaAdvanced(BuildContext context, {
  required SavePointDestination destination,
  required int itemIndexPos,
  required void Function(SavePoint savePoint, bool differentLocation) onLoadSavePointClick,
  required void Function(void Function(bool)) onOverrideSavePointRequestHandler,
  required void Function(void Function(bool)) onLoadSavePointRequestHandler,
  int? selectedSavePointId,
  String? description,
  String? title
})async{
  showEditSavePointsDiaCustom(
      context,
      destination: destination,
      itemIndexPos: itemIndexPos,
      selectedSavePointId: selectedSavePointId,
      onLoadSavePointClick: onLoadSavePointClick,
      onOverrideSavePointRequestHandler: onOverrideSavePointRequestHandler,
      onLoadSavePointRequestHandler: onLoadSavePointRequestHandler,
      useWideScope: true,
      description: description,
      customTitle: title
  );
}


void showEditSavePointsDiaCustom(BuildContext context, {
  required SavePointDestination destination,
  required int itemIndexPos,
  void Function(SavePoint savePoint, bool differentLocation)? onLoadSavePointClick,
  void Function(void Function(bool))? onOverrideSavePointRequestHandler,
  void Function(void Function(bool))? onLoadSavePointRequestHandler,
  int? selectedSavePointId,
  bool useWideScope = false,
  String? customTitle,
  String? description,
  Widget Function(SavePoint?)? customBottomButtons
}) async {

  final title = customTitle ?? "Kayıt Noktaları";

  final ScrollController scrollController = ScrollController();

  final editPointBloc = context.read<EditSavePointBloc>();

  editPointBloc.add(EditSavePointEventLoadData(
      destination: destination,
      selectedSavePointId: selectedSavePointId,
      position: itemIndexPos
  ));

  List<DropdownMenuItem<LocalDestinationScope>> getDropDownItems() {
    List<DropdownMenuItem<LocalDestinationScope>> menuItems = [];
    for (var item in LocalDestinationScope.values) {
      menuItems.add(DropdownMenuItem(
        value: item,
        child: Text(
            item.getDescription(),
            style: Theme.of(context).textTheme.bodyLarge,
        ),
      ));
    }
    return menuItems;
  }

  Widget getDescriptionWidget(BuildContext context, String? description){
    if(description == null){
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget getDropdownButton() {
    if(!useWideScope) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: BlocSelector<EditSavePointBloc, EditSavePointState, LocalDestinationScope>(
        selector: (state) => state.localScope,
        builder: (context, selectedFilter) {
          return DropdownButton<LocalDestinationScope>(
              items: getDropDownItems(),
              value: selectedFilter,
              onChanged: (scope) {
                if (scope != null) {
                  editPointBloc.add(EditSavePointEventChangeDestinationScope(scope: scope));
                }
              });
        },
      ),
    );
  }

  // bottom buttons
  Widget getBottomButtons(){
    return BlocSelector<EditSavePointBloc, EditSavePointState,SavePoint?>(
        selector: (state) => state.selectedSavePoint,
        builder: (context,selectedSavePoint){
          if(customBottomButtons != null){
            return customBottomButtons.call(selectedSavePoint);
          }

          return Row(
            children: [
              Expanded(
                child: CustomButtonPositive(
                  label: "Yükle",
                  onTap: (){
                    if(selectedSavePoint == null) return;
                    if(useWideScope && selectedSavePoint.destination.getParentKey()!=destination.getParentKey()){
                      onLoadSavePointRequestHandler?.call((result){
                        if(result){
                          onLoadSavePointClick?.call(selectedSavePoint,true);
                        }
                      });
                    }else{
                      onLoadSavePointClick?.call(selectedSavePoint,false);
                    }
                  },
                ),
              ),
              Expanded(
                child: CustomButtonPositive(
                  label: "Üzerine Yaz",
                  onTap: (){
                    if(selectedSavePoint == null) return;
                    if(useWideScope && selectedSavePoint.destination.getParentKey()!=destination.getParentKey()){
                      onOverrideSavePointRequestHandler?.call((result){
                        if(result){
                          editPointBloc.add(EditSavePointEventOverride(selectedSavePoint: selectedSavePoint));
                        }
                      });
                    }else{
                      editPointBloc.add(EditSavePointEventOverride(selectedSavePoint: selectedSavePoint));
                    }
                  },
                ),
              )
            ],
          );
        }
    );
  }


  //header contains close, dropdownButton,
  Widget getTopHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getDropdownButton(),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 27,
            ))
      ],
    );
  }

  //header contains title and description
  Widget getHeaderDescription(){
    return Column(
      children: [
        Text(title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6),
        const SizedBox(
          height: 13,
        ),
        getDescriptionWidget(context, description),
      ],
    );
  }

  // button for adding new savePoints
  Widget getAddSavePointWidget(){
    return CustomButtonPositive(
      onTap: () {
        final date = DateTime.now();
        final title = SavePoint.getAutoSavePointTitle(destination, date: date.toString(),
            useLocalWideScope: useWideScope);

        showEditTextDia(context, (newTitle) {
          editPointBloc.add(EditSavePointEventInsert(
            title: newTitle,
            dateTime: date,
          ));
        }, title: "Başlık Girin", content: title);
      },
      label: "Yeni kayıt oluştur",
    );
  }

  // get content of savePoint items
  Widget getContent(EditSavePointState state){
    final items = state.savePoints;

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Text(
            "Herhangi bir kayıt bulunamadı",
            style:
            Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return SavePointListView(
      items: state.savePoints,
      scrollController: scrollController,
      selectedSavePoint: state.selectedSavePoint,
      onSelectSavePoint: (savePoint) {
        editPointBloc.add(EditSavePointEventSelect(savePoint: savePoint));
      },
      onEditSavePoint: (savePoint,title){
        editPointBloc.add(EditSavePointEventRename(savePoint: savePoint,newTitle: title));
      },
      onDeleteSavePoint: (savePoint){
        editPointBloc.add(EditSavePointEventDelete(savePoint: savePoint));
      },
    );
  }


  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {

        return BlocListener<EditSavePointBloc, EditSavePointState>(
          listener: (context, state) {
            if (state.message != null) {
              ToastUtils.showLongToast(state.message ?? "");
              editPointBloc.add(EditSavePointEventClearMessage());
            }
          },
          child: DraggableScrollableSheet(
            minChildSize: 0.4,
            initialChildSize: 0.5,
            maxChildSize: 0.99,
            expand: false,
            builder: (context, scrollControllerDraggable) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTopHeader(),

                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollControllerDraggable,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          getHeaderDescription(),
                          getAddSavePointWidget(),
                          BlocBuilder<EditSavePointBloc, EditSavePointState>(
                            builder: (context, state) {
                              return getContent(state);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  getBottomButtons()
                ],
              );
            },
          ),
        );
      });
}
