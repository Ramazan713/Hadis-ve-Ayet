
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/searchable_scroll_type.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/extensions/string_ext.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_base_dialog_sheet.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_header.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void showSelectSearchableItems<T extends ISearchableSelectItem>(BuildContext context,{
  required List<T> items,
  required void Function(T) onSelected,
  T? selectedItem,
  String? title,
  bool scrollToSelectedItem = true,
  SearchableScrollType scrollType = SearchableScrollType.filter
}){

  adaptiveBaseForDialogAndBottomSheet(
    context: context,
    baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
    child: _DialogContent(
      items: items,
      onSelected: onSelected,
      title: title,
      selectedItem: selectedItem,
      scrollToSelectedItem: scrollToSelectedItem,
      scrollType: scrollType,
      onClose: (){
        Navigator.pop(context);
      },
    ),
  );
}

class _DialogContent<T extends ISearchableSelectItem> extends StatefulWidget {

  final void Function() onClose;
  final List<T> items;
  final T? selectedItem;
  final void Function(T) onSelected;
  final String? title;
  final bool scrollToSelectedItem;
  final SearchableScrollType scrollType;

  const _DialogContent({
    super.key,
    required this.items,
    required this.onClose,
    required this.onSelected,
    required this.scrollToSelectedItem,
    required this.scrollType,
    this.title,
    this.selectedItem
  });

  @override
  State<_DialogContent<T>> createState() => _DialogContentState<T>();
}

class _DialogContentState<T extends ISearchableSelectItem> extends State<_DialogContent<T>> {
  final TextEditingController textEditingController = TextEditingController();

  final AutoScrollController scrollController = AutoScrollController(
    suggestedRowHeight: 60
  );

  final ValueNotifier<List<T>> searchedItemsNotifier = ValueNotifier([]);

  final ValueNotifier<T?> selectedItemNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();

    searchedItemsNotifier.value = widget.items;
    selectedItemNotifier.value = widget.selectedItem;

    final selectedItemPos = widget.items.indexWhere((element) => element.title == widget.selectedItem?.title);
    if(widget.scrollToSelectedItem){
      scrollToIndex(selectedItemPos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120,bottom: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4,),
                Flexible(child: getContent(context)),
                const SizedBox(height: 8,),
              ],
            ),
          ),
          Column(
            children: [
              SharedHeader(
                title: widget.title ?? "Item Seç",
                onClose: widget.onClose,
              ),
              const SizedBox(height: 4,),
              getTextField(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getButtonWidget(context)
            ],
          ),
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
              controller: scrollController,
              itemCount: searchedItems.length,
              itemBuilder: (context, index){
                final item = searchedItems[index];
                return AutoScrollTag(
                  key: ValueKey("${item.title}$index"),
                  index: index,
                  controller: scrollController,
                  child: CardListTile(
                    margins: const EdgeInsets.symmetric(vertical: 3,horizontal: 1),
                    title: Text(item.title),
                    isSelected: item.searchableText == selectedItem?.searchableText,
                    onTap: (){
                      selectedItemNotifier.value = item;
                    },
                    elevation: 1,
                    shadowColor: null,
                  ),
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
            widget.onSelected(selectedItem);
            widget.onClose();
          },
          child: const Text("Onayla"),
        );
      });
  }

  void search(String query){
    EasyDebounce.debounce("select-searchable-dia", const Duration(milliseconds: 300), () {
      if(query.isEmptyString){
        searchedItemsNotifier.value = widget.items;
      }else{
        if(widget.scrollType == SearchableScrollType.filter){
          searchedItemsNotifier.value = widget.items.where((e) => e.searchableText.contains(query.toLowerCase())).toList();
        }else{
          final index = widget.items.indexWhere((e) => e.searchableText.contains(query.toLowerCase()));
          scrollToIndex(index);
        }
      }
    });
  }

  void scrollToIndex(int index){
    if(index != -1){
      scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    searchedItemsNotifier.dispose();
    selectedItemNotifier.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
