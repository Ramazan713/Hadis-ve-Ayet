import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/db/entities/helper/item_count_model.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';

class SectionItem extends StatelessWidget {
  final SectionViewModel sectionItem;
  final int? rowNumber;
  final void Function() onTap;

  const SectionItem(
      {Key? key,
        required this.sectionItem,
        required this.onTap,
        required this.rowNumber
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText2Style = Theme.of(context).textTheme.bodyText2;

    return Card(
        color: Theme.of(context).colorScheme.secondary,
        child: ListTile(
          title: Text(
            sectionItem.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.bookOpenReader,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(
                height: 7,
              ),
              rowNumber != null ? Text(
                  "$rowNumber",
                  style: bodyText2Style?.copyWith(
                      fontSize: (bodyText2Style.fontSize ?? 3) - 3))
                  : const SizedBox()
            ],
          ),
          subtitle: Text(
            "${sectionItem.topicsCount} başlık",
            style: bodyText2Style,
          ),
          onTap: onTap,
        ));
  }
}
