import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/features/save_point/bloc/save_point_edit_state.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/features/save_point/widget/save_point_show_list_item.dart';
import 'package:hadith/utils/save_point_helper.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/scope_filter_enum.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/dialogs/edit_text_bottom_dia.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/save_point/bloc/save_point_edit_bloc.dart';
import 'package:hadith/features/save_point/bloc/save_point_edit_event.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'constants/save_auto_type.dart';
import 'save_point_bloc/save_point_bloc.dart';
import 'save_point_bloc/save_point_event.dart';

void showSelectSavePointBottomDia(BuildContext context, {
  required SavePointParam savePointParam,
  void Function(SavePoint savePoint)? changeLoaderListener,
  Widget Function(SavePoint?)? customBottomButtons,
  int? defaultSelectedSavePointId,
  String title = "Kayıt Noktaları",
  String?description
}) async {
  final isScopeOrigin = SavePointHelper.isScopeOrigin(savePointParam.originTag);
  final ScrollController scrollController = ScrollController();

  final editPointBloc = context.read<SavePointEditBloc>();

  editPointBloc
      .add(SavePointEditEventInitialRequest(savePointParam: savePointParam,savePointId: defaultSelectedSavePointId));

  List<DropdownMenuItem<ScopeFilterEnum>> getDropDownItems() {
    List<DropdownMenuItem<ScopeFilterEnum>> menuItems = [];
    for (var item in ScopeFilterEnum.values) {
      menuItems.add(DropdownMenuItem(
        value: item,
        child: Text(item.getDescription()),
      ));
    }
    return menuItems;
  }

  Widget getDropdownButton() {
    return isScopeOrigin
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: BlocSelector<SavePointEditBloc, SavePointEditState,
                ScopeFilterEnum?>(
              selector: (state) => state.scopeFilter,
              builder: (context, selectedFilter) {
                return DropdownButton<ScopeFilterEnum>(
                    items: getDropDownItems(),
                    value: selectedFilter,
                    onChanged: (selectedValue) {
                      if (selectedValue != null) {
                        editPointBloc.add(
                            SavePointEditEventChangeScopeFilter(selectedValue));
                      }
                    });
              },
            ),
          )
        : const SizedBox();
  }

  Widget getBottomButtons(){
    if(customBottomButtons!=null){
      return BlocSelector<SavePointEditBloc, SavePointEditState,SavePoint?>(
          selector: (state)=>state.selectedSavePoint,
          builder: (context,selectedSavePoint){
            return customBottomButtons(selectedSavePoint);
          }
      );
    }
    return Row(
      children: [
        Expanded(
          child: _LoadButton(savePointParam: savePointParam,changeLoaderListener: changeLoaderListener),
        ),
        Expanded(
          child: _OverrideSavePointButton(savePointParam: savePointParam,),
        )
      ],
    );
  }

  Widget getDescriptionWidget(){
    if(description == null){
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(description,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocListener<SavePointEditBloc, SavePointEditState>(
          listener: (context, state) {
            if (state.message != null) {
              ToastUtils.showLongToast(state.message ?? "");
            }
          },
          child: DraggableScrollableSheet(
            minChildSize: 0.2,
            initialChildSize: 0.5,
            maxChildSize: 1.0,
            expand: false,
            builder: (context, scrollControllerDraggable) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      controller: scrollControllerDraggable,
                      shrinkWrap: true,
                      slivers: [
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Row(
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
                          ),
                          Text(title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6),
                          const SizedBox(
                            height: 13,
                          ),
                              getDescriptionWidget(),
                          CustomButtonPositive(
                            onTap: () {
                              final date = DateTime.now();
                              final title = SavePointHelper.getAutoSavePointTitle(savePointParam, date.toString(),
                                  SaveAutoType.none);

                              showEditTextBottomDia(context, (newTitle) {
                                editPointBloc.add(SavePointEditEventInsert(
                                  title: newTitle,
                                  savePointParam: savePointParam,
                                  dateTime: date,
                                ));
                                ToastUtils.showLongToast(
                                    "Yeni Kayıt Oluşturuldu");
                              }, title: "Başlık Girin", content: title);
                            },
                            label: "Yeni kayıt oluştur",
                          ),
                          BlocBuilder<SavePointEditBloc, SavePointEditState>(
                            builder: (context, state) {
                              if (state.status == DataStatus.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final items = state.savePoints;

                              if (items.isEmpty) {
                                return Center(
                                  child: Text(
                                    "Herhangi bir kayıt bulunamadı",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                );
                              }
                              return SavePointShowListItem(
                                items: state.savePoints,
                                scrollController: scrollController,
                                showOriginText: false,
                                selectedSavePoint: state.selectedSavePoint,
                                onSelectSavePoint: (newSavePoint) {
                                  if (newSavePoint != null) {
                                    editPointBloc.add(
                                        SavePointEditEventChangeSavePoint(
                                            newSavePoint));
                                  }
                                },
                              );
                            },
                          )
                        ])),
                      ],
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


class _OverrideSavePointButton extends StatelessWidget{
  final SavePointParam savePointParam;
  const _OverrideSavePointButton({Key? key,required this.savePointParam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editPointBloc = context.read<SavePointEditBloc>();

    return BlocSelector<SavePointEditBloc,
        SavePointEditState, SavePoint?>(
      selector: (state) => state.selectedSavePoint,
      builder: (context, savePoint) {
        return CustomButtonPositive(
          onTap: () {
            if (savePoint != null) {
              if (SavePointHelper.isScopeSavePoint2(
                  savePoint, savePointParam)) {

                showCustomAlertBottomDia(context,
                    content:
                    "Farklı bir ${savePointParam.originTag.shortName.toLowerCase()} kayıt noktasının üzerine yazmak istediğinize emin misiniz",
                    btnApproved: () {
                      editPointBloc.add(
                          SavePointEditEventOverride(
                              selectedSavePoint: savePoint,
                              savePointParam: savePointParam));
                    });
              } else {
                editPointBloc.add(
                    SavePointEditEventOverride(
                        selectedSavePoint: savePoint,
                        savePointParam: savePointParam));
              }
            }
          },
          label: "Üzerine Yaz",
        );
      },
    );
  }

}

class _LoadButton extends StatelessWidget {
  final SavePointParam savePointParam;
  final Function(SavePoint savePoint)? changeLoaderListener;
  const _LoadButton({Key? key,required this.savePointParam,required this.changeLoaderListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocSelector<SavePointEditBloc,
        SavePointEditState, SavePoint?>(
      selector: (state) => state.selectedSavePoint,
      builder: (context, savePoint) {
        return CustomButtonPositive(
          onTap: () {
            if (savePoint != null) {
              final selectedId = savePoint.id;

              if (SavePointHelper.isScopeSavePoint2(
                  savePoint, savePointParam)) {
                showCustomAlertBottomDia(context,
                    content:
                    "Yeni bir cüz'e geçmek istediğinize emin misiniz",
                    btnApproved: () {
                      changeLoaderListener?.call(savePoint);
                      Navigator.pop(context);
                    });
              } else {
                final savePointBloc = context.read<SavePointBloc>();
                savePointBloc.add(
                    SavePointEventRequestWithId(savePointId: savePoint.id??0));
                Navigator.pop(context);
              }
            }
          },
          label: "Yükle",
        );
      },
    );
  }
}
