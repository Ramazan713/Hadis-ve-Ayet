import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/select_list/bloc/select_list_bloc.dart';
import 'package:hadith/core/features/select_list/bloc/select_list_event.dart';
import 'package:hadith/core/features/select_list/select_list_item.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'bloc/select_list_state.dart';


void showSelectListBottomDia(BuildContext context,{
  required int itemId,
  required SourceTypeEnum sourceType,
  int? listIdControl,
  void Function(bool currentListAffected)? onDataChanged
}) {

  final bloc = context.read<SelectListBloc>();
  bloc.add(SelectListEventLoadData(
      itemId: itemId,
      sourceType: sourceType,
      listIdControl: listIdControl
  ));

  Widget getListeners({required Widget child}){
    return BlocListener<SelectListBloc, SelectListState>(
      listener: (context, state){
        final message = state.message;
        final listAffected = state.listAffected;
        if(message!=null){
          ToastUtils.showLongToast(message);
          bloc.add(SelectListEventClearMessage());
        }
        if(listAffected!=null){
          onDataChanged?.call(listAffected);
          bloc.add(SelectListEventClearListAffected());
        }
      },
      child: child,
    );
  }

  showBottomSheetHandler(
    context: context,
    child: getListeners(
      child: DraggableScrollableSheet(
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollControllerDraggable) {
          return _DialogContent(
            controller: scrollControllerDraggable,
            onClosed: (){
              Navigator.of(context,rootNavigator: false).pop();
            },
          );
        },
      ),
    )
  );

}


class _DialogContent extends StatelessWidget {

  final ScrollController controller;
  final void Function() onClosed;

  const _DialogContent({
    Key? key,
    required this.controller,
    required this.onClosed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getHeader(context),
          const SizedBox(height: 8,),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getAddButton(context),
                  getContent()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getContent(){
    return BlocBuilder<SelectListBloc, SelectListState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return Center(
              child: getEmptyWidget(context)
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemBuilder: (context, index) {
            var item = state.items[index];

            return SelectListItem(
              isParentList: item.listViewModel.id == state.listIdControl,
              item: item,
              onClicked: (){
                final listAffected = item.listViewModel.id == state.listIdControl;
                if(item.isSelected && item.listViewModel.id == state.listIdControl){
                  showCustomAlertDia(context,
                      title: "Listeden kaldırmak istediğinize emin misiniz?",
                      content: "Bulunduğunuz listeyi etkileyecektir",
                      btnApproved: () {
                        context.read<SelectListBloc>()
                            .add(SelectListEventInsertOrDelete(item: item,listAffected: listAffected));
                      });
                }else{
                  context.read<SelectListBloc>()
                      .add(SelectListEventInsertOrDelete(item: item,listAffected: listAffected));
                }
              },

            );
          },
          itemCount: state.items.length,
        );
      },
    );
  }

  Widget getEmptyWidget(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.library_add,
          size: 70,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Yeni listeler ekleyin",
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }

  Widget getAddButton(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: FilledButton.tonal(
            onPressed: (){
              showEditTextDia(
                context, (label) {
                  context.read<SelectListBloc>()
                    .add(SelectListEventInsertNewList(listName: label));
                },
                title: "Liste ismi giriniz"
              );
            },
            child: const Text("Liste Ekle"),
        )
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "Liste Seçin",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onClosed,
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }
}
