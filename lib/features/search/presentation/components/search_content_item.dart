import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/utils/search_utils.dart';
import 'package:hadith/features/search/presentation/model/search_content.dart';


class SearchContentItem extends StatelessWidget {
  final SearchContent searchContent;
  final SearchParam searchParam;

  const SearchContentItem({
    Key? key,
    required this.searchContent,
    required this.searchParam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final searchResult = SearchUtils.getSelectedText(context,
        content: searchContent.content,
        searchParam: searchParam,
        textStyle: Theme.of(context).textTheme.bodyLarge
    );

    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 9),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: searchResult,
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16,),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  searchContent.source,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
