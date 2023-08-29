
import 'package:flutter/material.dart';
import 'package:hadith/features/search/presentation/search_page.dart';

extension SearchPageFunctionsExt on SearchPage{

  void setTextBar(String text){
    textEditingController.text = text;
    textEditingController.selection =
        TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length));
  }

  void unFocusBar(BuildContext context){
    FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
  }

}