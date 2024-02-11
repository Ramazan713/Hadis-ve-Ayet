
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/features/save_point/domain/enums/local_destination_scope.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/presentation/components/save_point_list_view.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/bloc/edit_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/bloc/edit_save_point_event.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/bloc/edit_save_point_state.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/core/presentation/selections/custom_segmented_button.dart';
import 'package:hadith/core/utils/toast_utils.dart';


void showEditSavePointsDiaGetApprovedSavePoint(BuildContext context, {
  required SavePointDestination destination,
  required int itemIndexPos,
  required void Function(SavePoint savePoint) onSelectedSavePoint,
  int? selectedSavePointId,
  LocalDestinationScope? initScope,
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
      scope: initScope,
      useWideScope: true,
      customBottomButtons: (savePoint){
        return FilledButton(
          onPressed: savePoint == null ? null : (){
            onSelectedSavePoint(savePoint);
            Navigator.pop(context);
          },
          child: const Text("Onayla")
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
  String? title,
  LocalDestinationScope? initScope
})async{
  showEditSavePointsDiaCustom(
    context,
    destination: destination,
    itemIndexPos: itemIndexPos,
    scope: initScope,
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
  LocalDestinationScope? initScope,
  bool? useWideScopeNaming,
  String? description,
  String? title
})async{
  showEditSavePointsDiaCustom(
      context,
      destination: destination,
      scope: initScope,
      itemIndexPos: itemIndexPos,
      selectedSavePointId: selectedSavePointId,
      onLoadSavePointClick: onLoadSavePointClick,
      onOverrideSavePointRequestHandler: onOverrideSavePointRequestHandler,
      onLoadSavePointRequestHandler: onLoadSavePointRequestHandler,
      useWideScope: true,
      useWideScopeNaming: useWideScopeNaming,
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
  bool? useWideScopeNaming,
  String? customTitle,
  String? description,
  LocalDestinationScope? scope,
  Widget Function(SavePoint?)? customBottomButtons
}) async {

  final title = customTitle ?? "Kayıt Noktaları";

  final editPointBloc = context.read<EditSavePointBloc>();

  editPointBloc.add(EditSavePointEventLoadData(
      destination: destination,
      selectedSavePointId: selectedSavePointId,
      position: itemIndexPos,
      scope: scope
  ));

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    child: _DialogContent(
      controller: ScrollController(),
      title: title,
      destination: destination,
      itemIndexPos: itemIndexPos,
      customBottomButtons: customBottomButtons,
      description: description,
      onLoadSavePointClick: onLoadSavePointClick,
      onLoadSavePointRequestHandler: onLoadSavePointRequestHandler,
      onOverrideSavePointRequestHandler: onLoadSavePointRequestHandler,
      selectedSavePointId: selectedSavePointId,
      useWideScope: useWideScope,
      useWideScopeNaming: useWideScopeNaming,
      flexFit: FlexFit.loose,
    ),
    bottomSheetChild: DraggableScrollableSheet(
      minChildSize: 0.4,
      initialChildSize: 0.5,
      maxChildSize: 0.99,
      expand: false,
      builder: (context, scrollControllerDraggable) {
        return _DialogContent(
          controller: scrollControllerDraggable,
          title: title,
          destination: destination,
          itemIndexPos: itemIndexPos,
          customBottomButtons: customBottomButtons,
          description: description,
          onLoadSavePointClick: onLoadSavePointClick,
          onLoadSavePointRequestHandler: onLoadSavePointRequestHandler,
          onOverrideSavePointRequestHandler: onLoadSavePointRequestHandler,
          selectedSavePointId: selectedSavePointId,
          useWideScope: useWideScope,
          useWideScopeNaming: useWideScopeNaming,
          flexFit: FlexFit.tight,
        );
      },
    )
  );
}


class _DialogContent extends StatelessWidget {

  final ScrollController controller;
  final SavePointDestination destination;
  final int itemIndexPos;
  final void Function(SavePoint savePoint, bool differentLocation)? onLoadSavePointClick;
  final void Function(void Function(bool))? onOverrideSavePointRequestHandler;
  final void Function(void Function(bool))? onLoadSavePointRequestHandler;
  final int? selectedSavePointId;
  final bool useWideScope;
  final bool? useWideScopeNaming;
  final String? description;
  final Widget Function(SavePoint?)? customBottomButtons;
  final String title;
  final FlexFit flexFit;

  const _DialogContent({
    Key? key,
    required this.destination,
    required this.itemIndexPos,
    required this.controller,
    required this.title,
    required this.flexFit,
    this.onLoadSavePointClick,
    this.onOverrideSavePointRequestHandler,
    this.onLoadSavePointRequestHandler,
    this.selectedSavePointId,
    this.useWideScope = false,
    this.useWideScopeNaming,
    this.description,
    this.customBottomButtons
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            getHeader(context),
            Flexible(
              fit: flexFit,
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getDescriptionWidget(context),
                    const SizedBox(height: 8,),
                    getHeaderButtons(context),
                    getContent()
                  ],
                ),
              ),
            ),
            getBottomButtons(context)
          ],
        ),
      ),
    );
  }

  Widget getHeaderButtons(BuildContext context){
    final menuWidget = getFilterMenu(context);
    if(menuWidget == null) return getAddSavePointWidget(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            menuWidget,
            const SizedBox(width: 8,),
            getAddSavePointWidget(context)
          ],
        ),
      ),
    );
  }

  Widget? getFilterMenu(BuildContext context) {
    if(!useWideScope) return null;
    final bloc = context.read<EditSavePointBloc>();
    return BlocSelector<EditSavePointBloc, EditSavePointState, LocalDestinationScope>(
      selector: (state) => state.localScope,
      builder: (context, selectedFilter) {
        return SingleSelectSegmentedButton<LocalDestinationScope>(
          items: LocalDestinationScope.values,
          selectedItem: selectedFilter,
          onSelected: (selectedItem){
            bloc.add(EditSavePointEventChangeDestinationScope(scope: selectedItem));
          },
        );
      },
    );
  }


  //header contains close, dropdownButton,
  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
            )
          ),
        )
      ],
    );
  }


  Widget getDescriptionWidget(BuildContext context){
    if(description == null){
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        description ?? "",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  // button for adding new savePoints
  Widget getAddSavePointWidget(BuildContext context){
    final bloc = context.read<EditSavePointBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: FilledButton.tonal(
          onPressed: (){
            final date = DateTime.now();
            final title = SavePoint.getAutoSavePointTitle(
                destination,
                date: date.toString(),
                useLocalWideScope: useWideScopeNaming ?? useWideScope
            );
            showEditTextDia(
              context, (newTitle) {
                bloc.add(EditSavePointEventInsert(
                  title: newTitle,
                  dateTime: date,
                ));
              },
              title: "Başlık Girin",
              content: title
            );
          },
          child: const Text("Yeni kayıt oluştur")
      ),
    );
  }

  // get content of savePoint items
  Widget getContent(){
    return BlocBuilder<EditSavePointBloc, EditSavePointState>(
      builder: (context, state) {
        final items = state.savePoints;
        if (items.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: SharedEmptyResult(
              content: "Herhangi bir kayıt bulunamadı",
            ),
          );
        }
        final bloc = context.read<EditSavePointBloc>();
        return SavePointListView(
          items: state.savePoints,
          scrollController: ScrollController(),
          selectedSavePoint: state.selectedSavePoint,
          onSelectSavePoint: (savePoint) {
            bloc.add(EditSavePointEventSelect(savePoint: savePoint));
          },
          onEditSavePoint: (savePoint,title){
            bloc.add(EditSavePointEventRename(savePoint: savePoint,newTitle: title));
          },
          onDeleteSavePoint: (savePoint){
            bloc.add(EditSavePointEventDelete(savePoint: savePoint));
          },
        );
      },
    );
  }

  // bottom buttons
  Widget getBottomButtons(BuildContext context){
    final bloc = context.read<EditSavePointBloc>();
    return BlocSelector<EditSavePointBloc, EditSavePointState,SavePoint?>(
        selector: (state) => state.selectedSavePoint,
        builder: (context,selectedSavePoint){
          if(customBottomButtons != null){
            return customBottomButtons!.call(selectedSavePoint);
          }
          return Row(
            children: [
              const SizedBox(width: 8,),
              Expanded(
                child: FilledButton(
                  onPressed: selectedSavePoint == null ? null : (){
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
                  child: const Text("Yükle"),
                ),
              ),
              const SizedBox(width: 8,),
              Expanded(
                child: FilledButton(
                  onPressed: selectedSavePoint == null ? null : (){
                    if(useWideScope && selectedSavePoint.destination.getParentKey()!=destination.getParentKey()){
                      onOverrideSavePointRequestHandler?.call((result){
                        if(result){
                          bloc.add(EditSavePointEventOverride(selectedSavePoint: selectedSavePoint));
                        }
                      });
                    }else{
                      bloc.add(EditSavePointEventOverride(selectedSavePoint: selectedSavePoint));
                    }
                  },
                  child: const Text("Üzerine Yaz"),
                ),
              ),
              const SizedBox(width: 8,),
            ],
          );
        }
    );
  }


  Widget getListeners({required Widget child}){
    return BlocListener<EditSavePointBloc, EditSavePointState>(
      listener: (context, state) {
        final message = state.message;
        if (message != null) {
          ToastUtils.showLongToast(message);
          context.read<EditSavePointBloc>()
              .add(EditSavePointEventClearMessage());
        }
      },
      child: child,
    );
  }

}

