
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/extensions/string_ext.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/core/presentation/components/shared_components/shared_header.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';

void showSelectSearchableItems<T extends ISearchableSelectItem>(BuildContext context,{
  required List<T> items,
  required void Function(T) onSelected,
  T? selectedItem,
  String? title,
}){

  showDialog(
    context: context,
    builder: (context){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: _DialogContent(
          items: items,
          onSelected: onSelected,
          title: title,
          selectedItem: selectedItem,
          onClose: (){
            Navigator.pop(context);
          },
        ),
      );
    }
  );
}

class _DialogContent<T extends ISearchableSelectItem> extends StatelessWidget {

  final void Function() onClose;
  final List<T> items;
  final T? selectedItem;
  final void Function(T) onSelected;
  final String? title;

  _DialogContent({
    super.key,
    required this.items,
    required this.onClose,
    required this.onSelected,
    this.title,
    this.selectedItem
  });

  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<List<T>> searchedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<T?> selectedItemNotifier = ValueNotifier(null);


  @override
  Widget build(BuildContext context) {

    searchedItemsNotifier.value = items;
    selectedItemNotifier.value = selectedItem;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              SharedHeader(
                title: title ?? "Item Seç",
                onClose: onClose,
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 4,),
                  getTextField(),
                  const SizedBox(height: 4,),
                  getContent(context),
                  const SizedBox(height: 8,),
                ],
              ),
            )
          ),
          getButtonWidget(context),
        ],
      ),
    );
  }

  Widget getTextField(){
    return CustomFormTextField(
      controller: textEditingController,
      hintText: "Ara",
      onChanged: (query){
        search(query??"");
      },
    );
  }

  Widget getContent(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: searchedItemsNotifier,
      builder: (context, searchedItems, child){
        if(searchedItems.isEmpty){
          return const SharedEmptyResult(
            paddings: EdgeInsets.symmetric(vertical: 10,horizontal: 4),
          );
        }

        return ValueListenableBuilder(
          valueListenable: selectedItemNotifier,
          builder: (context, selectedItem, child){
            return ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              itemCount: searchedItems.length,
              itemBuilder: (context, index){
                final item = searchedItems[index];
                return CardListTile(
                  margins: const EdgeInsets.symmetric(vertical: 3,horizontal: 1),
                  title: Text(item.title),
                  isSelected: item == selectedItem,
                  onTap: (){
                    selectedItemNotifier.value = item;
                  },
                  elevation: 1,
                  shadowColor: null,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget getButtonWidget(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: selectedItemNotifier,
      builder: (context, selectedItem, child){
        return FilledButton(
          onPressed: selectedItem == null ? null : (){
            onSelected(selectedItem);
            onClose();
          },
          child: const Text("Onayla"),
        );
      });
  }

  void search(String query){
    EasyDebounce.debounce("select-searchable-dia", const Duration(milliseconds: 300), () {
      if(query.isEmptyString){
        searchedItemsNotifier.value = items;
      }else{
        searchedItemsNotifier.value = items.where((e) => e.searchableText.contains(query.toLowerCase())).toList();
      }
    });
  }

}
