import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_collection.dart';
import 'package:hadith/features/islamic_info/shared/presentation/components/info_detail_item.dart';

class InfoCollectionItem extends StatelessWidget {
  final IslamicInfoCollection collection;
  final bool showVertical;
  final ScrollController scrollController;
  final double contentFontSize;

  const InfoCollectionItem({
    Key? key,
    required this.collection,
    required this.showVertical,
    required this.scrollController,
    required this.contentFontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = collection.infoTitle.description;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
          side: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2)
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9,horizontal:9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              collection.infoTitle.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: contentFontSize
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (description != null)
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: contentFontSize
                    ),
                  )
              ),
            ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              itemCount: collection.infoItems.length,
              itemBuilder: (context, index) {
                final item = collection.infoItems[index];
                return InfoDetailItem(
                  infoItem: item,
                  showHorizontal: showVertical,
                  fontSize: contentFontSize
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
