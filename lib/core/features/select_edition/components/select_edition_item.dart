import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/play_basic_audio.dart';


class SelectEditionItem extends StatelessWidget {

  final AudioEdition edition;
  final AudioEdition? selectedEdition;
  final AudioQualityEnum audioQuality;
  final void Function() onNextClick;
  final void Function() onSelectClick;

  const SelectEditionItem({
    Key? key,
    required this.edition,
    required this.audioQuality,
    this.selectedEdition,
    required this.onNextClick,
    required this.onSelectClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.circular(13);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 1),
      child: RadioListTile(
          toggleable: false,
          value: edition,
          selected: edition == selectedEdition,

          shape: RoundedRectangleBorder(
              borderRadius: borderRadius
          ),
          groupValue: selectedEdition,
          title: Text(edition.name),
          contentPadding: const EdgeInsets.symmetric(horizontal: 3),
          secondary: IntrinsicWidth(
            child: Row(
              children: [
                PlayBasicAudio(
                  identifier: edition.identifier,
                  audioQuality: audioQuality,
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