


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/searchable_scroll_type.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/extensions/text_editing_controller_ext.dart';
import 'package:hadith/core/presentation/components/text_field/custom_form_text_field.dart';
import 'package:hadith/core/presentation/selections/show_select_searchable_items.dart';

class CustomSearchableSelectTextMenu<T extends ISearchableSelectItem> extends StatelessWidget {

  final List<T> items;
  final T? selectedItem;
  final void Function(T) onSelected;
  final bool addEmptyItem;
  final String? label;
  final EdgeInsets? margins;
  final bool enabled;
  final bool scrollToSelectedItem;
  final SearchableScrollType scrollType;


  CustomSearchableSelectTextMenu({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.scrollToSelectedItem = true,
    this.addEmptyItem = false,
    this.enabled = true,
    this.scrollType = SearchableScrollType.filter,
    this.label,
    this.margins,
  }) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    textEditingController.setTextWithCursor(selectedItem?.title ?? "");

    return CustomFormTextField(
      padding: margins,
      controller: textEditingController,
      readOnly: true,
      autoFocus: false,
      label: label,
      enabled: enabled,
      trailingWidget: const Icon(Icons.arrow_drop_down),
      onTap: (){
        showSelectSearchableItems(
          context,
          items: items,
          scrollToSelectedItem: scrollToSelectedItem,
          scrollType: scrollType,
          selectedItem: selectedItem,
          onSelected: (selected){
            textEditingController.setTextWithCursor(selected.title);
            onSelected.call(selected);
          },
          title: label
        );
      },
    );
  }
}