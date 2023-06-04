import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/select_list/bloc/select_list_bloc.dart';
import 'package:hadith/core/features/select_list/bloc/select_list_event.dart';
import 'package:hadith/core/features/select_list/select_list_item.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/dialogs/edit_text_bottom_dia.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/icon_text_button_side.dart';
import 'bloc/select_list_state.dart';


void showSelectListBottomDia(
    BuildContext context,
{
  required int itemId,
  required SourceTypeEnum sourceType,
  int? listIdControl,
  void Function()? onClosed
}) async {

  final ScrollController scrollController = ScrollController();

  final bloc = context.read<SelectListBloc>();

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

  Widget getHeader(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 7,
        ),
        Text(
          "Liste Seçin",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 13,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 13, vertical: 7),
            child: IconTextButtonSide(
              iconData: Icons.add,
              title: "Liste Ekle",
              onPress: () {
                showEditTextBottomDia(context, (label) {
                  bloc.add(SelectListEventInsertNewList(listName: label));
                }, title: "Liste ismi giriniz");
              },
            )),
      ],
    );
  }

  await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (context) {

        bloc.add(SelectListEventLoadData(itemId: itemId, sourceType: sourceType,
            listIdControl: listIdControl));

        return BlocListener<SelectListBloc, SelectListState>(
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(SelectListEventClearMessage());
            }
          },
          child: DraggableScrollableSheet(
            minChildSize: 0.2,
            expand: false,
            builder: (context, scrollControllerDraggable) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      shrinkWrap: true,
                      controller: scrollControllerDraggable,
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            getHeader(),

                            BlocBuilder<SelectListBloc, SelectListState>(
                              builder: (context, state) {

                                if (state.items.isEmpty) {
                                  return Center(
                                      child: getEmptyWidget(context));
                                }

                                return ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var item = state.items[index];

                                    return SelectListItem(
                                      onClicked: (){
                                        if(item.isSelected && item.listViewModel.id == state.listIdControl){
                                          showCustomAlertBottomDia(context,
                                              title: "Listeden kaldırmak istediğinize emin misiniz?",
                                              content: "Bulunduğunuz listeyi etkileyecektir",
                                              btnApproved: () {
                                                bloc.add(SelectListEventInsertOrDelete(item: item));
                                              });
                                        }else{
                                          bloc.add(SelectListEventInsertOrDelete(item: item));
                                        }
                                      },
                                      isParentList: item.listViewModel.id == state.listIdControl,
                                      item: item,
                                    );
                                  },
                                  itemCount: state.items.length,
                                );
                              },
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  CustomButtonPositive(onTap: () {
                   context.pop();
                  }),
                ],
              );
            },
          ),
        );
      }).whenComplete((){
    onClosed?.call();
  });
}
