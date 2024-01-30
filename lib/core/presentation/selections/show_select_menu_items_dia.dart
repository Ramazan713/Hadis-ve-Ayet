

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';




void showSelectMenuItemsDia<T extends IMenuItem>(BuildContext context, {
  required List<T> items,
  required void Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false,
}){

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
    useRootNavigator: useRootNavigator,
    child: _DialogContent(
      items: items,
      onItemClick: onItemClick,
      title: title,
    ),
  );
}


void showSelectMenuItemsExtendedDia<T extends IMenuItem>(BuildContext context, {
  required void Function(T) onItemClick,
  required Widget Function({required Widget Function(List<T> newItems) updateItems}) wrapper,
  String? title,
  bool useRootNavigator = false,
}){

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
    useRootNavigator: useRootNavigator,
    child: wrapper(
      updateItems: (updatedItems){
        return _DialogContent(
          items: updatedItems,
          onItemClick: onItemClick,
          title: title,
        );
      },
    ),
  );
}

class _DialogContent<T extends IMenuItem> extends StatelessWidget {
  final List<T> items;
  final Function(T) onItemClick;
  final String? title;

  const _DialogContent({
    Key? key,
    required this.items,
    required this.onItemClick,
    this.title,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 7,bottom: 16,left: 6, right: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getTitle(context),
            Expanded(
              child: SingleChildScrollView(
                  child: getMenuItems()
              )
            )
          ],
        ),
      ),
    );
  }

  Widget getTitle(BuildContext context){
    if(title == null && items.length < 3 ) return const SizedBox(height: 7,);
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }

  Widget getMenuItems(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((item){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13)
            ),
            title: Text(item.title),
            leading: item.iconInfo?.toIcon(),
            onTap: (){
              onItemClick(item);
            },
          ),
        );
      }).toList(),
    );
  }
}
