import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/components/info_item.dart';


class InfoTitleItem extends StatelessWidget {
  final IslamicInfo info;
  final Axis itemAxis;
  final ScrollController scrollController;
  const InfoTitleItem({Key? key, required this.info,required this.itemAxis,
    required this.scrollController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = info.infoTitle.description;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
          side: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2)
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7,horizontal:7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              info.infoTitle.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            if (description != null)
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(description,style: Theme.of(context).textTheme.bodyLarge,)) else const SizedBox(),
            ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              itemCount: info.infoItems.length,
              itemBuilder: (context, index) {
                final item = info.infoItems[index];
                return InfoItem(
                  infoItem: item,
                  itemAxis: itemAxis,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
