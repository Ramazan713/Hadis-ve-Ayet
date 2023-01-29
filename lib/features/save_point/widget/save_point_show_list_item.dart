

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/dialogs/edit_text_bottom_dia.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_bloc.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_event.dart';
import 'package:hadith/features/save_point/widget/save_point_item.dart';
import 'package:hadith/utils/toast_utils.dart';

class SavePointShowListItem extends StatelessWidget {
  final ScrollController scrollController;
  final List<SavePoint>items;
  final Function(SavePoint?)onSelectSavePoint;
  final bool showOriginText;
  final SavePoint? selectedSavePoint;

  const SavePointShowListItem({Key? key, required this.scrollController, required this.items,
    required this.onSelectSavePoint, required this.showOriginText, this.selectedSavePoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savePointBloc = context.read<SavePointBloc>();
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      itemBuilder: (context, index) {
        final item = items[index];

        return GestureDetector(
          onTap: (){
            onSelectSavePoint(item);
          },
          child: SavePointItem(item: item,
            showOriginText: showOriginText,
            isSelected: selectedSavePoint==item,
            editTitleListener: (){
              showEditTextBottomDia(context, (newText){
                savePointBloc.add(SavePointEventRename(savePoint: item, newTitle: newText));
                ToastUtils.showLongToast("Yeniden İsimlendirildi");
              },title: "Yeniden Adlandır",content: item.title);
            },removeItemListener: (){
              showCustomAlertBottomDia(context,title: "Silmek İstediğinize emin misiniz?",
                  btnApproved: (){
                    onSelectSavePoint(null);
                    savePointBloc.add(SavePointEventDelete(savePoint: item));
                    ToastUtils.showLongToast("Silindi");
                  });
            },),
        );
      },
      itemCount: items.length,
    );
  }
}
