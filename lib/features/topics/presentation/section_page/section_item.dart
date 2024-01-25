import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';

class SectionItem extends StatelessWidget {
  final SectionViewModel sectionItem;
  final int? rowNumber;
  final void Function() onTap;
  final EdgeInsets? margins;

  const SectionItem({
    Key? key,
    required this.sectionItem,
    required this.onTap,
    required this.rowNumber,
    this.margins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CardListTile(
      margins: margins ?? EdgeInsets.zero,
      defaultColor: Theme.of(context).colorScheme.secondaryContainer,
      title: Text(
        sectionItem.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: getLeading(context),
      subtitle: Text(
        "${sectionItem.topicsCount} başlık",
      ),
      onTap: onTap,
    );
  }

  Widget getLeading(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(FontAwesomeIcons.bookOpenReader),
        const SizedBox(
          height: 7,
        ),
        getRowNumberWidget(context)
      ],
    );
  }

  Widget getRowNumberWidget(BuildContext context){
    if(rowNumber == null) return const SizedBox();
    return Text(
        "$rowNumber",
        style: Theme.of(context).textTheme.bodySmall
    );
  }

}
