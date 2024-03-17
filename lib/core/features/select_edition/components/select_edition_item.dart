import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/show_manage_edition_audios_dia.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_event.dart';
import 'package:hadith/core/features/select_edition/enums/select_edition_menu_item.dart';
import 'package:hadith/core/features/select_edition/models/select_audio_edition.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/basic_audio_request/basic_audio_request.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/play_basic_audio.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';


class SelectEditionItem extends StatelessWidget {

  final SelectAudioEdition edition;
  final SelectAudioEdition? selectedSelectEdition;
  final BasicAudioRequest audioRequest;
  final bool isFavorite;

  const SelectEditionItem({
    super.key,
    required this.edition,
    required this.audioRequest,
    required this.isFavorite,
    this.selectedSelectEdition,
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
        title: Row(
          children: [
            if(isFavorite)
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(Icons.star)
              ),
            Flexible(
              child: Text(edition.audioEdition.name)
            )
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 3),
        secondary: IntrinsicWidth(
          child: Row(
            children: [
              PlayBasicAudio(
                identifier: edition.audioEdition.identifier,
                onPlay: (){
                  _play(context);
                },
              ),
              CustomDropdownIconMenu(
                items: SelectEditionMenuItem.getMenuItems(isFavorite),
                onSelected: (selectedItem){
                  _handleMenuItem(
                    menuItem: selectedItem,
                    context: context
                  );
                }
              ),
            ],
          ),
        ),
        onChanged: (selected){
          _select(context);
        }
      ),
    );
  }

  void _select(BuildContext context){
    context.read<SelectEditionBloc>()
        .add(EditionEventSetEdition(edition: edition)
    );
  }
  void _play(BuildContext context){
    context.read<BasicAudioBloc>().add(BasicAudioEventRequestAudio(
      identifier: edition.audioEdition.identifier,
      request: audioRequest,
      audioQuality: edition.qualityEnum
    ));
  }

  void _handleMenuItem({
    required BuildContext context,
    required SelectEditionMenuItem menuItem,
  }){
    final bloc = context.read<SelectEditionBloc>();
    switch(menuItem){
      case SelectEditionMenuItem.goToDownloaded:
        showManageEditionAudiosDia(context, audioEdition: edition.audioEdition);
        break;
      case SelectEditionMenuItem.addFavorite:
        bloc.add(EditionEventAddFavorite(edition: edition));
        break;
      case SelectEditionMenuItem.removeFavorite:
        bloc.add(EditionEventDeleteFavorite(edition: edition));
        break;
    }
  }

}