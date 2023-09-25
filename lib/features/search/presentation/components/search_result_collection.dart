import 'package:flutter/material.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/features/search/presentation/components/search_content_item.dart';
import 'package:hadith/features/search/presentation/components/search_show_all.dart';
import 'package:hadith/features/search/domain/model/search_result.dart';

class SearchResultCollection extends StatelessWidget {
  final SearchResult searchResult;
  final SearchParam searchParam;
  final void Function() onDetailClick;

  const SearchResultCollection({
    Key? key,
    required this.searchResult,
    required this.searchParam,
    required this.onDetailClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 19,horizontal: 3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${searchResult.title}(${searchResult.resultCount} sonuc)",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500
                  ),
                ),
                TextButton(
                    onPressed: onDetailClick,
                    child: const Text("daha fazlası")
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: getResultItems(),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getResultItems(){
    final List<Widget> resultItems = [];
    for (var e in searchResult.searchContents) {
      resultItems.add(SearchContentItem(
          searchContent: e,
          searchParam: searchParam
      ));
    }

    if(searchResult.resultCount > K.searchResultCollectionSize){
      resultItems.add(
          SearchShowAll(onTap: onDetailClick,)
      );
    }
    return resultItems;
  }


}

