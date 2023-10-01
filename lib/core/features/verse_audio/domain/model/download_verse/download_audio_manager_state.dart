import 'package:hadith/core/features/verse_audio/domain/enums/download_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:equatable/equatable.dart';
import 'download_audio_param.dart';

part 'download_audio_manager_state.g.dart';

@JsonSerializable(explicitToJson: true)
class DownloadAudioManagerState extends Equatable{
  final int current;
  final int total;
  final String? error;
  final DownloadEnum downloadEnum;
  final VerseDownloadedVoiceModel? voiceModel;
  final DownloadAudioParam? currentParam;
  final DownloadAudioParam? lastDownloaded;
  final List<DownloadAudioParam> queueParams;

  const DownloadAudioManagerState({
    required this.current,
    required this.total,
    this.voiceModel,
    required this.downloadEnum,
    this.error,
    this.currentParam,
    required this.queueParams,
    this.lastDownloaded
  });

  DownloadAudioManagerState copyWith({
    int? current,
    int? total,
    VerseDownloadedVoiceModel? voiceModel,
    DownloadEnum? downloadEnum,
    String?error,bool setError = false,
    DownloadAudioParam? currentParam, bool setCurrentParam = false,
    DownloadAudioParam? lastDownloaded, bool setLastDownloaded = false,
    List<DownloadAudioParam>? queueParams,
  }){
    return DownloadAudioManagerState(
        current: current??this.current,
        total: total??this.total,
        error: setError?error:error??this.error,
        voiceModel: voiceModel??this.voiceModel,
        downloadEnum: downloadEnum??this.downloadEnum,
        currentParam: setCurrentParam ? currentParam : this.currentParam,
        queueParams: queueParams ?? this.queueParams,
        lastDownloaded: setLastDownloaded ? lastDownloaded : this.lastDownloaded
    );
  }

  static DownloadAudioManagerState init(){
    return const DownloadAudioManagerState(
        current: 0,
        total: 0,
        downloadEnum: DownloadEnum.idle,
        voiceModel: null,
        queueParams: []
    );
  }

  int get getProgress100{
    if(total==0) {
      return 0;
    }
    return ((current/total)*100).toInt();
  }

  double get getProgressPercentage => getProgress100.toDouble() / 100;


  String get getProgressContent => "$current / $total";

  String _getQueueInfo(){
    if(queueParams.isEmpty) return "";
    return "-- (${queueParams.length} kuyrukta)";
  }

  String get getBodyContent{
    return error ?? "($getProgressContent) - ${voiceModel?.surahName ?? "?"} ${voiceModel?.verseNumberTr ?? "?"}  ${_getQueueInfo()}";
  }

  bool isActive(){
    return [DownloadEnum.retry,DownloadEnum.pause,DownloadEnum.error,DownloadEnum.downloading].contains(downloadEnum);
  }

  factory DownloadAudioManagerState.fromJson(Map<String, dynamic> json) => _$DownloadAudioManagerStateFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadAudioManagerStateToJson(this);

  @override
  List<Object?> get props => [
    current,total,voiceModel,downloadEnum,error,
    currentParam, queueParams, lastDownloaded
  ];

}