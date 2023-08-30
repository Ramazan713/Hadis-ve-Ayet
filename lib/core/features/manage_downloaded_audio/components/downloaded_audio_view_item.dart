import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        title: Text(content,style: Theme.of(context).textTheme.bodyLarge,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        trailing: IconButton(
          onPressed: onDeletePressed,
          icon: Icon(
            Icons.delete_forever,
            color: Theme.of(context).colorScheme.error,
          )
        ),
      ),
    );
  }
}
