


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

void showBottomMenuItems<T extends IMenuItem>(BuildContext context, {
  required List<T> items,
  required Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false
}){

  showModalBottomSheet(
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context){
        return _DialogContent(
          items: items,
          onItemClick: onItemClick,
          title: title,
        );
      }
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getTitle(context),
            ...getMenuItems(),
            const SizedBox(height: 4,)
          ],
        ),
      ),
    );
  }

  Widget getTitle(BuildContext context){
    if(title == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 2,bottom: 8),
      child: Text(
        title ?? "",
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> getMenuItems(){
    return items.map((e){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)
          ),
          title: Text(e.title),
          leading: e.iconInfo?.toIcon(),
          onTap: (){
            onItemClick(e);
          },
        ),
      );
    }).toList();
  }
}
