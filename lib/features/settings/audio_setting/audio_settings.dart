import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/features/settings/audio_setting/bloc/audio_setting_bloc.dart';
import 'package:hadith/features/settings/audio_setting/bloc/audio_setting_event.dart';
import 'package:hadith/features/settings/audio_setting/bloc/audio_setting_state.dart';
import 'package:hadith/dialogs/show_select_slider.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/features/verse/common_dialogs/show_select_edition.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/themes/custom/get_setting_theme.dart';
import 'package:hadith/widgets/custom_sliver_appbar.dart';
import 'package:hadith/widgets/custom_sliver_nested_scrollview.dart';
import 'package:settings_ui/settings_ui.dart';

class AudioSettings extends StatelessWidget {
  static const String id = "AudioSettings";
  AudioSettings({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final audioSettingBloc = context.read<AudioSettingBloc>();

    audioSettingBloc.add(AudioSettingEventGetShared());

    return Scaffold(
        body: CustomSliverNestedView(
          context,
          scrollController: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const CustomSliverAppBar(
                title: Text("Ses Ayarları"),
              )
            ];
          },
          child: SafeArea(
            child: SettingsList(
              lightTheme: getSettingThemeData(context),
              sections: [
                SettingsSection(
                  tiles: [

                    CustomSettingsTile(
                      child: BlocSelector<AudioSettingBloc,AudioSettingState,AudioEdition?>(
                        selector: (state)=>state.audioEdition,
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
                    ),

                    CustomSettingsTile(
                      child: BlocSelector<AudioSettingBloc,AudioSettingState,bool>(
                        selector: (state)=>state.followAudioText,
                        builder: (context,followAudioText){
                          return SettingsTile.switchTile(
                            title: const Text("Yazıyı takip et"),
                            initialValue: followAudioText,
                            onToggle: (newValue){
                              audioSettingBloc.add(AudioSettingEventSetFollowAudio(audioFollowText: newValue));
                            },
                          );
                        },
                      ),
                    ),

                    CustomSettingsTile(
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
                                  audioSettingBloc.add(AudioSettingEventSetSpeed(speed: newValue));
                                }
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
      ));
  }
}


class _SelectAudioQuality extends StatelessWidget {
  const _SelectAudioQuality({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioSettingBloc = context.read<AudioSettingBloc>();
    return  CustomSettingsTile(
      child: BlocSelector<AudioSettingBloc,AudioSettingState,AudioQualityEnum>(
        selector: (state)=>state.audioQuality,
        builder: (context,audioQuality){
          return SettingsTile(
            title: const Text("Ses kalitesi"),
            description: Text(audioQuality.quality.toString()),
            onPressed: (context){
              final items = AudioQualityEnum.values.map((e) =>
                  ItemLabelModel(item: e,label: e.quality.toString())).toList();
              showSelectRadioEnums<AudioQualityEnum>(
                  context,
                  currentValue: ItemLabelModel(item: audioQuality,label: audioQuality.quality.toString()),
                  radioItems: items,
                  closeListener: (newValue){
                    audioSettingBloc.add(AudioSettingEventSetQuality(audioQuality: newValue.item));
                  }
              );
            },
          );
        },
      ),
    );
  }
}
