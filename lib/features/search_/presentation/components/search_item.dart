import 'package:flutter/material.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/features/search_/presentation/model/search_result.dart';

class SearchItem extends StatelessWidget {
  final SearchResult searchResult;
  final int position;
  final void Function() onClick;

  const SearchItem({
    Key? key,
    required this.searchResult,
    required this.position,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color= kIsTextBlackWithLightPrimary ? Colors.black:Theme.of(context).textTheme.bodyMedium?.color;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 13,vertical: 7),
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 19,horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 7,),
              Text("$position",style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,color: color),),
              const SizedBox(width: 29,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchResult.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: color),),
                    const SizedBox(height: 7,),
                    Text("${searchResult.resultCount} sonuc bulundu",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),),
                  ],
                ),
              ),
              IconButton(onPressed: onClick, icon: Icon(Icons.arrow_forward,size: 30,color: color,))
            ],
          ),
        ),
      ),
    );
  }
}
