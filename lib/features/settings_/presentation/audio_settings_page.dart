
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_bloc.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_event.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_state.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/dialogs/show_manage_downloaded_audios.dart';
import 'package:hadith/core/presentation/dialogs/show_select_edition.dart';
import 'package:hadith/core/presentation/dialogs/show_select_slider.dart';
import 'package:hadith/themes/custom/get_setting_theme.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsAudioPage extends StatelessWidget {
  const SettingsAudioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final audioBloc = context.read<AudioSettingBloc>();
    audioBloc.add(AudioSettingEventLoadData());

    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: const Text("Ses Ayarları"),
          child: SettingsList(
            lightTheme: getSettingThemeData(context),
            sections: [
              SettingsSection(
                tiles: [
                  getAudioEditionTile(),
                  getFollowAudioTile(),
                  getEditDownloadedAudioSection(),
                  getSpeedTile()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomSettingsTile getAudioEditionTile(){
    return CustomSettingsTile(
      child: BlocSelector<AudioSettingBloc,AudioSettingState,AudioEdition?>(
        selector: (state)=>state.selectedEdition,
        builder: (context,audioEdition){
          return SettingsTile(
            title: const Text("Kıraat seç"),
            description: Text(audioEdition?.name??"Seçilmedi"),
            onPressed: (context){
              showSelectEdition(context);
            },
          );
        },
      ),
    );
  }

  CustomSettingsTile getFollowAudioTile(){
    return  CustomSettingsTile(
      child: BlocSelector<AudioSettingBloc,AudioSettingState,bool>(
        selector: (state)=>state.followAudioText,
        builder: (context,followAudioText){
          return SettingsTile.switchTile(
            title: const Text("Yazıyı takip et"),
            initialValue: followAudioText,
            onToggle: (newValue){
              context.read<AudioSettingBloc>()
                  .add(AudioSettingEventSetFollowAudio(audioFollowText: newValue));
            },
          );
        },
      ),
    );
  }

  CustomSettingsTile getSpeedTile(){
    return CustomSettingsTile(
      child: BlocSelector<AudioSettingBloc,AudioSettingState,double>(
        selector: (state)=>state.audioSpeed,
        builder: (context,audioSpeed){
          return SettingsTile(
            title: const Text("Ses hızı"),
            description: Text(audioSpeed.toStringAsFixed(1)),
            onPressed: (context){
              showSelectSlider(
                  context,
                  title: "Audio ses hızını belirle",
                  min: 0.5,
                  max: 2.0,
                  value: audioSpeed,
                  onClose: (newValue){
                    context.read<AudioSettingBloc>()
                        .add(AudioSettingEventSetSpeed(speed: newValue));
                  }
              );
            },
          );
        },
      ),
    );
  }

  SettingsTile getEditDownloadedAudioSection(){
    return SettingsTile(
      title: const Text("İndirilen ses dosyalarını yönet"),
      onPressed: (context){
        showManageDownloadedAudios(context);
      },
    );
  }

}
