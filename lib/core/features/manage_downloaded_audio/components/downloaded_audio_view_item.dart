import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';

class DownloadedAudioViewItem extends StatelessWidget {
  final DownloadedAudioViewModel model;
  final bool showEditionName;
  final void Function()? onDeletePressed;

  const DownloadedAudioViewItem({
    Key? key,
    required this.model,
    this.onDeletePressed,
    this.showEditionName = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final content = showEditionName ?
        "${model.title} (${model.editionName})":
        model.title;

    return CardListTile(
      margins: const EdgeInsets.symmetric(vertical: 3),
      title: Text(content,style: Theme.of(context).textTheme.bodyLarge,),
      borderWidth: 1,
      trailing: IconButton(
        onPressed: onDeletePressed,
        icon: Icon(
          Icons.delete_forever,
          color: Theme.of(context).colorScheme.error,
        )
      ),
    );
  }
}
