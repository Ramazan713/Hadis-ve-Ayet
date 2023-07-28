

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_bloc.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_event.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_state.dart';
import 'package:hadith/core/presentation/components/custom_list_tile.dart';
import 'package:hadith/core/presentation/dialogs/show_select_edition.dart';
import 'package:hadith/core/presentation/dialogs/show_select_slider.dart';
import 'package:hadith/core/presentation/dialogs/show_manage_downloaded_audios.dart';

void showEditAudioSettingDia(BuildContext context){

  final audioBloc = context.read<AudioSettingBloc>();
  audioBloc.add(AudioSettingEventLoadData());

  void onNavigateBack(){
    Navigator.pop(context);
  }

  Widget getDivider(){
    return const Divider(
      height: 2,
    );
  }

  Widget getHeader(BuildContext context){
    return Row(
      children: [
        const SizedBox(width: 48,),
        Expanded(
          child: Text(
            "Ses Ayarları",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        IconButton(
          onPressed: onNavigateBack,
          icon: const Icon(Icons.close),
        )
      ],
    );
  }

  Widget getAudioEditionSection(){
    return BlocSelector<AudioSettingBloc,AudioSettingState,AudioEdition?>(
      selector: (state) => state.selectedEdition,
      builder: (context,audioEdition){
        return CustomListTile(
          title: "Kıraat seç",
          subTitle: audioEdition?.name??"Seçilmedi",
          onTap: (){
            showSelectEdition(context);
          },
        );
      },
    );
  }

  Widget getFollowAudioSection(){
    return BlocSelector<AudioSettingBloc,AudioSettingState,bool>(
      selector: (state)=>state.followAudioText,
      builder: (context,followAudioText){
        return SwitchListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          value: followAudioText,
          title: const Text("Yazıyı takip et"),
          onChanged: (newValue){
            audioBloc.add(AudioSettingEventSetFollowAudio(audioFollowText: newValue));
          },
        );
      },
    );
  }

  Widget getEditDownloadedAudioSection(){
    return CustomListTile(
      title: "İndirilen ses dosyalarını yönet",
      onTap: (){
        showManageDownloadedAudios(context);
      },
    );
  }

  Widget getSpeedSection(){
    return BlocSelector<AudioSettingBloc,AudioSettingState,double>(
      selector: (state)=>state.audioSpeed,
      builder: (context,audioSpeed){
        return CustomListTile(
          title: "Ses hızı",
          subTitle: audioSpeed.toStringAsFixed(1),
          onTap: (){
            showSelectSlider(
                context,
                title: "Audio ses hızını belirle",
                min: 0.5,
                max: 2.0,
                value: audioSpeed,
                onClose: (newValue){
                  audioBloc.add(AudioSettingEventSetSpeed(speed: newValue));
                }
            );
          },
        );
      },
    );
  }

  Widget getBodyContent(){
    return Column(
      children: [
        getAudioEditionSection(),
        getDivider(),
        getEditDownloadedAudioSection(),
        getDivider(),
        getFollowAudioSection(),
        getDivider(),
        getSpeedSection()
      ],
    );
  }

  showDialog(
      context: context,
      useSafeArea: true,
      builder: (context){
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 13,vertical: 13),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getHeader(context),
                  getDivider(),
                  getBodyContent()
                ],
              )
            ),
          ),
        );
      }
  );

}