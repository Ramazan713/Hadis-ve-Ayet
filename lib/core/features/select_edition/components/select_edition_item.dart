import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/select_edition/models/select_audio_edition.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/play_basic_audio.dart';


class SelectEditionItem extends StatelessWidget {

  final SelectAudioEdition edition;
  final SelectAudioEdition? selectedSelectEdition;
  final void Function() onNextClick;
  final void Function() onSelectClick;
  final void Function() onPlay;

  const SelectEditionItem({
    super.key,
    required this.edition,
    this.selectedSelectEdition,
    required this.onNextClick,
    required this.onSelectClick,
    required this.onPlay
  });

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.circular(13);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 1),
      child: RadioListTile(
        toggleable: false,
        value: edition.audioEdition.identifier,
        selected: edition.audioEdition.identifier == selectedSelectEdition?.audioEdition.identifier,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius
        ),
        groupValue: selectedSelectEdition?.audioEdition.identifier,
        title: Text(edition.audioEdition.name),
        contentPadding: const EdgeInsets.symmetric(horizontal: 3),
        secondary: IntrinsicWidth(
          child: Row(
            children: [
              PlayBasicAudio(
                identifier: edition.audioEdition.identifier,
                onPlay: onPlay,
              ),
              IconButton(
                onPressed: onNextClick,
                icon: const Icon(Icons.arrow_forward)
              )
            ],
          ),
        ),
        onChanged: (selected){
          onSelectClick();
        }
      ),
    );
  }
}