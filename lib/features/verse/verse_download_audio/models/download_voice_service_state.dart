


import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_enum.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_voice_service_state.g.dart';

@JsonSerializable(explicitToJson: true)
class DownloadVoiceServiceState extends Equatable{
  final int current;
  final int total;
  final String? error;
  final DownloadEnum downloadEnum;
  final DownloadVoiceEntity? voiceModel;

  const DownloadVoiceServiceState({required this.current,required this.total,
    this.voiceModel,required this.downloadEnum, this.error});

  DownloadVoiceServiceState copyWith({int? current,int? total,DownloadVoiceEntity? voiceModel,
    DownloadEnum? downloadEnum,String?error,bool setError = false}){
    return DownloadVoiceServiceState(current: current??this.current, total: total??this.total,
        error: setError?error:error??this.error,
        voiceModel: voiceModel??this.voiceModel,downloadEnum: downloadEnum??this.downloadEnum);
  }

  static DownloadVoiceServiceState init(){
    return const DownloadVoiceServiceState(current: 0, total: 0, downloadEnum: DownloadEnum.idle,
        voiceModel: null);
  }

  int getProgress100(){
    if(total==0) {
      return 0;
    }
    return ((current/total)*100).toInt();
  }
  String getProgressContent(){
    return "$current / $total";
  }

  String getBodyContent(){
    return error ?? "(${getProgressContent()}) - ${voiceModel?.surahName??""} ${voiceModel?.verseNumber??""}";
  }

  bool isActive(){
    return [DownloadEnum.retry,DownloadEnum.pause,DownloadEnum.error,DownloadEnum.downloading].contains(downloadEnum);
  }

  @override
  String toString() {
    return """DownloadVoiceState(current=$current, total=$total, downloadEnum=$downloadEnum, ...)""";
  }

  factory DownloadVoiceServiceState.fromJson(Map<String, dynamic> json) => _$DownloadVoiceServiceStateFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadVoiceServiceStateToJson(this);

  @override
  List<Object?> get props => [current,total,voiceModel,downloadEnum,error];

}