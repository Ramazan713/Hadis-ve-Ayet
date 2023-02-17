

import 'package:equatable/equatable.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/common_models/verse_model.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/audio_attribute_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';

class VerseAudioState extends Equatable{
  final VerseAudioModel? currentAudio;
  final AudioAttributeState? audioAttributeState;
  final String?message;
  final bool showAudioOption;
  final bool askDownload;
  final VerseModel?tempModel;
  final QuranAudioOption?tempOption;
  final OriginTag originTag;
  final bool showAudioPlayerWidget;
  final bool askNotificationPermission;
  final bool askInterruptAndDownload;
  final bool followAudioText;

  const VerseAudioState({this.currentAudio,this.message,required this.showAudioOption,
    required this.askDownload,this.tempModel,this.tempOption,required this.originTag,
    required this.showAudioPlayerWidget,required this.askNotificationPermission,
    required this.askInterruptAndDownload,required this.followAudioText,
    this.audioAttributeState
  });

  VerseAudioState copyWith({VerseAudioModel? currentAudio,bool setAudio=false,
    String?message,bool setMessage=false,bool? showAudioOption,bool?askDownload,
    VerseModel?tempModel,QuranAudioOption?tempOption,bool setTempData=false,
    OriginTag?originTag,bool?showAudioPlayerWidget,bool?askNotificationPermission,
    bool?askInterruptAndDownload,bool?followAudioText,
    AudioAttributeState? audioAttributeState,bool setAudioAttributeState=false
  }){
    return VerseAudioState(
        currentAudio: setAudio?currentAudio:this.currentAudio,
        message: setMessage?message:this.message,
        showAudioOption: showAudioOption??this.showAudioOption,
        askDownload: askDownload??this.askDownload,
        tempModel: setTempData?tempModel:this.tempModel,
        tempOption: setTempData?tempOption:this.tempOption,
        originTag: originTag??this.originTag,
        showAudioPlayerWidget: showAudioPlayerWidget??this.showAudioPlayerWidget,
        askNotificationPermission: askNotificationPermission??this.askNotificationPermission,
        askInterruptAndDownload: askInterruptAndDownload??this.askInterruptAndDownload,
        followAudioText: followAudioText??this.followAudioText,
        audioAttributeState: setAudioAttributeState?audioAttributeState:this.audioAttributeState
    );
  }

  AudioEnum getAudioEnum(){
    return currentAudio?.audioEnum ?? AudioEnum.idle;
  }
  VerseAudioEntity? getAudio(){
    return currentAudio?.audio;
  }

  int? currentSavePointId(){
    return audioAttributeState?.savepointId;
  }

  bool isActive(){
    return [AudioEnum.pause,AudioEnum.running].contains(getAudioEnum());
  }

  static VerseAudioState init(){
    return const VerseAudioState(showAudioOption: false,askDownload: false,originTag: OriginTag.surah,
        showAudioPlayerWidget: false,askNotificationPermission:false,askInterruptAndDownload:false,
        followAudioText: true
    );
  }

  @override
  List<Object?> get props => [currentAudio,message,showAudioOption,askDownload,tempOption,tempModel,originTag,
    showAudioPlayerWidget,askNotificationPermission,askInterruptAndDownload,followAudioText,
    audioAttributeState
  ];
}