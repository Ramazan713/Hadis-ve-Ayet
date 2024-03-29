
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';

void showCustomExtendBottomMenuItems<T extends IMenuItem>(BuildContext context, {
  required Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false,
  required Widget Function({required Widget Function(List<T> newItems) updateItems}) wrapper
}){

  showBottomSheetHandler(
    context: context,
    useRootNavigator: useRootNavigator,
    child: wrapper(
      updateItems: (newItems){
        return _DialogContent(
          items: newItems,
          onItemClick: onItemClick,
          title: title,
        );
      },
    )
  );
}


void showBottomMenuItems<T extends IMenuItem>(BuildContext context, {
  required List<T> items,
  required void Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false,
}){

  showBottomSheetHandler(
    context: context,
    useRootNavigator: useRootNavigator,
    child: _DialogContent(
      items: items,
      onItemClick: onItemClick,
      title: title,
    )
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
