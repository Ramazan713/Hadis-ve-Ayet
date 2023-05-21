import 'package:flutter/material.dart';
import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';


class HadithItem extends StatelessWidget {

  final HadithListModel hadithList;
  final Function()? onFavoriteClick;
  final Function()? onListClick;

  const HadithItem({Key? key,required this.hadithList, this.onFavoriteClick, this.onListClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onLongPress: (){

        },
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 13, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${hadithList.rowNumber} - ${hadithList.hadith.id}",
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    const SizedBox(
                      width: 33,
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  hadithList.hadith.content,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 13,
                ),
                Text("- ${hadithList.hadith.source}",
                    textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                    ),
                    IconButton(
                      onPressed: onFavoriteClick,
                      icon: hadithList.isInFavorite? const Icon(
                        Icons.favorite,color: Colors.red,
                      ): const Icon(Icons.favorite),
                    ),
                    IconButton(
                      onPressed: onListClick,
                      icon: Icon(hadithList.isInAnyList? Icons.library_add_check:Icons.library_add),
                    ),
                    const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
