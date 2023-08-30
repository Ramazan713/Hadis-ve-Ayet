import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/components/save_point_item.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';

class SavePointListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<SavePoint> items;
  final Function(SavePoint?) onSelectSavePoint;
  final SavePoint? selectedSavePoint;
  final Function(SavePoint,String)? onEditSavePoint;
  final Function(SavePoint)? onDeleteSavePoint;

  const SavePointListView({
    Key? key, required this.scrollController, required this.items,
    required this.onSelectSavePoint, this.selectedSavePoint,
    this.onEditSavePoint, this.onDeleteSavePoint
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

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
            isSelected: selectedSavePoint==item,
            onClick: (){
              onSelectSavePoint(item);
            },
            editTitleListener: (){
              if(onEditSavePoint == null) return;
              showEditTextDia(context, (newText){
                onEditSavePoint?.call(item,newText);
              },title: "Yeniden Adlandır",content: item.title);
            },removeItemListener: (){
              if(onDeleteSavePoint == null) return;
              showCustomAlertDia(context,title: "Silmek İstediğinize emin misiniz?",
                  btnApproved: (){
                    if(item.id == selectedSavePoint?.id){
                      onSelectSavePoint(null);
                    }
                    onDeleteSavePoint?.call(item);
                  });
            },),
        );
      },
      itemCount: items.length,
    );
  }
}
