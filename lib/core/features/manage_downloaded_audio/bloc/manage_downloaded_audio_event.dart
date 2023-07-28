

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';

abstract class IManageAudioEvent{}

class ManageAudioEventInitListener extends IManageAudioEvent{}

class ManageAudioEventClearMessage extends IManageAudioEvent{}

class ManageAudioEventLoadData extends IManageAudioEvent{
  final String? identifier;
  ManageAudioEventLoadData({required this.identifier});
}

class ManageAudioEventChangeAudioViewType extends IManageAudioEvent{
  final DownloadedAudioViewEnum audioViewEnum;
  ManageAudioEventChangeAudioViewType(this.audioViewEnum);
}

class ManageAudioEventDelete extends IManageAudioEvent{
  final DownloadedAudioViewModel model;
  ManageAudioEventDelete(this.model);
}

class ManageAudioEventSetIdentifier extends IManageAudioEvent{
  final String identifier;
  ManageAudioEventSetIdentifier(this.identifier);
}




